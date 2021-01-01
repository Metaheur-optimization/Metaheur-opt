%% GA first modified by KM 31 Dec 2020
function [AllBestFitnesses,AllBestSolution]=GA(Out)
%% Setting and definition of variables

AllBestFitnesses=zeros(Out.NRun,Out.MaxIter);
AllBestSolution=zeros(Out.NRun,Out.NDecisionVariable);

VarSize=[1 Out.NDecisionVariable];   % Size of Decision Variables Matrix
nc=2*round(Out.pc*Out.Npopulation/2);  % Number of Offsprings (Parnets)
nm=round(Out.mu*Out.Npopulation);      % Number of Mutants
gamma=0.05;
ANSWER=Out.ParrentSlectionType;
UseRouletteWheelSelection=strcmp(ANSWER,'Roulette Wheel');
UseTournamentSelection=strcmp(ANSWER,'Tournament');
UseRandomSelection=strcmp(ANSWER,'Random');
if UseRouletteWheelSelection
    beta=8;         % Selection Pressure
end
if UseTournamentSelection
    TournamentSize=3;   % Tournamnet Size
end

%[LowerBound, UpperBound]=EngineeringBounds(EngFunction)
%% Main loop of indepdendent runs
for iRun=1:Out.NRun
%% 1. Initialization
empty_individual.Position=[];
empty_individual.Cost=[];

pop=repmat(empty_individual,Out.Npopulation,1);

for i=1:Out.Npopulation
    % Initialize Position
    pop(i).Position=unifrnd(Out.LowerBound(1),Out.UpperBound(1),VarSize);
   % pop(i).Cost=FittnessFunction(pop(i).Position);
     pop(i).Cost=fitness(pop(i).Position,1,Out);
end

 PositionMemory=[pop.Position]; % Memorise Position of solutions

% Sort Population
Costs=[pop.Cost];
[Costs, SortOrder]=sort(Costs);
pop=pop(SortOrder);
% Store Best Solution
BestSol=pop(1);
% Array to Hold Best Cost Values
BestCost=zeros(Out.MaxIter,1);
% Store Cost
WorstCost=pop(end).Cost;
% Array to Hold Number of Function Evaluations
nfe=zeros(Out.MaxIter,1);

%% GA Main Loop
Bestfit=zeros(1,Out.MaxIter);
for iIter=1:Out.MaxIter
    if UseRouletteWheelSelection
           % Calculate Selection Probabilities
           P=exp(-beta*Costs/WorstCost);
           P=P/sum(P);
    end
    % Crossover
    popc=repmat(empty_individual,nc/2,2);
        for k=1:nc/2
            % Select Parents Indices
            if UseRouletteWheelSelection
                i1=RouletteWheelSelection(P);
                i2=RouletteWheelSelection(P);
            end
            if UseTournamentSelection
                i1=TournamentSelection(pop,TournamentSize);
                i2=TournamentSelection(pop,TournamentSize);
            end
            if UseRandomSelection
                i1=randi([1 Out.Npopulation]);
                i2=randi([1 Out.Npopulation]);
            end

        % Select Parents
        p1=pop(i1);
        p2=pop(i2);
        % Apply Crossover
        [popc(k,1).Position popc(k,2).Position]=...
            Crossover(p1.Position,p2.Position,gamma,Out.LowerBound(1),Out.UpperBound(1));
       
        popc(k,1).Cost=fitness(popc(k,1).Position,1,Out);
        popc(k,2).Cost=fitness(popc(k,2).Position,1,Out);
        
    end
    popc=popc(:);
    
    % Mutation
    popm=repmat(empty_individual,nm,1);
    for k=1:nm
        % Select Parent
        i=randi([1 Out.Npopulation]);
        p=pop(i);
        
        % Apply Mutation
        popm(k).Position=Mutate(p.Position,Out.mu,Out.LowerBound(1),Out.UpperBound(1));
        popm(k).Cost=fitness(popm(k).Position,1,Out);
    end
   
    pop=[pop
          popc
       popm];
    % Sort Population
     Costs=[pop.Cost];
    [Costs, SortOrder]=sort(Costs);
    pop=pop(SortOrder);
    % Update Worst Cost
   % WorstCost=max(WorstCost,pop(end).Cost);
   
    % Truncation
    pop=pop(1:Out.Npopulation);
    Costs=Costs(1:Out.Npopulation);
    fitnessMemory=Costs';
    
%     PositionMemory=struct2cell(pop.Position);
%     PositionMemory=PositionMemory(1:Out.Npopulation);
    
    ResultsPool(iIter).BestFitness=fitnessMemory(1);
    ResultsPool(iIter).BestDecisionVariable=pop(1).Position;
    
%     % Store Best Solution Ever Found
%     BestSol=pop(1);
    % Store Best Cost Ever Found
    
      
end

   %% Saving results of the solution
    AllBestSolution(:,iRun)=[ResultsPool.BestFitness]; % Solutin of the problem
    AllBestFitnesses(:,iRun)=ResultsPool.BestDecisionVariable;

end

