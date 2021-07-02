function [ft,PenaltyBool]=fitness(X,i,Out) % Function for fitness evaluation
%%%%% General Functinons anf Engineering Functions   %%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
global g NoofInfeasibleSol
Npopulation=Out.Npopulation;
NDecisionVariable=Out.NDecisionVariable;
PenaltyBool=0;

switch Out.Function
    %% 1. Ackley's problem
    case 1
         s=0;
        s1=0;
       for iii=1:NDecisionVariable
        s=s+(X(i,iii))^2;
        s1=s1+cos((X(i,iii)*2*pi));
       end
%         X(i,3)=(X(i,1))^2;
%        X(i,4)=(X(i,2))^2;
%        T1=exp(-0.2*sqrt(1/NDecisionVariable*(sum(X(i,3:4)))));
%        T2=exp(1/NDecisionVariable*(sum(cos(2*pi*X(i,1:2)))));
%        
       T1=exp(-0.2*sqrt(1/NDecisionVariable*(s)));
       T2=exp(1/NDecisionVariable*(s1));
       
       
        ft = -20*T1-T2+20+exp(1);
        %% 2. Aluffi-Pentini's problem
    case 2
        ft= 0.25*X(i,1)^4 - 0.5*X(i,1)^2 + 0.1*X(i,1) + 0.5*X(i,2)^2;
        %% 3. Becker and Lago problem
    case 3
        ft= (abs(X(i,1))- 5)^2 + (abs(X(i,2))- 5)^2;
        %% 4. Bohachevsky 1 problem
    case 4
        ft= (X(i,1)^2) + (2*X(i,2)^2)- 0.3*cos(3*pi*X(i,1))-0.4*cos(4*pi*X(i,2))+ 0.7;
        %% 5. Bohachevsky 2 problem
    case 5
        ft= (X(i,1)^2) + (2*X(i,2)^2)- 0.3*cos(3*pi*X(i,1)) *cos(4*pi*X(i,2))+ 0.3;
        %% 6. Branin problem
    case 6
        a=1; b=5.1/(4*pi^2); c=5/pi; r=6 ; s=10; t=1/(8*pi);
        ft=a*(X(i,2)- b*X(i,1)^2 + c*X(i,1)- r)^2 + s*(1-t)*cos(X(i,1)) + s; % Sphere function
        %% 7. Camel back 3- three hump problem
    case 7
        ft= (2*X(i,1)^2)- (1.05*X(i,1)^4) + ((1/6)*X(i,1)^6) + X(i,1)*X(i,2) + X(i,2)^2;
        %% 8. Camel back 6 - six hump problem
    case 8
        ft= (4- 2.1*(X(i,1)^2) + X(i,1)^4/3)*(X(i,1)^2) + X(i,1)*X(i,2) + (-4 + 4*X(i,2)^2)*X(i,2)^2;
        %% 9. Cosine mixture problem
    case 9
        xi=X.^2;
        ft= 0.1*sum(cos(5*pi*X(i,:)))- sum(xi(i,:));
        %% 10. Dekkers and Aarts problem
    case 10
        ft=(10^5)*(X(i,1)^2)+(X(i,2)^2)-(((X(i,1)^2)+(X(i,2)^2))^2)+(10^-5)*(((X(i,1)^2)+(X(i,2)^2))^4);
        %% 11. Easom problem
    case 11
        ft= -cos(X(i,1))*cos(X(i,2))*exp(-(X(i,1)- pi)^2- (X(i,2)- pi)^2);
        %% 12. Epistatic michalewics 5 problem
    case 12
        s=zeros(1,NDecisionVariable);
        for j=1:NDecisionVariable
            s(1,j)=(sin(X(i,j)))*(sin((j*X(i,j)^2)/pi))^20;
        end
        ft=-sum(s); 
        %% 13. Goldstein and price problem
    case 13
        ft= (1 + (X(i,1) + X(i,2) + 1)^2 * (19- 14*X(i,1) + 3*X(i,1)^2- 14*X(i,2) + 6*X(i,1)*X(i,2) + 3*X(i,2)^2)) * (30 + (2*X(i,1)- 3*X(i,2))^2 * (18- 32*X(i,1) + 12*X(i,1)^2 + 48*X(i,2) -36*X(i,1)*X(i,2) + 27*X(i,2)^2));
        %% 14. Gulph research problem
    case 14
        s=zeros(1,99);
        for j=1:99
            t=j/100;
            y=25+sqrt((-50*log(t))^2);
            s(1,j)=exp(((-(abs(y-X(i,2)))^X(i,3))/X(i,1))-t);
        end
        ft=sum(s(1,:)); % Sphere function
        %% 15. Hosaki problem
    case 15
        ft=(1 - 8*X(i,1) + 7*(X(i,1)^2)- (7/3)*(X(i,1)^3) + (1/4)*(X(i,1)^4))*(X(i,2)^2) * exp(-X(i,2));
        %% 16. Kowalic problem
    case 16
        a=[4 2 1 1/2 1/4 1/8 1/10 1/12 1/14 1/16];
        b=[0.1957 0.1947 0.1735 0.1600 0.0844 0.0627 0.0456 0.0342 0.0323 0.0235 0.0246];
        for j=1:10
            s(j)=(a(j)-(X(i,1)*(b(j)^2+b(j)*X(i,2))/(b(j)^2+b(j)*X(i,3)+X(i,4))))^2;
        end
        ft=sum(s); 
        %% 17. Meyer and roth problem
    case 17
        t=[1 2 1 2 0.1];
        v=[1 1 2 2 0];
        y=[0.126 0.219 0.076 0.126 0.186];
        s=zeros(Npopulation,5);
        for j=1:5
            s(i,j)=(((X(i,1)*X(i,3)*t(j))/(1+X(i,1)*t(j)+X(i,2)*v(j)))-y(j))^2;
        end
        ft=sum(s(i,:)); 
        %% 18. Miele and cantrell problem
    case 18
        ft(i)=(exp(X(i,1))-X(i,2))^4+100*(X(i,2)-X(i,3))^6+(tan(X(i,3)-X(i,4)))^4+X(i,1)^8;
        %% ??. Modified rosenbrock problem
        ft(i)=100*(X(i,2)- X(i,1)^2)^2 + (6.4*(X(i,2)-0.5)^2-X(i,1)-0.6)^2;
        ...
            ft(i)=(X(i,1)+10*X(i,2))^2+ 5*(X(i,3)-X(i,4))^2 + (X(i,2)-2*X(i,3))^4 + 10*(X(i,1)-X(i,4))^4;
        ...
            z=zeros(1,NDecisionVariable-1);
        for j=1:NDecisionVariable-1
            z(1,j)=100*(X(i,j+1)-X(i,j)^2)+(X(i,j)-1)^2;
        end
        ft=sum(z); % Sphere function
        
        xi=X.^2;
        ft=1-cos(2*pi*sqrt(sum(xi(i,:))))+ 0.1*sqrt(sum(xi(i,:)));
        %% 19. Rosenbrock problem
    case 19
        s=zeros(1,NDecisionVariable-1);
        for j=1:NDecisionVariable-1
            s(1,j)=100*((X(i,j+1)-X(i,j)^2)^2)+(X(i,j)-1)^2;
        end
        ft=sum(s(1,:)); 
        %% 20. Box-Betts' Exponential Quadratic Sum Function:
    case 20
        g=zeros(1,10);
        for j=1:10
            g(j)=(exp(-0.1*j*X(i,1))-exp(-0.1*j*X(i,2))-(exp(-0.1*j)-exp(-j))*X(i,3))^2;
        end
        
        ft = sum(g);
        %% 21. Deflected corrugated spring problem
    case 21
        s=zeros(1,NDecisionVariable);
        for j=1:NDecisionVariable
            s(j)=(X(i,j)-5)^2;
        end
        ft=0.1*sum(s)-cos(5*sqrt(sum(s)));
        %% 22. Dixon-price problem
    case 22
        s=zeros(1,NDecisionVariable);
        for j=2:NDecisionVariable
            s(j)=j*(2*X(i,j)^2 -X(i,j-1))^2;
        end
        
        ft = X(i,1)^2 +sum(s);% Sphere function
        %% 23. Zakharov's problem
    case 23
        s1=zeros(1,NDecisionVariable);
        s2=zeros(1,NDecisionVariable);
        for j=1:NDecisionVariable
            s1(j)=X(i,j)^2;
            s2(j)=0.5*j*X(i,j);
        end
        
        ft = sum(s1)+(sum(s2))^2 +(sum(s2))^4;% Sphere function
        %% 24. EX3 problem
    case 24
        s=zeros(1,NDecisionVariable);
        if prod(X(i,:))~=0
            for j=1:NDecisionVariable
                s(j)=X(i,j)^6 *(sin(1/X(i,1))+2);
            end
            ft = sum(s);
        else
            ft=0;
        end
        %% 25. Deb 1 problem
    case 25
        s=zeros(1,NDecisionVariable);
        for j=1:10
            s(j)=(sin(5*pi*(X(i,j))))^6;
        end
        
        ft= (-1/NDecisionVariable)*sum(s);% Sphere function
        %% 26. Deb 2 problem
    case 26
        s=zeros(1,NDecisionVariable);
        for j=1:10
            s(j)=(sin(5*pi*(X(i,j)^(3/4) -0.05)))^6;
        end
        
        ft = (-1/NDecisionVariable)*sum(s);% Sphere function
        %% 27. Egg-holder problem
    case 27
        s=zeros(1,NDecisionVariable);
        for j=1:NDecisionVariable-1
            s(j)=-X(i,j)*sin(sqrt(abs(X(i,j)-X(i,j+1)-47)))-(X(i,j+1)+47)*sin(sqrt(abs(0.5*X(i,j)+X(i,j+1)+47)));
        end
        ft = sum(s);% Sphere function
        
        
        %% Griewank function
         case 28
         
          Prod=1;
          for iii=1:NDecisionVariable
          s(iii)=((X(i,iii))^2)/4000;
          s1(iii)=cos((X(i,iii)/sqrt(iii)));
          Prod=Prod*s1(iii);
          end
          
          
          
          T1=sum(s);
          T2=Prod;
        ft=T1-T2+1;
        
    case 29 %Ackley function
        [s,~]=sumsqr(X(i,:));
       ft=-20*exp(-0.2*sqrt(1/NDecisionVariable*(s)))-exp(1/NDecisionVariable*(sum(cos(2*pi*X(i,:)))))+20+exp(1);
          
    case 30 % Sphere function
        ft=sumsqr(X(i,:));
        
        
    case 31 %Griewank function
       In=1:size(X,2);
        ft=sumsqr(X(i,:))/4000-prod(cos(X(i,:)./sqrt(In(1,:))))+1;
    case 32 %Rosenbrock problem
     ft=sum(100*(X(i,2:end)-X(i,1:end-1).^2).^2+(X(i,1:end-1)-1).^2); 
     
     
    case 33 % Schwefel
       T1=0;
       p=1;
       for hh=1:NDecisionVariable
         p=p*abs(X(i,hh));  
         T1=T1+abs(X(i,hh));
       end
       ft=T1+p;
       
       
       %% Engineering problems 
    case 34 % Tension problem
     g=zeros(1,4);                  %Constraint functions values
        %         penalty=zeros(1,4);                     %Penalty Values
        penalty=0;
        
        
        g(1)=1-((X(i,2)^3 *X(i,3))/(71785*X(i,1)^4));
        g(2)=((4*X(i,2)^2 -X(i,1)*X(i,2))/(12566*(X(i,2)*X(i,1)^3 -X(i,1)^4)))+ (1/(5108*X(i,1)^2))- 1;
        g(3)=1- (140.45*X(i,1)/(X(i,2)^2 *X(i,3)));
        g(4)=((X(i,1)+X(i,2))/1.5)-1;
        
        for j=1:4
            if g(j)>0
                penalty=penalty+5*10^6*(1+g(j));
                PenaltyBool=1;
            end
        end
        
        cost =(X(i,3)+2)*X(i,2)*X(i,1)^2;
        
        ft=cost+penalty;   
        
        
    case 35 % Welded beam problem
      %% Constants
        P=6000;L=14;E=30*10^6;G=12*10^6;toemax=13600;sigmax=30000;Sigmax=0.25;
        
        %% Initialize
        g=zeros(1,7);               %Constaint function values
        penalty=zeros(1,7);                  %Penalty values
        
        %% Equations
        Pc=64746.022*(1-0.0282346*X(i,3))*X(i,3)*X(i,4)^3;
        sig=6*P*L/(X(i,4)*X(i,3)^2);
        J=2*(sqrt(2)*X(i,1)*X(i,2)*(X(i,2)^2/12 +((X(i,1)+X(i,3))/2)^2));
        Sig=4*P*L^3/(E*X(i,3)^3 *X(i,4));
        R=sqrt(X(i,2)^2/4 +((X(i,1)+X(i,3))/2)^2);
        toep=P/(sqrt(2)*X(i,1)*X(i,2));
        M=P*(L+X(i,2)/2);
        toez=M*R/J;
        toe=sqrt(toep^2 +(2*toep*toez*X(i,2)/(2*R)) +toez^2);
        
        g(1)=toe-toemax;
        g(2)=sig-sigmax;
        g(3)=X(i,1)-X(i,4);
        g(4)=0.10471*X(i,1)^2 +0.04811*X(i,3)*X(i,4)*(14+X(i,2))-5;
        g(5)=0.125-X(i,1);
        g(6)=Sig-Sigmax;
        g(7)=P-Pc;
        
        for j=1:7
            if g(j)<=0
                penalty(j)=0;
            else
                penalty(j)=5*(1+g(j));
                PenaltyBool=1;
            end
        end
        
        
        
        cost =1.10471*X(i,1)^2 *X(i,2) +0.04811*X(i,3)*X(i,4)*(14+X(i,2));
        
        ft=cost+abs(sum(penalty));  
        
        
    case 36  % Gear Train design
        
        
        ft= ((1/6.931)-((floor(X(i,3))*floor(X(i,2)))/(floor(X(i,1))* floor(X(i,4)))))^2;
        
    case 37  % Three-bar truss design problem
        
       g=zeros(1,3);                  %Constraint functions values
        
        penalty=0;
        PenaltyBool=0;
        
        g(1)=((((sqrt(2)*X(i,1))+X(i,2))/((sqrt(2)*(X(i,1)).^2)+2*X(i,1)*X(i,2)))*2)-2;
        
        
        
        g(2)=(((X(i,2))/((sqrt(2)*(X(i,1)).^2)+2*X(i,1)*X(i,2)))*2)-2;
        g(3)=((1/((sqrt(2)*X(i,2))+X(i,1)))*2)-2;
       
        
        
        
        for j=1:3
            if g(j)>0
                %penalty=penalty+5*10^6*(1+g(j));
                
                penalty=penalty+100000000000;
                
                PenaltyBool=1;
            end
            
        end
       
        
        NoofInfeasibleSol=NoofInfeasibleSol+PenaltyBool;
        
        cost =(2*(sqrt(2)*X(i,1))+X(i,2))*100;;
        
        ft=cost+penalty; 
        
        
    case 38 % Pressure vessel design problem
        
     g=zeros(1,4);                  %Constraint functions values
        
        penalty=0;
         g(1)=-X(i,1)+0.0193*X(i,3);
        g(2)=-X(i,2)+0.00954*X(i,3);
        g(3)=-pi*X(i,3)^2 *X(i,4)-4/3*pi*X(i,3)^3 +1296000;
        g(4)=X(i,4)-240;
        
        for j=1:4
            if g(j)>0
                penalty=penalty+5*10^6*(1+g(j));
                PenaltyBool=1;
            end
        end
        
        cost =0.6224*X(i,1)*X(i,3)*X(i,4)+1.7781*X(i,2)*X(i,3)^2 +3.1661*X(i,1)^2 *X(i,4)+19.84*X(i,1)^2 *X(i,3);
        
        ft=cost+penalty;
        
    case 39  % Belleville spring design problem
        g=zeros(1,6);                  %Constraint functions values
        step=1.4:0.1:2.8;
        fa=[1 0.85 0.77 0.71 0.66 0.63 0.6 0.58 0.56 0.55 0.53 0.52 0.51 0.51 0.5];
        F=[step;fa];
        a=ceil(X(i,3)/X(i,4));
        penalty=0;
        k=(X(i,1)/X(i,2));
        sigma=(6/(pi*log(k)))*((log(k)-1)/log(k)).^2;
        beta=(6/(pi*log(k)))*(((log(k)-1)/(log(k)))-1);
        Alfa=(6/(pi*log(k)))*((log(k)-1)/log(k));
       if a<=1 
           sigmaOne=a*1;
       elseif a>=2.8
           sigmaOne=a*0.5;
       else
           sigmaOne=a*F(2, find(F==a));
       end
       g(1)=200 -((4*30*10^6*0.2)/(0.91*sigma*(X(i,1)).^2))*(beta*(X(i,3)-0.1)+(Alfa*X(i,4)));
       g(2)=(((4*30*10^6*0.2)/(0.91*sigma*(X(i,1)).^2))*(((X(i,3)-0.1)*(X(i,3)-.2)*X(i,4))+(X(i,4)).^4))-5400;
       g(3)=sigmaOne-0.2;
       g(4)=(2-X(i,3)-X(i,4));
       g(5)=(12.01-X(i,1));
       g(6)=(X(i,1)-X(i,2));
       g(7)=(0.3-(X(i,3)/g(6)));
       
       for j=1:7
            if g(j)<0
                penalty=penalty+5*10^6*(1+g(j));
                PenaltyBool=1;
            end
        end
       
      cost= 0.07075*pi*((X(i,1)).^2-(X(i,2)).^2)*X(i,4);
      
       ft=cost+penalty;  
       
       
    case 40 %Speed reducer design problem
       
        g=zeros(1,11); 
        penalty=0;
        
