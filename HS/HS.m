clc
clear
close all
%% parameters setting

nvar=30;                % number of variable

lb=-100*ones(1,nvar);   % lower bound
ub=100*ones(1,nvar);     % upper bound

HMS=10;                % harmony memory size

NHMS=400;               % new harmony memory size 

maxiter=2000;           % max iteration

HMCR=0.75;               % harmony memory consideration rate

PAR=0.05;                % pitch adjustment rate

FW=0.1;                % fret  width

FW_damp=0.95;
%% initialization

empty.pos=[];
empty.cost=[];

HM=repmat(empty,HMS,1);

for i=1:HMS
HM(i).pos=lb+rand(1,nvar).*(ub-lb);
HM(i).cost=fitness(HM(i).pos);
end

[value,index]=sort([HM.cost]);

HM=HM(index);

GHM=HM(1);                % global harmony




%% mail loop

best=zeros(maxiter,1);
MEAN=zeros(maxiter,1);

for iter=1:maxiter


    NHM=repmat(empty,NHMS,1);
    
   for i=1:NHMS
     
       NHM(i).pos=lb+rand(1,nvar).*(ub-lb);
       NHM(i).cost=fitness(NHM(i).pos);
       
       

       for j=1:nvar
       
       
       if rand<=HMCR
           k=randi([1 HMS]);
           NHM(i).pos(j)=HM(k).pos(j);    
       end
       
       
       if rand<=PAR
           delta=FW*unifrnd(-1,1)*(ub(j)-lb(j));
           %delta=FW*randn*(ub(j)-lb(j));
           NHM(i).pos(j)=NHM(i).pos(j)+delta;   
       end
       
       
    
       end
       
       NHM(i).pos=min(NHM(i).pos,ub);
       NHM(i).pos=max(NHM(i).pos,lb);
       
       NHM(i).cost=fitness(NHM(i).pos);
       
       
       
   end
   
   
   [HM]=[HM;NHM];
   
   [value,index]=sort([HM.cost]);
   
   
   HM=HM(index(1:HMS));
   
   if HM(1).cost<GHM.cost
       GHM=HM(1);
   end
   
   best(iter)=GHM.cost;
   MEAN(iter)=mean([HM.cost]);
   
   disp([ '  iter =   '  num2str(iter)   ' BEST = '  num2str(GHM.cost)])
   
   FW=FW*FW_damp;
   
   
   
end

%% results

disp('===============================================')
disp([ ' BEST solution = '  num2str(HM.pos)])
disp([ ' BEST fitness = '  num2str(HM.cost)])
disp([ ' Time = '  num2str(toc)])

figure(1)
plot(best(1:iter),'r','LineWidth',2);
hold on
plot(MEAN(1:iter),'b','LineWidth',2);

xlabel('t')
ylabel(' fitness')

legend(' BEST' , 'MEAN')

title('HS')


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                   %
%                          www.matlabnet.ir                         %
%                   Free Download  matlab code and movie            %
%                          Shahab Poursafary                        %
%                                                                   %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%