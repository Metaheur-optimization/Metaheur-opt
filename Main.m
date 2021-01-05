% %The main file to set the algorithms and run for CSA, PSO, and GA
tic
format long; close all; clc; clear; 

Algorithm='GA'; 

Out = get_config(Algorithm);

switch Algorithm
    %%Crow Search Algorithm
    case 'CSA'
        [Results]=CSA(Out);
        
    case 'PSO'
        [Results]=PSO(Out);
        
    case 'GA'
        [Results]=GA(Out);
%         [BestCost,BestSolution]=PSO(Npop,Nvar,Func,Nrun,itermax,LB,UB,w,wdamp,c1,c2);	        [BestCost BestSolution]=PSO(Npop,Nvar,Func,Nrun,itermax,LB,UB,w,wdamp,c1,c2);
        
end

disp(['No of Runs=',num2str(Out.NRun),' No of Iteration=',num2str(Out.MaxIter),...
    ' Population Size=',num2str(Out.Npopulation)])


% for i=1:Out.NRun
%     plot(AllBestFitnesses(i,1:50))
%     xlabel('No of Iteration')
%     ylabel('Fitness value')
%     hold on
% end


B=mean(Results.AllBestFitnesses);
tiledlayout(3,1)

nexttile
plot(B(1,1:1000))
title(['Average Fitness value for Engineering Function number ', num2str(Out.EngFunction)])

nexttile
C=mean(Results.NFE);
plot(C(1,1:1000))
title('Number of Function Evaluations')
ylim([0 50])

nexttile
D=mean(Results.Feasible);
plot(D(1,1:1000),'DisplayName','Number of Feasible Solutions')
hold on
E=C-D;
plot(E(1,1:1000),'DisplayName','Number of Infeasible Solutions')
title('Number of Feasible and Infeasible Solutions')
ylim([0 50])
xlabel('Iteration number')
hold off


% surf(Results.Feasible)

EE=mean(Results.AllBestFitnesses, 'all')
NFE=Results.NFEAll;% Number of function evluations accouting for all population size, iterations and runs
NFE_Perc=NFE/(Out.Npopulation*Out.MaxIter*Out.NRun)*100;
PenaltyCount=Results.PenaltyCount;
PenaltyCount_Perc=PenaltyCount/NFE*100;
Average=mean(Results.AllBestFitnesses(:,end));
Worst=max(Results.AllBestFitnesses(:,end));
Best=min(Results.AllBestFitnesses(:,end));
StdDeviation=std(Results.AllBestFitnesses(:,end));

toc
