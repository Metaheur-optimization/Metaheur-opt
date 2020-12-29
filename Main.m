% %The main file to set the algorithms and run for CSA, PSO, and GA
tic
format long; close all; clc; clear; 

Algorithm='CSA'; 

Out = get_config(Algorithm);

switch Algorithm
    %%Crow Search Algorithm
    case 'CSA'
        [AllBestFitnesses,BestSolution]=CSA(Out);
        
    case 'PSO'
        [AllBestFitnesses,BestSolution]=PSO(Out);
        
end

disp(['No of Runs=',num2str(Out.NRun),' No of Iteration=',num2str(Out.MaxIter),...
    ' Population Size=',num2str(Out.Npopulation)])
% for i=1:Out.NRun
%     plot(AllBestFitnesses(i,1:50))
%     xlabel('No of Iteration')
%     ylabel('Fitness value')
%     hold on
% end
B=mean(AllBestFitnesses);
plot(B(1,1:500))
C=mean(B)

toc
