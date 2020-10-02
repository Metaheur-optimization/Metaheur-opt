function TestFunction(varargin)
%% 1. Ackley's problem
 ft(i) = -20*exp(-0.2*sqrt(1/nvar*(sum(xn(i,:)))))-exp(1/nvar*(sum(cos(2*pi*xn(i,:)))))+20+exp(1);
%% 2. Aluffi-Pentini's problem
 ft(i) = 0.25*xn(i,1)^4 - 0.5*xn(i,1)^2 + 0.1*xn(i,1) + 0.5*xn(i,2)^2;
%% 3. Becker and Lago problem  
 ft(i)= (abs(xn(i,1))- 5)^2 + (abs(xn(i,2))- 5)^2;
%% 4. Bohachevsky 1 problem   
 ft(i)= (xn(i,1)^2) + (2*xn(i,2)^2)- 0.3*cos(3*pi*xn(i,1))-0.4*cos(4*pi*xn(i,2))+ 0.7;
%% 5. Bohachevsky 2 problem    
 ft(i)= (xn(i,1)^2) + (2*xn(i,2)^2)- 0.3*cos(3*pi*xn(i,1)) *cos(4*pi*xn(i,2))+ 0.3;
%% 6. Branin problem    
  a=1; b=5.1/(4*pi^2); c=5/pi; r=6 ; s=10; t=1/(8*pi);
for i=1:npop 

 ft(i)=a*(xn(i,2)- b*xn(i,1)^2 + c*xn(i,1)- r)^2 + s*(1-t)*cos(xn(i,1)) + s; % Sphere function
end  
%% 7. Camel back 3- three hump problem        
 ft(i)= (2*xn(i,1)^2)- (1.05*xn(i,1)^4) + ((1/6)*xn(i,1)^6) + xn(i,1)*xn(i,2) + xn(i,2)^2;
%% 8. Camel back 6 - six hump problem
 ft(i)= (4- 2.1*(xn(i,1)^2) + xn(i,1)^4/3)*(xn(i,1)^2) + xn(i,1)*xn(i,2) + (-4 + 4*xn(i,2)^2)*xn(i,2)^2;
%% 9. Cosine mixture problem 
 xi=xn.^2;
 ft(i)= 0.1*sum(cos(5*pi*xn(i,:)))- sum(xi(i,:));
%% 10. Dekkers and Aarts problem
ft(i)=(10^5)*(xn(i,1)^2)+(xn(i,2)^2)-(((xn(i,1)^2)+(xn(i,2)^2))^2)+(10^-5)*(((xn(i,1)^2)+(xn(i,2)^2))^4);
 
 %% 11. Easom problem 
  ft(i)= -cos(xn(i,1))*cos(xn(i,2))*exp(-(xn(i,1)- pi)^2- (xn(i,2)- pi)^2);
 %% 12. Epistatic michalewics 5 problem     
 s=zeros(1,nvar);
for i=1:npop 
for j=1:nvar
   s(1,j)=(sin(xn(i,j)))*(sin((j*xn(i,j)^2)/pi))^20; 
end
 ft(i)=-sum(s); % Sphere function
end
%% 13. Exponential problem

   
%% 14. Goldstein and price problem  
  ft(i)= (1 + (xn(i,1) + xn(i,2) + 1)^2 * (19- 14*xn(i,1) + 3*xn(i,1)^2- 14*xn(i,2) + 6*xn(i,1)*xn(i,2) + 3*xn(i,2)^2)) * (30 + (2*xn(i,1)- 3*xn(i,2))^2 * (18- 32*xn(i,1) + 12*xn(i,1)^2 + 48*xn(i,2) -36*xn(i,1)*xn(i,2) + 27*xn(i,2)^2));
%% 15. Gulph research problem       
   s=zeros(1,99);
for i=1:npop 
for j=1:99
    t=j/100;
    y=25+sqrt((-50*log(t))^2);
   s(1,j)=exp(((-(abs(y-xn(i,2)))^xn(i,3))/xn(i,1))-t); 
end
 ft(i)=sum(s(1,:)); % Sphere function
end    
%% 16. Hosaki problem       
 ft(i)=(1 - 8*xn(i,1) + 7*(xn(i,1)^2)- (7/3)*(xn(i,1)^3) + (1/4)*(xn(i,1)^4))*(xn(i,2)^2) * exp(-xn(i,2));      
%% 17. Kowalic problem           
 a=[4 2 1 1/2 1/4 1/8 1/10 1/12 1/14 1/16];
b=[0.1957 0.1947 0.1735 0.1600 0.0844 0.0627 0.0456 0.0342 0.0323 0.0235 0.0246];

for i=1:npop 

    for j=1:10
       s(j)=(a(j)-(xn(i,1)*(b(j)^2+b(j)*xn(i,2))/(b(j)^2+b(j)*xn(i,3)+xn(i,4))))^2; 
    end
 ft(i)=sum(s); % Sphere function
