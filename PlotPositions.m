function  [P P1]=PlotPositions(BossLionPosition,SupportLionPosition,NDecisionVariable,NoFuncEval);
   


figure(1)
P=plot3(BossLionPosition(:,1),BossLionPosition(:,2),BossLionPosition(:,3),'ro','MarkerSize',10)
grid on
hold on

P=plot3(SupportLionPosition(:,1),SupportLionPosition(:,2),SupportLionPosition(:,3),'b*','MarkerSize',8)




% x=1:length(BossLionPosition(:,end));
% P=scatter(x,BossLionPosition(:,end),40,'MarkerEdgeColor',[0 .5 .5],...
%               'MarkerFaceColor',[0 .7 .7],...
%               'LineWidth',1.5);
% grid on
% hold on
% x1=1:length(SupportLionPosition(:,end));
% 
% P=scatter(x1,SupportLionPosition(:,end),'LineWidth', 0.6,'MarkerEdgeColor','b','MarkerFaceColor' , [0 0.5 0.5]);




% figure(2)
% P1=surf(BossLionPosition);
% grid on
% hold on
% P1=surf(SupportLionPosition);

end
    