function plotFeasible(Results, Out)

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
end