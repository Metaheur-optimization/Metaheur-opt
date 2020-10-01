clc
clear
close all
format shortG
%% parameters setting
nvar=10; % number of variable

lb=-500*ones(1,nvar); % lower bound
ub=500*ones(1,nvar);  % upper bound

NP=100;              % number particle
T=10000;               % max of iteration

W=1;
C1=2;
C2=2;

damp=0.05;

alpha0=0.5;

%% initialization
tic
empty.pos=[];
empty.cost=[];
empty.velocity=[];

particle=repmat(empty,NP,1);

for i=1:NP
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

    alpha=alpha0+(t/T);
    
     for i=1:NP
         
          particle(i).velocity=W*particle(i).velocity...
                              +alpha*(rand(1,nvar).*(bparticle(i).pos-particle(i).pos)...
                              +rand(1,nvar).*(gparticle.pos-particle(i).pos));
          
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
     
     
     
 W=W*(1-damp);
 
 best(t)=gparticle.cost;
 AVR(t)=mean([particle.cost]);
 
 disp([ ' t = ' num2str(t)   ' BEST = '  num2str(best(t))]);
 
 
 if t>200 && best(t)==best(t-200)
     break
 end
  
 
 if t>100 && best(t)==best(t-100) && mod(t,50)==0
     
     disp('        RESTART           ')
      for i=1:NP
         particle(i).pos=lb+rand(1,nvar).*(ub-lb);
         particle(i).cost=fitness(particle(i).pos);
         particle(i).velocity=0;
      end
     bparticle=particle;
     W=1;
 end
 
 
end
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

title (' AWPSO ')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                   %
%                          www.matlabnet.ir                         %
%                   Free Download  matlab code and movie            %
%                          Shahab Poursafary                        %
%                                                                   %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
