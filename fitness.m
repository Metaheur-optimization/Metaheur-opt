function [ft,PenaltyBool]=fitness(X,i,Out) % Function for fitness evaluation
%%%%% General Functinons anf Engineering Functions   %%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Npopulation=Out.Npopulation;
NDecisionVariable=Out.NDecisionVariable;
PenaltyBool=0;
switch Out.Function
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%% GENERAL FUNCTIONS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %% 1. Ackley's problem (f5 in Asghazadeh's paper)
    case 1
%         s=0;
%         s1=0;
%        for iii=1:NDecisionVariable
%         s=s+(X(i,iii))^2;
%         s1=s1+cos((X(i,iii)*2*pi));
%        end
%        T1=exp(-0.2*sqrt(1/NDecisionVariable*(sum(X(i,3:4)))));
%        T2=exp(1/NDecisionVariable*(sum(cos(2*pi*X(i,1:2)))));
%         T1=exp(-0.2*sqrt(1/NDecisionVariable*(s)));
%         T2=exp(1/NDecisionVariable*(s1));
%         ft = -20*T1-T2+20+exp(1);
        
       [s,~]=sumsqr(X(i,:));
       ft=-20*exp(-0.2*sqrt(1/NDecisionVariable*(s)))-exp(1/NDecisionVariable*(sum(cos(2*pi*X(i,:)))))++20+exp(1);
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
        ft=a*(X(i,2)- b*X(i,1)^2 + c*X(i,1)- r)^2 + s*(1-t)*cos(X(i,1)) + s; 
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
        ft=sum(s(1,:)); 
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
        ft=sum(z); 
        
        xi=X.^2;
        ft=1-cos(2*pi*sqrt(sum(xi(i,:))))+ 0.1*sqrt(sum(xi(i,:)));
        %% 19. Rosenbrock problem (f2 in Asghazadeh's paper)
    case 19
%         s=zeros(1,NDecisionVariable-1);
%         s=0;
%         for j=1:NDecisionVariable-1
%             T1=(X(i,j)).^2;
%             T2=X(i,j+1);
%             T3=((T1-T2).^2)*100;
%             T4=(X(i,j)-1).^2;
%             
%             T5=(T3+T4);
%             s=s+T5;
% 
%         end
%         ft=s;
        
        s=sum(100*(X(i,2:end)-X(i,1:end-1).^2).^2+(X(i,1:end-1)-1).^2);
        ft=s;
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
        
        ft = X(i,1)^2 +sum(s);
        %% 23. Zakharov's problem
    case 23
        s1=zeros(1,NDecisionVariable);
        s2=zeros(1,NDecisionVariable);
        for j=1:NDecisionVariable
            s1(j)=X(i,j)^2;
            s2(j)=0.5*j*X(i,j);
        end
        
        ft = sum(s1)+(sum(s2))^2 +(sum(s2))^4;
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
        
        ft= (-1/NDecisionVariable)*sum(s);
        %% 26. Deb 2 problem
    case 26
        s=zeros(1,NDecisionVariable);
        for j=1:10
            s(j)=(sin(5*pi*(X(i,j)^(3/4) -0.05)))^6;
        end
        
        ft = (-1/NDecisionVariable)*sum(s);
        %% 27. Egg-holder problem
    case 27
        s=zeros(1,NDecisionVariable);
        for j=1:NDecisionVariable-1
            s(j)=-X(i,j)*sin(sqrt(abs(X(i,j)-X(i,j+1)-47)))-(X(i,j+1)+47)*sin(sqrt(abs(0.5*X(i,j)+X(i,j+1)+47)));
        end
        ft = sum(s);
        
        
        %% Griewank function (f3 in Asghazadeh's paper)
    case 28
        
%         Prod=1;
%         for iii=1:NDecisionVariable
%             s(iii)=((X(i,iii))^2)/4000;
%             s1(iii)=cos((X(i,iii)/sqrt(iii)));
%             Prod=Prod*s1(iii);
%         end
%         T1=sum(s);
%         T2=Prod;
%         ft=T1-T2+1;
        
        In=1:size(X,2);
        ft=sumsqr(X(i,:))/4000-prod(cos(X(i,:)./sqrt(In(1,:))))+1;
        
        %% Sphere function (f1 in Asghazadeh's paper)
    case 29
%         s=0;
%         for kkk=1:NDecisionVariable
%             s=s+((X(i,kkk)).^2);
%         end
%         ft=s;
      ft=sumsqr(X(i,:));
       
        
        
        
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%    
    %%%%%%%% ENGINEERING FUNCTIONS   %%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    %% 1. Three bar truss problem
    case 30
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        g=zeros(1,3);                %Constraint function values
        penalty=zeros(1,3);                   %Penalty values
        
        g(1)=((sqrt(2)*X(i,1)+X(i,2))/(sqrt(2)*X(i,1)^2 +(2*X(i,1)*X(i,2))))*2 -2;
        g(2)=(X(i,2)/(sqrt(2)*X(i,1)^2 +(2*X(i,1)*X(i,2))))*2 -2;
        g(3)=(1/((sqrt(2)*X(i,2)) +X(i,1)))*2 -2;
        
        for j=1:3
            if g(j)<=0
                penalty(j)=0;
            else
                penalty(j)=1*10^6*(1+g(j));
                PenaltyBool=1;
            end
        end
        
        
        cost =(2*sqrt(2)*X(i,1)+X(i,2))*100;% Sphere function
        
        ft=cost+abs(sum(penalty));
        %% 2. Tension problem
    case 31
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
        %% 3. Welded beam problem
    case 32
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
        %% 4. Reducing
    case 33
        p=zeros(1,11);
        g=zeros(1,11);
        penalty=zeros(1,11);
        
        g(1)=(27/(X(i,1)*X(i,3)*X(i,2)^2))-1;
        g(2)=(397.5/(X(i,1)*X(i,2)^2 *X(i,3)^2))-1;
        g(3)=((1.93*X(i,4)^3)/(X(i,2)*X(i,3)*X(i,6)^4))-1;
        g(4)=((1.93*X(i,5)^3)/(X(i,2)*X(i,3)*X(i,7)^4))-1;
        g(5)=((((745*X(i,4)/X(i,2)*X(i,3))^2 +(16.9*10^6))^0.5)/(110*X(i,6)^3))-1;
        g(6)=((((745*X(i,5)/X(i,2)*X(i,3))^2 +(157.7*10^6))^0.5)/(85*X(i,7)^3))-1;
        g(7)=(X(i,2)*X(i,3)/40)-1;
        g(8)=(5*X(i,2)/X(i,1))-1;
        g(9)=(X(i,1)/(12*X(i,2)))-1;
        g(10)=((1.5*X(i,6) +1.9)/X(i,4))-1;
        g(11)=((1.1*X(i,7) +1.9)/X(i,5))-1;
        
        for j=1:11
            if g(j)<=0
                penalty(j)=0;
            else
                penalty(j)=0.2*10^2*(1+g(j));
                PenaltyBool=1;
            end
        end
        
        cost =0.7854*X(i,1)*X(i,2)^2 *(3.3333*X(i,3)^2 +14.9334*X(i,3)-43.0934)-1.508*X(i,1)*(X(i,6)^2 +X(i,7)^2)+7.4777*(X(i,6)^3 +X(i,7)^3)+0.7854*(X(i,4)*X(i,6)^2 +X(i,5)*X(i,7)^2);
        
        ft=cost+abs(sum(penalty));
        %% 5. Pressure vessel problem
    case 34
        g=zeros(Npopulation,4);
        penalty=zeros(1,6);
        penalty_constant=1*10^6;
        penalty_constant2=2*10^3;
        penalty_constant3=5*10^3;
        g(1)=-X(i,1)+0.0193*X(i,3);
        g(2)=-X(i,2)+0.00954*X(i,3);
        g(3)=-pi*X(i,3)^2 *X(i,4)-4/3*pi*X(i,3)^3 +1296000;
        g(4)=X(i,4)-240;
        
        for j=1:4
            if g(j)<=0
                penalty(j)=0;
            else
                penalty(j)=penalty_constant*(1+g(j));
                PenaltyBool=1;
            end
        end
        
        
        if mod(X(i,1),0.0625)==0
            penalty(5)=0;
            PenaltyBool=1;
        else
            penalty(5)=penalty_constant2*mod(X(i,1),0.0625);
            PenaltyBool=1;
        end
        
        if mod(X(i,2),0.0625)==0
            penalty(6)=0;
            PenaltyBool=1;
        else
            penalty(6)=penalty_constant3*mod(X(i,2),0.0625);
            PenaltyBool=1;
        end
        cost =0.6224*X(i,1)*X(i,3)*X(i,4)+1.7781*X(i,2)*X(i,3)^2 +3.1661*X(i,1)^2 *X(i,4)+19.84*X(i,1)^2 *X(i,3);
        
        ft=cost+abs(sum(penalty));
    
        
end

