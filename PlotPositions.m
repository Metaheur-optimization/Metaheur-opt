function  [P P1]=PlotPositions(iIter,BossLionPosition,SupportLionPosition,NDecisionVariable,NoFuncEval);
   
% colors={'b' 'r' 'g' 'y'}
% rand=randperm(numel(colors),1)
% randcolors=colors(rand)


colors=[0.4 1];
r1=randperm(2,1);
r2=randperm(2,1);
r3=randperm(2,1);
c=[colors(r1) colors(r2) colors(r3)]

figure(1)
%P=plot3(BossLionPosition(:,1),BossLionPosition(:,2),BossLionPosition(:,3),'ro','MarkerSize',10)
P=plot3(BossLionPosition(:,1),BossLionPosition(:,2),BossLionPosition(:,3),'ro','MarkerFaceColor',c,'MarkerSize',10)

grid on
hold on

P=plot3(SupportLionPosition(:,1),SupportLionPosition(:,2),SupportLionPosition(:,3),'b*','MarkerFaceColor',c,'MarkerSize',8)


legend('Boss Lions', 'Support Lions')

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
    