%The main file to set the algorithms and run for CSA, PSO, and GA
format long; close all; clear all; clc
%%Common parameters setting
Npop=20;  %Population size
Nvar=2;  %Number of decision variables
Func=2;  %Number of fitness function according to fitness file
Nrun=1; %Number of runs
itermax=5000;  %Maximum number of iterations
LB=-10; %Lower bound of variables
UB=10;  %Upper bound of variables
Algorithm='CSA';

%%Parameters setting for the CSA
AP=0.1; % Awareness probability
fl=2; % Flight length (fl)

%%Parameters setting for the PSO
 w=1;            % Inertia Weight
 wdamp=0.99;     % Inertia Weight Damping Ratio
 c1=2;           % Personahl Learning Coefficient
 c2=2;           % Global Learning Coefficient
 

switch Algorithm
%%Crow Search Algorithm
    case 'CSA'
[Global fit_mem g_best]=CrowSearchAlgorithm(Npop,Nvar,Func,Nrun,itermax,LB,UB,AP,fl);

    case 'PSO'
        [BestCost BestSolution]=PSO(Npop,Nvar,Func,Nrun,itermax,LB,UB,w,wdamp,c1,c2);
        
end


