function plot3Dbest(Results)
plot3(Results.AllBestSolution(:,1),Results.AllBestSolution(:,2),Results.AllBestSolution(:,3),'bo', 'MarkerSize',10)
xlabel('X1')
ylabel('X2')
zlabel('X3')
title ('Best Solution Decion Variables')
grid on