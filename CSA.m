
% -------------------------------------------------
function [Global,fit_mem,g_best]=CSA(Npop,Nvar,Func,Nrun,itermax,LB,UB,AP,fl)
Global=zeros(Nrun,itermax);

for run=1:Nrun
pd=Nvar; % Problem dimension (number of decision variables)
N=Npop; % Flock (population) size
FuncNum=Func; %Number of Fitness Function

[x,l,u]=init(N,pd,LB,UB); % Function for initialization

xn=x;
ft=fitness(xn,N,pd,FuncNum); % Function for fitness evaluation

mem=x; % Memory initialization
fit_mem=ft; % Fitness of memory positions

tmax=itermax; % Maximum number of iterations (itermax)
for t=1:tmax

    num=ceil(N*rand(1,N)); % Generation of random candidate crows for following (chasing)
    for i=1:N
        if rand>AP
            xnew(i,:)= x(i,:)+fl*rand*(mem(num(i),:)-x(i,:)); % Generation of a new position for crow i (state 1)
        else
            for j=1:pd
                xnew(i,j)=l-(l-u)*rand; % Generation of a new position for crow i (state 2)
            end
        end
    end

    xn=xnew;
    ft=fitness(xn,N,pd,FuncNum); % Function for fitness evaluation of new solutions

    for i=1:N % Update position and memory
        if xnew(i,:)>=l && xnew(i,:)<=u
            x(i,:)=xnew(i,:); % Update position
            if ft(i)<fit_mem(i)
                mem(i,:)=xnew(i,:); % Update memory
                fit_mem(i)=ft(i);
            end
        end
    end

    ffit(t)=min(fit_mem); % Best found value until iteration t
    best_=min(fit_mem);
    disp([ 'run =   ' num2str(run)     '  iter =   '  num2str(t)   ' BEST = '  num2str(best_)])
end
ngbest=find(fit_mem== min(fit_mem));
g_best=mem(ngbest(1),:); % Solutin of the problem
Global(run,:)=ffit;
end
