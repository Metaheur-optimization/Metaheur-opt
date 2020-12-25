function out = get_config(caseString)

out = [];
switch upper(caseString)
    case 'CSA'
        %%Common parameters setting
        out.Npop = 20;  %Population size
        out.Nvar = 2;  %Number of decision variables
        out.Func = 2;  %Number of fitness function according to fitness file
        out.Nrun = 1; %Number of runs
        out.itermax = 5000;  %Maximum number of iterations
        out.LB = -10; %Lower bound of variables
        out.UB = 10;  %Upper bound of variables
        %%Parameters setting for the CSA
        out.AP = 0.1; % Awareness probability
        out.fl = 2; % Flight length (fl)
    case 'PSO'
        %%Common parameters setting
        out.Npop = 20;  %Population size
        out.Nvar = 2;  %Number of decision variables
        out.Func = 2;  %Number of fitness function according to fitness file
        out.Nrun = 1; %Number of runs
        out.itermax = 5000;  %Maximum number of iterations
        out.LB = -10; %Lower bound of variables
        out.UB = 10;  %Upper bound of variables
        %%Parameters setting for the PSO
        out.w = 1;            % Inertia Weight
        out.wdamp = 0.99;     % Inertia Weight Damping Ratio
        out.c1 = 2;           % Personahl Learning Coefficient
        out.c2 = 2;           % Global Learning Coefficient
    case 'MGA'
%         out.Npop = 20;  %Population size
%         out.crossover_type = 'two-points';   % type of crossover, --> single_point, two_points,  
%         out.crossover_prob = 0.9;  % probability of crossover
%         out.mutation_prob = 0.05;   % probability of Mutation

%% GA Parameters
out.NoPopulation=20 % Population Size
out.nVar=1;  % Number of Decision Variables
out.VarMin=-10;
out.VarMax=10;
out.MaxIt=1000;
out.pc=0.8;                 % Crossover Percentage
pm=0.3;                 % Mutation Percentage
out.mu=0.02;         % Mutation Rate
out.ParrentSlectionType='Tournament'   % Slection Type: 'Roulette Wheel','Tournament','Random','Roulette Wheel'
out.NoFittnessFunction=1;


end