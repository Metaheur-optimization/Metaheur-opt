

function ft=fitness(xn,N,pd) % Function for fitness evaluation
npop=N;nvar=pd;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
g=zeros(npop,3);
p=zeros(1,3);
a=1*10^6;
%b=10*10^6;
for i=1:npop
  g(i,1)=((sqrt(2)*xn(i,1)+xn(i,2))/(sqrt(2)*xn(i,1)^2 +(2*xn(i,1)*xn(i,2))))*2 -2;
  g(i,2)=(xn(i,2)/(sqrt(2)*xn(i,1)^2 +(2*xn(i,1)*xn(i,2))))*2 -2;
  g(i,3)=(1/((sqrt(2)*xn(i,2)) +xn(i,1)))*2 -2;
  
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
  
  
    cost =(2*sqrt(2)*xn(i,1)+xn(i,2))*100;% Sphere function
    
    ft(i)=cost+abs(p(1)+p(2)+p(3));
end









