% %The main file to set the algorithms and run for CSA, PSO, and GA
tic
format long; close all; clc; clear; 
% rng('default')
rng(0)
addpath('plots')
Algorithm='LAL'; 

Out = get_config(Algorithm);

switch Algorithm
    %%Crow Search Algorithm
    case 'CSA'
        [Results]=CSA(Out);
        
    case 'PSO'
        [Results]=PSO(Out);
        
    case 'GA'
        [Results]=GA(Out);
        
    case 'LAL'
        [Results]=LAL(Out);      
end
toc



% figure(1)
% plotFeasible(Results, Out)
% figure(2)
% plot3Dbest(Results)
% % 
% % EE=mean(Results.AllBestFitnesses, 'all')
% NFE=Results.NFEAll;% Number of function evluations accouting for all population size, iterations and runs
% NFE_Perc=NFE/(Out.Npopulation*Out.MaxIter*Out.NRun)*100;
% PenaltyCount=Results.PenaltyCount;
% PenaltyCount_Perc=PenaltyCount/NFE*100;
% Average=mean(Results.AllBestFitnesses(:,end));
% Worst=max(Results.AllBestFitnesses(:,end));
% Best=min(Results.AllBestFitnesses(:,end));
% StdDeviation=std(Results.AllBestFitnesses(:,end));
% 
% 
