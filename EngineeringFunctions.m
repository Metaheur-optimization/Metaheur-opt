%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%Engineering problems fitness functions and variables%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% 1. Three bar truss problem
l=[0 0]; u=[1 1];% Lower and upper bounds

%Fitness function:
npop=size(xn,1);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
g=zeros(npop,3);                %Constraint function values
penalty=zeros(1,3);                   %Penalty values
penalty_constant=1*10^6;                       %Penalty constant

for i=1:npop
  g(i,1)=((sqrt(2)*xn(i,1)+xn(i,2))/(sqrt(2)*xn(i,1)^2 +(2*xn(i,1)*xn(i,2))))*2 -2;
  g(i,2)=(xn(i,2)/(sqrt(2)*xn(i,1)^2 +(2*xn(i,1)*xn(i,2))))*2 -2;
  g(i,3)=(1/((sqrt(2)*xn(i,2)) +xn(i,1)))*2 -2;
  
for j=1:3
  if g(i,j)<=0
      penalty(j)=0;
  else
      penalty(j)=penalty_constant*g(i,j);
  end
end
  
  
    cost =(2*sqrt(2)*xn(i,1)+xn(i,2))*100;% Sphere function
    
    ft(i)=cost+abs(sum(penalty));
end

%% 2. Tension problem
l=[0.05 0.25 2]; u=[2 1.3 15];% Lower and upper bounds

%Fitness function
npop=size(xn,1);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
g=zeros(npop,4);                  %Constraint functions values
penalty=zeros(1,4);                     %Penalty Values
penalty_constant=5*10^6;                         %Penalty constant

for i=1:npop
  g(i,1)=1-((xn(i,2)^3 *xn(i,3))/(71785*xn(i,1)^4));
  g(i,2)=((4*xn(i,2)^2 -xn(i,1)*xn(i,2))/(12566*(xn(i,2)*xn(i,1)^3 -xn(i,1)^4)))+ (1/(5108*xn(i,1)^2))- 1;
  g(i,3)=1- (140.45*xn(i,1)/(xn(i,2)^2 *xn(i,3)));
  g(i,4)=((xn(i,1)+xn(i,2))/1.5)-1;
  
  for j=1:4
  if g(i,j)<=0
      penalty(j)=0;
  else
      penalty(j)=penalty_constant*g(i,j);
  end
  end
  
    cost =(xn(i,3)+2)*xn(i,2)*xn(i,1)^2;
    
    ft(i)=cost+abs(sum(penalty));
end

%% 3. Welded beam problem
l=[0.1 0.1 0.1 0.1]; u=[2 10 10 2]; % Lower and upper bounds

%Fitness function
npop=size(xn,1);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Constants
P=6000;L=14;E=30*10^6;G=12*10^6;toemax=13600;sigmax=30000;Sigmax=0.25;

%% Initialize
g=zeros(npop,7);               %Constaint function values
penalty=zeros(1,7);                  %Penalty values
penalty_constant=5;                           %Penalty constant

for i=1:npop
    %% Equations
Pc=64746.022*(1-0.0282346*xn(i,3))*xn(i,3)*xn(i,4)^3;
sig=6*P*L/(xn(i,4)*xn(i,3)^2);
J=2*(sqrt(2)*xn(i,1)*xn(i,2)*(xn(i,2)^2/12 +((xn(i,1)+xn(i,3))/2)^2));
Sig=4*P*L^3/(E*xn(i,3)^3 *xn(i,4));
R=sqrt(xn(i,2)^2/4 +((xn(i,1)+xn(i,3))/2)^2);
toep=P/(sqrt(2)*xn(i,1)*xn(i,2));
M=P*(L+xn(i,2)/2);
toez=M*R/J;
toe=sqrt(toep^2 +(2*toep*toez*xn(i,2)/(2*R)) +toez^2);

  g(i,1)=toe-toemax;
  g(i,2)=sig-sigmax;
  g(i,3)=xn(i,1)-xn(i,4);
  g(i,4)=0.10471*xn(i,1)^2 +0.04811*xn(i,3)*xn(i,4)*(14+xn(i,2))-5;
  g(i,5)=0.125-xn(i,1);
  g(i,6)=Sig-Sigmax;
  g(i,7)=P-Pc;

  for j=1:7
  if g(i,j)<=0
      penalty(j)=0;
  else
      penalty(j)=penalty_constant*g(i,j);
  end
  end
  

      
    cost =1.10471*xn(i,1)^2 *xn(i,2) +0.04811*xn(i,3)*xn(i,4)*(14+xn(i,2));
    
    ft(i)=cost+abs(sum(penalty));
