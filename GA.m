%% GA first modified by KM 31 Dec 2020
function [Results]=GA(Out)
%% Setting and definition of variables
% rng('default')

Results.AllBestFitnesses=zeros(Out.NRun,Out.MaxIter);
Results.AllBestSolution=zeros(Out.NRun,Out.NDecisionVariable);
Results.Feasible=zeros(Out.NRun,Out.MaxIter);
Results.NFE=zeros(Out.NRun,Out.MaxIter);
Results.NFEAll=0;
NFEAll=0;
Results.PenaltyCount=0;
PenaltyCountAll=0;
Npopulation=Out.Npopulation;
NDecisionVariable=Out.NDecisionVariable; % Problem dimension (number of decision variables)


[LowerBound, UpperBound]=EngineeringBounds(Out.EngFunction);
PC=Out.pc;
PM=Out.pm;
MU=Out.mu;
gamma=Out.gamma;
NoCrossOver=2*round(PC*Npopulation/2);  % Number of Offsprings (Parnets)
NoMutation=round(PM*Npopulation);      % Number of Mutants

ParrentSlectionType=Out.ParrentSlectionType;
UseRouletteWheelSelection=strcmp(ParrentSlectionType,'Roulette Wheel');
UseTournamentSelection=strcmp(ParrentSlectionType,'Tournament');
% UseRandomSelection=strcmp(ParrentSlectionType,'Random');
if UseRouletteWheelSelection
    beta=8;         % Selection Pressure
end
if UseTournamentSelection
    TournamentSize=2;   % Tournamnet Size
end

%% Main loop of indepdendent runs
for iRun=1:Out.NRun
    %% 1. Initialization
    empty_individual.Position=zeros(1,NDecisionVariable);
    empty_individual.Cost=zeros(1);
    pop=repmat(empty_individual,Out.Npopulation,1);
    % Initialize Position
    Position=init(Out); % Initialization of solutions
    for i=1:Npopulation
        pop(i).Position(:)=Position(i,:);
        [pop(i).Cost, BoolPenalty]=EngineeringFitness(pop(i).Position,1,Out.EngFunction); % Fitness evaluation
        NFEAll=NFEAll+1;
        if BoolPenalty==1
            PenaltyCountAll=PenaltyCountAll+1;
        end
    end
    
    % Sort Population
    Costs=[pop.Cost];
    [Costs, SortOrder]=sort(Costs);
    pop=pop(SortOrder);
    % Store Cost
    WorstCost=pop(end).Cost;
    
    
    %% GA Main Loop
    Bestfit=zeros(1,Out.MaxIter);
    for iIter=1:Out.MaxIter
        NFE=0;PenaltyCount=0;
        %% selection
        if UseRouletteWheelSelection
            % Calculate Selection Probabilities
            P=exp(-beta*Costs/WorstCost);
            P=P/sum(P);
        end
        % Crossover
        popc=repmat(empty_individual,NoCrossOver/2,2);
        for k=1:NoCrossOver/2
            % Select Parents Indices
%             if UseRouletteWheelSelection
%                 i1=RouletteWheelSelection(P);
%                 i2=RouletteWheelSelection(P);
%             end
            if UseTournamentSelection
                i1=TournamentSelection(pop,TournamentSize);
                i2=TournamentSelection(pop,TournamentSize);
            end
%             if UseRandomSelection
%                 i1=randi([1 Out.Npopulation]);
%                 i2=randi([1 Out.Npopulation]);
%             end
            
            % Select Parents
            p1=pop(i1);
            p2=pop(i2);
            % Apply Crossover
            [popc(k,1).Position,popc(k,2).Position]=...
                Crossover(p1.Position,p2.Position,gamma,LowerBound,UpperBound);
            
            for kk=1:2
                [popc(k,kk).Cost, BoolPenalty]=EngineeringFitness(popc(k,kk).Position,1,Out.EngFunction); % Fitness evaluation
                if BoolPenalty==1
                    PenaltyCountAll=PenaltyCountAll+1;
                    PenaltyCount=PenaltyCount+1;
                end
                NFEAll=NFEAll+1;
                NFE=NFE+1;
            end
            
        end
        popc=popc(:);
        
        % Mutation
        popm=repmat(empty_individual,NoMutation,1);
        for k=1:NoMutation
            % Select Parent
            i=randi([1 Npopulation]);
            p=pop(i);
            
            % Apply Mutation
            popm(k).Position=Mutate(p.Position,MU,LowerBound,UpperBound);
            [popm(k).Cost, BoolPenalty]=EngineeringFitness(popm(k).Position,1,Out.EngFunction); % Fitness evaluation
            if BoolPenalty==1
                PenaltyCountAll=PenaltyCountAll+1;
                PenaltyCount=PenaltyCount+1;
            end
            NFEAll=NFEAll+1;
            NFE=NFE+1;
        end
        
        pop=[pop; popc; popm];
        % Sort Population
        Costs=[pop.Cost];
        [Costs, SortOrder]=sort(Costs);
        pop=pop(SortOrder);
        
        % Truncation
        pop=pop(1:Npopulation);
        Costs=Costs(1:Npopulation);
        
        Bestfit(iIter)=Costs(1); % Best fitness found at iteration t
        Results.NFE(iRun,iIter)=NFE;
        Results.Feasible(iRun,iIter)=NFE-PenaltyCount;
    end
    %% Saving results of the solution
    Results.AllBestSolution(iRun,:)=pop(1).Position;
    Results.AllBestFitnesses(iRun,:)=Bestfit;
    
end
Results.NFEAll=NFEAll;
Results.PenaltyCount=PenaltyCountAll;

