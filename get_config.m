function Out = get_config(caseString)

Out = [];
%%Common parameters setting
Out.Npopulation = 20;  %Population size
Out.NDecisionVariable = 2;  %Number of decision variables
Out.Function = 2;  %Number of fitness function according to fitness file
Out.NRun = 1; %Number of runs
Out.MaxIter = 5000;  %Maximum number of iterations
Out.LowerBound = -10; %Lower bound of variables
Out.UpperBound = 10;  %Upper bound of variables

switch upper(caseString)
    case 'CSA'
        %%Parameters setting for the CSA
        Out.AP = 0.1; % Awareness probability
        Out.fl = 2; % Flight length (fl)
    case 'PSO'
        %%Parameters setting for the PSO
        Out.w = 1;            % Inertia Weight
        Out.wdamp = 0.99;     % Inertia Weight Damping Ratio
        Out.c1 = 2;           % Personahl Learning Coefficient
        Out.c2 = 2;           % Global Learning Coefficient
    case 'GA'
        Out.crossoverType = 'two-points';   % type of crossover, --> single_point, two_points,
        Out.crossoverProb = 0.9;  % probability of crossover
        Out.mutationProb = 0.05;   % probability of Mutation
end