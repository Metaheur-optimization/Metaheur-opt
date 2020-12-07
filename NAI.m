%% ************ Developing New Algorithm *********
function [BestDVs BestFittVals OptiVals BestSol BestDV Pareto]=NAI(Npop,Nvar,Func,Nrun,itermax)

%% General parameter definition
pd=Nvar; % Problem dimension (number of decision variables)
N=Npop; % population size
FuncNum=Func; %Number of Fitness Function

% x(:,1)=randperm(N,
X = -10:0.001:10;
x = (randi([-10,10],N,2)/100);

BestDVs=[];
PartoIndex=1;

for run=1:Nrun

    
for Iter=1:itermax    
xn=x;
ft=fitness(xn,N,pd,FuncNum);

rng('shuffle');

% %%%%%%%%%%%%%% New Operators %%%%%%%%%%%%%%%%%%%

%x = (randi([-10,10],N,2)/100);

x(:,1)=-10 + (10+10)*rand(N,1);    % r = a + (b-a).*rand(N,1).
x(:,2)=-10 + (10+10)*rand(N,1);
% x(:,1)=X(randperm(20));
% x(:,2)=X(randperm(20));

% %%%%%%%%%%%%%% New Operators %%%%%%%%%%%%%%%%%%%


Iter


BestFittVals(Iter,1)=min(ft(1,:));


    
OptiVals=(BestFittVals(end,1));

BestIndex=find(ft==OptiVals);

BestDVs(Iter,:)=x(BestIndex(1),:);


% if less than the bervious one

if Iter>1
    
if BestFittVals(end,1)< (min(BestFittVals))
   
    PartoIndex=PartoIndex+1; 
    
Pareto(PartoIndex,1)=BestFittVals(end,1);

end

else
    
 Pareto(PartoIndex,1)=BestFittVals(1,1);   

end







end







end

 BestSol=min(BestFittVals);
 ind=find(BestFittVals==BestSol);
 BestDV=BestDVs(ind,:);



end
