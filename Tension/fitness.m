

function ft=fitness(xn,N,pd) % Function for fitness evaluation
npop=N;nvar=pd;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
g=zeros(npop,4);
p=zeros(1,4);
a=10*10^6;
%b=10*10^6;
for i=1:npop
  g(i,1)=1-((xn(i,2)^3 *xn(i,3))/(71785*xn(i,1)^4));
  g(i,2)=((4*xn(i,2)^2 -xn(i,1)*xn(i,2))/(12566*(xn(i,2)*xn(i,1)^3 -xn(i,1)^4)))+ (1/5108*xn(i,1)^2)- 1;
  g(i,3)=1- (140.45*xn(i,1)/(xn(i,2)^2 *xn(i,3)));
  g(i,4)=((xn(i,1)+xn(i,2))/1.5)-1;
  
  if g(i,1)<=0
      p(1)=0;
  else
      p(1)=a*g(i,1);
  end
  
  if g(i,2)<=0
      p(2)=0;
  else
      p(2)=a*g(i,2);
  end
  
  if g(i,3)<=0
      p(3)=0;
  else
      p(3)=a*g(i,3);
  end
  
  if g(i,4)<=0
      p(4)=0;
  else
      p(4)=a*g(i,4);
  end
  
    cost =(xn(i,3)+2)*xn(i,2)*xn(i,1)^2;% Sphere function
    
    ft(i)=cost+abs(p(1)+p(2)+p(3)+p(4));
end









