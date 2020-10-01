clc
clear
close all
tic;
Global = zeros(30,5000);
for run=1:30
%% parameters setting
nvar=10; % number of variable

lb=-5; % lower bound
ub=10;  % upper bound

NP=20;              % number particle
T=5000;               % max of iteration

W=1;
C1=2;
C2=2;

alpha=0.05;


%% initialization
empty.pos=[];
empty.cost=[];
empty.velocity=[];

particle=repmat(empty,NP,1);

for i=1:NP
   %  for j=1:nvar
particle(i).pos=lb+rand(1,nvar).*(ub-lb);
particle(i).cost=fitness(particle(i).pos);
particle(i).velocity=0;
end

bparticle=particle;

[value,index]=min([particle.cost]);

gparticle=particle(index);

%% main loop

best=zeros(T,1);
AVR=zeros(T,1);

for t=1:T

     for i=1:NP
         
          particle(i).velocity=W*particle(i).velocity...
                              +C1*rand(1,nvar).*(bparticle(i).pos-particle(i).pos)...
                              +C2*rand(1,nvar).*(gparticle.pos-particle(i).pos);
          
         particle(i).pos=particle(i).pos+particle(i).velocity;
         
         particle(i).pos=min(particle(i).pos,ub);
         particle(i).pos=max(particle(i).pos,lb);
          
         
         particle(i).cost=fitness(particle(i).pos);
         
         
         if particle(i).cost<bparticle(i).cost
             bparticle(i)=particle(i);
             
             if bparticle(i).cost<gparticle.cost
                 gparticle=bparticle(i);
             end
         end
         
         

     end
     
     
     
 W=W*(1-alpha);
 
 best(t)=gparticle.cost;
 AVR(t)=mean([particle.cost]);
 
 disp(['run =  ' num2str(run)  ' t = ' num2str(t)   ' BEST = '  num2str(best(t))]);
 

 
end
Global(run,:)=best';
end
toc
%% results
disp('====================================================')
disp([' BEST solution   =  '  num2str(gparticle.pos)])
disp([' BEST fitness    = '   num2str(gparticle.cost)])
disp(['  Time           =  '  num2str(toc)])

figure(1)
plot(best(1:t),'r','LineWidth',2)
hold on
plot(AVR(1:t),'b','LineWidth',2)

xlabel('t')
ylabel(' fitness ')

legend('BEST','MEAN')

title (' PSO ')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                   %
%                          www.matlabnet.ir                         %
%                   Free Download  matlab code and movie            %
%                          Shahab Poursafary                        %
%                                                                   %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
