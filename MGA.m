
function [BestCo,BestSolution]=MGA(out)

global CostFunction VarSize VarMin VarMax MaxIt nPop NFE AlgorithmTermination FunctionNumber

%% GA Parameters

% nPop=20;            % Population Size
% nVar=1;        % Number of Decision Variables
% MaxIt=1000;          % Maximum Number of Iterations
% 
% VarMin=-10;
% VarMax=10;


VarSize=[1 out.nVar];   % Size of Decision Variables Matrix

%pc=0.8;                 % Crossover Percentage
nc=2*round(out.pc*out.NoPopulation/2);  % Number of Offsprings (Parnets)


%pm=0.3;                 % Mutation Percentage
nm=round(out.mu*out.NoPopulation);      % Number of Mutants

gamma=0.05;

%mu=0.02;         % Mutation Rate
ANSWER=out.ParrentSlectionType;

% ANSWER=questdlg('Choose selection method:','Genetic Algorith',...
%     'Roulette Wheel','Tournament','Random','Roulette Wheel');

UseRouletteWheelSelection=strcmp(ANSWER,'Roulette Wheel');
UseTournamentSelection=strcmp(ANSWER,'Tournament');
UseRandomSelection=strcmp(ANSWER,'Random');



if UseRouletteWheelSelection
    beta=8;         % Selection Pressure
end

if UseTournamentSelection
    TournamentSize=3;   % Tournamnet Size
end

pause(0.1);

%% Initialization

empty_individual.Position=[];
empty_individual.Cost=[];

pop=repmat(empty_individual,out.NoPopulation,1);

for i=1:out.NoPopulation
    
    % Initialize Position
    pop(i).Position=unifrnd(out.VarMin,out.VarMax,VarSize);
    
    % Evaluation
    %pop(i).Cost=CostFunction(pop(i).Position);
    
    pop(i).Cost=FittnessFunction(pop(i).Position);
    
    
    %pop(i).Cost=fitness(pop(i).Position,out.NoPopulation,out.nVar,out.NoFittnessFunction) % Function for fitness evaluation
   % ft=fitness(xn,N,pd,FuncNum)
    
    
end

% Sort Population
Costs=[pop.Cost];
[Costs, SortOrder]=sort(Costs);
pop=pop(SortOrder);

% Store Best Solution
BestSol=pop(1);

% Array to Hold Best Cost Values
BestCost=zeros(out.MaxIt,1);

% Store Cost
WorstCost=pop(end).Cost;

% Array to Hold Number of Function Evaluations
nfe=zeros(out.MaxIt,1);

%% Main Loop

for it=1:out.MaxIt
    
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
            i1=randi([1 out.NoPopulation]);
            i2=randi([1 out.NoPopulation]);
        end

        % Select Parents
        p1=pop(i1);
        p2=pop(i2);
        
        % Apply Crossover
        [popc(k,1).Position popc(k,2).Position]=...
            Crossover(p1.Position,p2.Position,gamma,out.VarMin,out.VarMax);
        
        % Evaluate Offsprings
%         popc(k,1).Cost=CostFunction(popc(k,1).Position);
%         popc(k,2).Cost=CostFunction(popc(k,2).Position);
        
        popc(k,1).Cost=FittnessFunction(popc(k,1).Position);
        popc(k,2).Cost=FittnessFunction(popc(k,2).Position);
        
        
        
    end
    popc=popc(:);
    
    
    % Mutation
    popm=repmat(empty_individual,nm,1);
    for k=1:nm
        
        % Select Parent
        i=randi([1 out.NoPopulation]);
        p=pop(i);
        
        % Apply Mutation
        popm(k).Position=Mutate(p.Position,mu,out.VarMin,out.VarMax);
        
        % Evaluate Mutant
        %popm(k).Cost=CostFunction(popm(k).Position);
        popm(k).Cost=FittnessFunction(popm(k).Position);
        
        
    end
    
  
   % combined = [pop,popc]  
  %  C = vertcat(pop,popc)
 %combine=[popc 
    %      popm]
    % Create Merged Population
    pop=[pop
          popc
       popm];

     
    % Sort Population
    Costs=[pop.Cost];
    [Costs, SortOrder]=sort(Costs);
    pop=pop(SortOrder);
    
    % Update Worst Cost
    WorstCost=max(WorstCost,pop(end).Cost);
    
    % Truncation
    pop=pop(1:out.NoPopulation);
    Costs=Costs(1:out.NoPopulation);
    
    % Store Best Solution Ever Found
    BestSol=pop(1);
    
    % Store Best Cost Ever Found
    BestCost(it)=BestSol.Cost;
    
    % Store NFE
  %  nfe(it)=NFE;
    
   % Show Iteration Information
   disp(['Iteration ' num2str(it) ', Best Cost = ' num2str(BestCost(it)) ', NFE = ' num2str(nfe(it))])
    
   
%    if AlgorithmTermination.Order==1&&NFE>AlgorithmTermination.MaxNFE
%          break
%     end  
%      
    
    
    
end

%% Results

% figure;
% semilogy(nfe,BestCost,'LineWidth',2);
% xlabel('NFE');
% ylabel('Cost');
BestCo= pop(1).Cost;
BestSolution= pop(1).Position

disp('Genetic Algorithm (GA)')
disp(' ')