end

%% 4. Reducing
l=[2.6 0.7 17 7.3 7.3 2.9 5]; u=[3.6 0.8 28 8.3 8.3 3.9 5.5]; % Lower and upper bounds

%Fitness function
npop=size(xn,1);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
g=zeros(npop,11);
penalty=zeros(1,11);
penalty_constant=0.2*10^2;


for i=1:npop
  g(i,1)=(27/(xn(i,1)*xn(i,3)*xn(i,2)^2))-1;
  g(i,2)=(397.5/(xn(i,1)*xn(i,2)^2 *xn(i,3)^2))-1;
  g(i,3)=((1.93*xn(i,4)^3)/(xn(i,2)*xn(i,3)*xn(i,6)^4))-1;
  g(i,4)=((1.93*xn(i,5)^3)/(xn(i,2)*xn(i,3)*xn(i,7)^4))-1;
  g(i,5)=((((745*xn(i,4)/xn(i,2)*xn(i,3))^2 +(16.9*10^6))^0.5)/(110*xn(i,6)^3))-1;
  g(i,6)=((((745*xn(i,5)/xn(i,2)*xn(i,3))^2 +(157.7*10^6))^0.5)/(85*xn(i,7)^3))-1;
  g(i,7)=(xn(i,2)*xn(i,3)/40)-1;
  g(i,8)=(5*xn(i,2)/xn(i,1))-1;
  g(i,9)=(xn(i,1)/(12*xn(i,2)))-1;
  g(i,10)=((1.5*xn(i,6) +1.9)/xn(i,4))-1;
  g(i,11)=((1.1*xn(i,7) +1.9)/xn(i,5))-1;
  
  for j=1:11
  if g(i,j)<=0
      penalty(j)=0;
  else
      p(j)=penalty_constant*g(i,j);
  end
  end

    cost =0.7854*xn(i,1)*xn(i,2)^2 *(3.3333*xn(i,3)^2 +14.9334*xn(i,3)-43.0934)-1.508*xn(i,1)*(xn(i,6)^2 +xn(i,7)^2)+7.4777*(xn(i,6)^3 +xn(i,7)^3)+0.7854*(xn(i,4)*xn(i,6)^2 +xn(i,5)*xn(i,7)^2);     
    
    ft(i)=cost+abs(sum(penalty));
end

%% 5. Pressure vessel problem
l=[0.0625 0.0625 10 10]; u=[0.0625*99 0.0625*99 200 200];% Lower and upper bounds

%Fitness function
npop=size(xn,1);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
g=zeros(npop,4);
penalty=zeros(1,6);
penalty_constant=1*10^6;
penalty_constant2=2*10^3;
penalty_constant3=5*10^3;
for i=1:npop
  g(i,1)=-xn(i,1)+0.0193*xn(i,3);
  g(i,2)=-xn(i,2)+0.00954*xn(i,3);
  g(i,3)=-pi*xn(i,3)^2 *xn(i,4)-4/3*pi*xn(i,3)^3 +1296000;
  g(i,4)=xn(i,4)-240;
  
  for j=1:4
  if g(i,j)<=0
      penalty(j)=0;
  else
      penalty(j)=penalty_constant*g(i,j);
  end
  end
  
  
  if mod(xn(i,1),0.0625)==0
      penalty(5)=0;
  else
      penalty(5)=penalty_constant2*mod(xn(i,1),0.0625);
  end
  
  if mod(xn(i,2),0.0625)==0
      penalty(6)=0;
  else
      penalty(6)=penalty_constant3*mod(xn(i,2),0.0625);
  end
    cost =0.6224*xn(i,1)*xn(i,3)*xn(i,4)+1.7781*xn(i,2)*xn(i,3)^2 +3.1661*xn(i,1)^2 *xn(i,4)+19.84*xn(i,1)^2 *xn(i,3);
    
    ft(i)=cost+abs(sum(penalty));
end