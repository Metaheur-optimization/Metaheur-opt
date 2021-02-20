function ft=fitness(X,i,Out) % Function for fitness evaluation

Npopulation=Out.Npopulation;
NDecisionVariable=Out.NDecisionVariable;

switch Out.Function
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
        %s=zeros(1,NDecisionVariable-1);
%         s=0;
%         for j=1:NDecisionVariable-1
%             T1=(X(i,j))^2;
%             T2=X(i,j+1);
%             T3=((T1-T2)^2)*100;
%             T4=(X(i,j)-1)^2;
%             
%             T5=(T3+T4);
%             s=s+T5;
% 
%         end
%         ft=s;
        
        ft=sum(100*(X(i,2:end)-X(i,1:end-1).^2).^2+(X(i,1:end-1)-1).^2);

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
%             s=s+((X(i,kkk))^2);
%         end
%         ft=s;

        ft=sumsqr(X(i,:));
        
end