end
%% 18.

%% 19. Meyer and roth problem
t=[1 2 1 2 0.1];
v=[1 1 2 2 0];
y=[0.126 0.219 0.076 0.126 0.186];
s=zeros(npop,5);
for i=1:npop 

    for j=1:5
       s(i,j)=(((xn(i,1)*xn(i,3)*t(j))/(1+xn(i,1)*t(j)+xn(i,2)*v(j)))-y(j))^2; 
    end
 ft(i)=sum(s(i,:)); % Sphere function
end

%% 20. Miele and cantrell problem
        ft(i)=(exp(xn(i,1))-xn(i,2))^4+100*(xn(i,2)-xn(i,3))^6+(tan(xn(i,3)-xn(i,4)))^4+xn(i,1)^8;

%% 21. Modified rosenbrock problem        
         ft(i)=100*(xn(i,2)- xn(i,1)^2)^2 + (6.4*(xn(i,2)-0.5)^2-xn(i,1)-0.6)^2;
         
         ...
             
     ft(i)=(xn(i,1)+10*xn(i,2))^2+ 5*(xn(i,3)-xn(i,4))^2 + (xn(i,2)-2*xn(i,3))^4 + 10*(xn(i,1)-xn(i,4))^4;
     ...
         for i=1:npop
z=zeros(1,nvar-1);
    for j=1:nvar-1
       z(1,j)=100*(xn(i,j+1)-xn(i,j)^2)+(xn(i,j)-1)^2; 
    end
 ft(i)=sum(z); % Sphere function
end
         
     xi=xn.^2;
     ft(i)=1-cos(2*pi*sqrt(sum(xi(i,:))))+ 0.1*sqrt(sum(xi(i,:)));
 %% 22. Rosenbrock problem
 s=zeros(1,nvar-1);
for i=1:npop 
for j=1:nvar-1
   s(1,j)=100*((xn(i,j+1)-xn(i,j)^2)^2)+(xn(i,j)-1)^2; 
end
 ft(i)=sum(s(1,:)); % Sphere function
end
%% 23. Box-Betts' Exponential Quadratic Sum Function:
g=zeros(1,10);
for i=1:npop
    for j=1:10
       g(j)=(exp(-0.1*j*xn(i,1))-exp(-0.1*j*xn(i,2))-(exp(-0.1*j)-exp(-j))*xn(i,3))^2; 
    end

  ft(i) = sum(g);% Sphere function
end


%% 24. Deflected corrugated spring problem

    s=zeros(1,nvar);
  for i=1:npop
      for j=1:nvar
          s(j)=(xn(i,j)-5)^2;
      end
      ft(i)=0.1*sum(s)-cos(5*sqrt(sum(s)));
  end
  %% 25. Dixon-price problem
  s=zeros(1,nvar);
for i=1:npop
    for j=2:nvar
       s(j)=j*(2*xn(i,j)^2 -xn(i,j-1))^2;
    end
 
  ft(i) = xn(i,1)^2 +sum(s);% Sphere function
end

%% 26. Zakharov's problem
s1=zeros(1,nvar);
s2=zeros(1,nvar);
for i=1:npop
    for j=1:nvar
       s1(j)=xn(i,j)^2;
       s2(j)=0.5*j*xn(i,j);
    end
 
  ft(i) = sum(s1)+(sum(s2))^2 +(sum(s2))^4;% Sphere function
end

%% 27. EX3 problem
s=zeros(1,nvar);
for i=1:npop
    if prod(xn(i,:))~=0
    for j=1:nvar            
s(j)=xn(i,j)^6 *(sin(1/xn(i,1))+2);
    end
 
  ft(i) = sum(s);     
    else ft(i)=0;
    end
end

%% 28. Deb 1 problem
s=zeros(1,nvar);
for i=1:npop
    for j=1:10
       s(j)=(sin(5*pi*(xn(i,j))))^6;
    end
 
  ft(i) = (-1/nvar)*sum(s);% Sphere function
end

%% 29. Deb 2 problem
s=zeros(1,nvar);
for i=1:npop
    for j=1:10
       s(j)=(sin(5*pi*(xn(i,j)^(3/4) -0.05)))^6;
    end
 
  ft(i) = (-1/nvar)*sum(s);% Sphere function
end

%% 30. Egg-holder problem
s=zeros(1,nvar);
for i=1:npop
    for j=1:nvar-1
       s(j)=-xn(i,j)*sin(sqrt(abs(xn(i,j)-xn(i,j+1)-47)))-(xn(i,j+1)+47)*sin(sqrt(abs(0.5*xn(i,j)+xn(i,j+1)+47)));
    end
 
  ft(i) = sum(s);% Sphere function
end
end