%         g(1)=
    
    
    
    
    % Tension/compression spring design 
    case 41   
        g=zeros(1,4);                  %Constraint functions values
        penalty=0;
        
        numin_g1 = (X(i,2)^3) * X(i,3);
        denom_g1 = 71785 * (X(i,1)^4);
        g(1)=1 - (numin_g1/denom_g1);
        
        numin_g2 = 4 * (X(i,2)^2) - (X(i,1)*X(i,2));
        denom_g2_1 = 12566 * ((X(i,2) * (X(i,1)^3)) - (X(i,1)^4));
        denom_g2_2 = 5108 * (X(i,1)^2);
        g(2)=(numin_g2/denom_g2_1) + (1/denom_g2_2) - 1;
        
        numin_g3 = 140.45 * X(i,1);
        denum_g3 = (X(i,2)^2) * X(i,3);
        g(3)= 1 - (numin_g3/denum_g3);
        
        numin_g4 = X(i,1) + X(i,2);
        g(4)=(numin_g4/1.5) - 1;
        
        for j=1:4
            if g(j) > 0
                penalty=penalty+10^2*(1+g(j));
                PenaltyBool=1;
            end
        end
        
        
        ft = (X(i,3) + 2) * X(i,2) * (X(i,1)^2) + penalty;
end

