function Out = get_config(caseString)

Out = [];
%%Common parameters setting
Out.Npopulation = 100;  %Population size
Out.NDecisionVariable =10;  %Number of decision variables
Out.Function = 19;  %Number of Mathematical function according to fitness file
Out.EngFunction = 1;  %Number of Engineering function according to Engineering Function file
Out.NRun = 1; %Number of runs
Out.MaxIter = 1000;  %Maximum number of iterations
Out.LowerBound = zeros(Out.NDecisionVariable,1); %Lower bound of variables
Out.UpperBound = zeros(Out.NDecisionVariable,1); %Lower bound of variables
Out.LowerBound(:) = -30; %Lower bound of variables
Out.UpperBound(:) = 30;  %Upper bound of variables

% Optimization

Out.ObjectiveType=0  %(0 Minimization, 1 Maximization) 

switch upper(caseString)
    case 'CSA'
        %%Parameters setting for the CSA
        Out.AP = 0.02    %0.20; % Awareness probability
        Out.fl = 3     %3.0; % Flight length (fl)
    case 'PSO'
        %%Parameters setting for the PSO
        Out.InterWeight = 1;            % Inertia Weight
        Out.DampRatio = 0.99;     % Inertia Weight Damping Ratio
        Out.c1 = 2;           % Personahl Learning Coefficient
        Out.c2 = 2;           % Global Learning Coefficient
%     case 'GA'
%         Out.crossoverType = 'two-points';   % type of crossover, --> single_point, two_points,
%         Out.crossoverProb = 0.9;  % probability of crossover
%         Out.mutationProb = 0.05;   % probability of Mutation
    case 'GA'
        Out.pc=0.8;                 % Crossover Percentage
        Out.pm=0.3;                 % Mutation Percentage
        Out.mu=0.3;                % Mutation Rate
        Out.gamma=0.05;
        Out.ParrentSlectionType='Tournament';   % Slection Type: 'Roulette Wheel','Tournament','Random','Roulette Wheel'
        
        
    case 'LAL'
  % good for both F1, f3 and f5   
%      Out.Hunt_Boss=2;   
%       Out.hunt_support=-0.01;  


% good for F2
%       Out.Hunt_Boss=5;   
%       Out.hunt_support=0.001;        

% good for F2
%       Out.Hunt_Boss=2;   
%       Out.hunt_support=-0.001;  
% rng (20)

      Out.Hunt_Boss=2;   
      Out.hunt_support=-0.001;  


end