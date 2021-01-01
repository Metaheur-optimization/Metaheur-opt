function Out = get_config(caseString)

Out = [];
%%Common parameters setting
Out.Npopulation = 50;  %Population size
Out.NDecisionVariable = 2;  %Number of decision variables
Out.Function = 2;  %Number of Mathematical function according to fitness file
Out.EngFunction = 2;  %Number of Engineering function according to Engineering Function file
Out.NRun = 1; %Number of runs
Out.MaxIter = 1000;  %Maximum number of iterations
Out.LowerBound = zeros(Out.NDecisionVariable,1); %Lower bound of variables
Out.UpperBound = zeros(Out.NDecisionVariable,1); %Lower bound of variables
Out.LowerBound(:) = -10; %Lower bound of variables
Out.UpperBound(:) = 10;  %Upper bound of variables

switch upper(caseString)
    case 'CSA'
        %%Parameters setting for the CSA
        Out.AP = 0.20; % Awareness probability
        Out.fl = 3.0; % Flight length (fl)
    case 'PSO'
        %%Parameters setting for the PSO
        Out.InterWeight = 1;            % Inertia Weight
        Out.DampRatio = 0.99;     % Inertia Weight Damping Ratio
        Out.c1 = 2;           % Personahl Learning Coefficient
        Out.c2 = 2;           % Global Learning Coefficient
    case 'GA'
        Out.pc=0.8;                 % Crossover Percentage
        Out.pm=0.3;                 % Mutation Percentage
        Out.mu=0.02;                % Mutation Rate
        Out.ParrentSlectionType='Tournament'   % Slection Type: 'Roulette Wheel','Tournament','Random','Roulette Wheel'
end

% function out = get_config(caseString)
% 
% out = [];
% switch upper(caseString)
%     case 'CSA'
%         %%Common parameters setting
%         out.Npop = 20;  %Population size
%         out.Nvar = 2;  %Number of decision variables
%         out.Func = 2;  %Number of fitness function according to fitness file
%         out.Nrun = 1; %Number of runs
%         out.itermax = 5000;  %Maximum number of iterations
%         out.LB = -10; %Lower bound of variables
%         out.UB = 10;  %Upper bound of variables
%         %%Parameters setting for the CSA
%         out.AP = 0.1; % Awareness probability
%         out.fl = 2; % Flight length (fl)
%     case 'PSO'
%         %%Common parameters setting
%         out.Npop = 20;  %Population size
%         out.Nvar = 2;  %Number of decision variables
%         out.Func = 2;  %Number of fitness function according to fitness file
%         out.Nrun = 1; %Number of runs
%         out.itermax = 5000;  %Maximum number of iterations
%         out.LB = -10; %Lower bound of variables
%         out.UB = 10;  %Upper bound of variables
%         %%Parameters setting for the PSO
%         out.w = 1;            % Inertia Weight
%         out.wdamp = 0.99;     % Inertia Weight Damping Ratio
%         out.c1 = 2;           % Personahl Learning Coefficient
%         out.c2 = 2;           % Global Learning Coefficient
%     case 'MGA'
% %         out.Npop = 20;  %Population size
% %         out.crossover_type = 'two-points';   % type of crossover, --> single_point, two_points,  
% %         out.crossover_prob = 0.9;  % probability of crossover
% %         out.mutation_prob = 0.05;   % probability of Mutation
% 
% %% GA Parameters
% out.NoPopulation=20 % Population Size
% out.nVar=1;  % Number of Decision Variables
% out.VarMin=-10;
% out.VarMax=10;
% out.MaxIt=1000;
% out.pc=0.8;                 % Crossover Percentage
% pm=0.3;                 % Mutation Percentage
% out.mu=0.02;         % Mutation Rate
% out.ParrentSlectionType='Tournament'   % Slection Type: 'Roulette Wheel','Tournament','Random','Roulette Wheel'
% out.NoFittnessFunction=1;
% 
% 
% end




