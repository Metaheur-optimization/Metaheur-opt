function Out = get_config(caseString)

Out = [];

%%Common parameters setting
Out.Npopulation = 20;  %Population size - CSA:20
Out.Function = 29;  %Number of Mathematical function according to fitness file
Out.NRun = 5; %Number of runs - CSA:30
Out.MaxIter = 1000;  %Maximum number of iterations - CSA:2000 -->  20*30 * 2000 = 1200000, 



%%%%%%%%%% NO need to modify this part   %%%%%%%%%%%%%%%%%%%%%%%%%%%
data_temp = xlsread('FunctionsBounds', 'NoDecisionvar'); % temporary data. just to read the xlsx sheet
Out.NDecisionVariable = data_temp(Out.Function);  %Number of decision variables
data_temp = xlsread('FunctionsBounds', 'lower'); % temporary data. just to read the xlsx sheet
Out.LowerBound = data_temp(Out.Function, 1:Out.NDecisionVariable); %Lower bound of variables
data_temp = xlsread('FunctionsBounds', 'upper'); % temporary data. just to read the xlsx sheet
Out.UpperBound = data_temp(Out.Function, 1:Out.NDecisionVariable); %Upper bound of variables
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



% Optimization

Out.ObjectiveType=0 ; %(0 Minimization, 1 Maximization) 

switch upper(caseString)
    case 'CSA'
        %%Parameters setting for the CSA
        Out.AP = 0.5;    %0.20; % Awareness probability
        Out.fl = 2.0;     %3.0; % Flight length (fl)
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
      Out.hunt_support=-0.05; 


end