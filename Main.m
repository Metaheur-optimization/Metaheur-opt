% %The main file to set the algorithms and run for CSA, PSO, and GA
tic
format long; close all; clc; clear; 

Algorithm='CSA'; 

Out = get_config(Algorithm);

switch Algorithm
    %%Crow Search Algorithm
    case 'CSA'
        [Results]=CSA(Out);
        
    case 'PSO'
        [Results]=PSO(Out);
        
    case 'GA'
        [Results]=GA(Out);
        
end

disp(['No of Runs=',num2str(Out.NRun),' No of Iteration=',num2str(Out.MaxIter),...
    ' Population Size=',num2str(Out.Npopulation)])


% for i=1:Out.NRun
%     plot(AllBestFitnesses(i,1:50))
%     xlabel('No of Iteration')
%     ylabel('Fitness value')
%     hold on
% end

figure(1)
B=mean(Results.AllBestFitnesses);
subplot(3,1,1)

%nexttile
plot(B(1,1:numel(B)))
title(['Average Fitness value for Engineering Function number ', num2str(Out.EngFunction)])


subplot(3,1,2)


%nexttile
C=mean(Results.NFE);
plot(C(1,1:numel(B)))
title('Number of Function Evaluations')
% ylim([0 50])

subplot(3,1,3)

%nexttile
D=mean(Results.Feasible);
plot(D(1,1:numel(B)))
hold on
E=C-D;
plot(E(1,1:numel(B)))
title('Number of Feasible and Infeasible Solutions')
legend('Feasible Solutions','Infeasible Solutions' );
ylim([0 50])
xlabel('Iteration number')
hold off

figure(2)
plot3(Results.AllBestSolution(:,1),Results.AllBestSolution(:,2),Results.AllBestSolution(:,3),'bo', 'MarkerSize',10)
xlabel('X1')
ylabel('X2')
zlabel('X3')
title ('Best Solution Decion Variables')
grid on
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
