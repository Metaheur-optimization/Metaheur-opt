
% %The main file to set the algorithms and run for CSA, PSO, and GA
tic
format long; close all; clc; clear; 

Algorithm='GA'; 

Out = get_config(Algorithm);

switch Algorithm
    %%Crow Search Algorithm
    case 'CSA'
        [AllBestFitnesses,AllBestSolution]=CSA(Out);
        
    case 'PSO'

        [AllBestFitnesses,AllBestSolution]=PSO(Out);
        
           case 'GA' 

        [BestCost BestSolution]=PSO(Npop,Nvar,Func,Nrun,itermax,LB,UB,w,wdamp,c1,c2);
       
       case 'MGA' 
       
       [BestCo,BestSolution]=MGA(out)  
       
       [ResultsPool]=GA(Out)
        
        
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
% % plot(B(1,1:1000))
% % C=mean(AllBestFitnesses, 'all')
% % Average=mean(AllBestFitnesses(:,end));
% % Worst=max(AllBestFitnesses(:,end));
% % Best=min(AllBestFitnesses(:,end));
% % StdDeviation=std(AllBestFitnesses(:,end));

toc












