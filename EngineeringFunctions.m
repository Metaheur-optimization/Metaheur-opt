function ft=EngineeringFunctions(X,Out) % Function for fitness evaluation
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%Engineering problems fitness functions and variables%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Fitness function:
Npopulation=Out.Npopulation;
ft=zeros(Npopulation,1);


switch Out.EngFunction
    %% 1. Three bar truss problem
    case 1
        
        Out.LowerBound=[0 0]; Out.UpperBound=[1 1];% Lower and upper bounds
        
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        g=zeros(Npopulation,3);                %Constraint function values
        penalty=zeros(1,3);                   %Penalty values
        penalty_constant=1*10^6;                       %Penalty constant
        
        for i=1:Npopulation
            g(i,1)=((sqrt(2)*X(i,1)+X(i,2))/(sqrt(2)*X(i,1)^2 +(2*X(i,1)*X(i,2))))*2 -2;
            g(i,2)=(X(i,2)/(sqrt(2)*X(i,1)^2 +(2*X(i,1)*X(i,2))))*2 -2;
            g(i,3)=(1/((sqrt(2)*X(i,2)) +X(i,1)))*2 -2;
            
            for j=1:3
                if g(i,j)<=0
                    penalty(j)=0;
                else
                    penalty(j)=penalty_constant*g(i,j);
                end
            end
            
            
            cost =(2*sqrt(2)*X(i,1)+X(i,2))*100;% Sphere function
            
            ft(i)=cost+abs(sum(penalty));
        end
        
        %% 2. Tension problem
    case 2
        Out.LowerBound=[0.05 0.25 2]; Out.UpperBound=[2 1.3 15];% Lower and upper bounds
        
        g=zeros(Npopulation,4);                  %Constraint functions values
        penalty=zeros(1,4);                     %Penalty Values
        penalty_constant=5*10^6;                         %Penalty constant
        
        for i=1:Npopulation
            g(i,1)=1-((X(i,2)^3 *X(i,3))/(71785*X(i,1)^4));
            g(i,2)=((4*X(i,2)^2 -X(i,1)*X(i,2))/(12566*(X(i,2)*X(i,1)^3 -X(i,1)^4)))+ (1/(5108*X(i,1)^2))- 1;
            g(i,3)=1- (140.45*X(i,1)/(X(i,2)^2 *X(i,3)));
            g(i,4)=((X(i,1)+X(i,2))/1.5)-1;
            
            for j=1:4
                if g(i,j)<=0
                    penalty(j)=0;
                else
                    penalty(j)=penalty_constant*g(i,j);
                end
            end
            
            cost =(X(i,3)+2)*X(i,2)*X(i,1)^2;
            
            ft(i)=cost+abs(sum(penalty));
        end
        
        %% 3. Welded beam problem
    case 3
        Out.LowerBound=[0.1 0.1 0.1 0.1]; Out.UpperBound=[2 10 10 2]; % Lower and upper bounds
        
        %% Constants
        P=6000;L=14;E=30*10^6;G=12*10^6;toemax=13600;sigmax=30000;Sigmax=0.25;
        
        %% Initialize
        g=zeros(Npopulation,7);               %Constaint function values
        penalty=zeros(1,7);                  %Penalty values
        penalty_constant=5;                           %Penalty constant
        
        for i=1:Npopulation
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
            
            g(i,1)=toe-toemax;
            g(i,2)=sig-sigmax;
            g(i,3)=X(i,1)-X(i,4);
            g(i,4)=0.10471*X(i,1)^2 +0.04811*X(i,3)*X(i,4)*(14+X(i,2))-5;
            g(i,5)=0.125-X(i,1);
            g(i,6)=Sig-Sigmax;
            g(i,7)=P-Pc;
            
            for j=1:7
                if g(i,j)<=0
                    penalty(j)=0;
                else
                    penalty(j)=penalty_constant*g(i,j);
                end
            end
            
            
            
            cost =1.10471*X(i,1)^2 *X(i,2) +0.04811*X(i,3)*X(i,4)*(14+X(i,2));
            
            ft(i)=cost+abs(sum(penalty));
        end
        
        %% 4. Reducing
    case 4
        Out.LowerBound=[2.6 0.7 17 7.3 7.3 2.9 5]; Out.UpperBound=[3.6 0.8 28 8.3 8.3 3.9 5.5]; % Lower and upper bounds
        
        g=zeros(Npopulation,11);
        penalty=zeros(1,11);
        penalty_constant=0.2*10^2;
        
        
        for i=1:Npopulation
            g(i,1)=(27/(X(i,1)*X(i,3)*X(i,2)^2))-1;
            g(i,2)=(397.5/(X(i,1)*X(i,2)^2 *X(i,3)^2))-1;
            g(i,3)=((1.93*X(i,4)^3)/(X(i,2)*X(i,3)*X(i,6)^4))-1;
            g(i,4)=((1.93*X(i,5)^3)/(X(i,2)*X(i,3)*X(i,7)^4))-1;
            g(i,5)=((((745*X(i,4)/X(i,2)*X(i,3))^2 +(16.9*10^6))^0.5)/(110*X(i,6)^3))-1;
            g(i,6)=((((745*X(i,5)/X(i,2)*X(i,3))^2 +(157.7*10^6))^0.5)/(85*X(i,7)^3))-1;
            g(i,7)=(X(i,2)*X(i,3)/40)-1;
            g(i,8)=(5*X(i,2)/X(i,1))-1;
            g(i,9)=(X(i,1)/(12*X(i,2)))-1;
            g(i,10)=((1.5*X(i,6) +1.9)/X(i,4))-1;
            g(i,11)=((1.1*X(i,7) +1.9)/X(i,5))-1;
            
            for j=1:11
                if g(i,j)<=0
                    penalty(j)=0;
                else
                    p(j)=penalty_constant*g(i,j);
                end
            end
            
            cost =0.7854*X(i,1)*X(i,2)^2 *(3.3333*X(i,3)^2 +14.9334*X(i,3)-43.0934)-1.508*X(i,1)*(X(i,6)^2 +X(i,7)^2)+7.4777*(X(i,6)^3 +X(i,7)^3)+0.7854*(X(i,4)*X(i,6)^2 +X(i,5)*X(i,7)^2);
            
            ft(i)=cost+abs(sum(penalty));
        end
        
        %% 5. Pressure vessel problem
    case 5
        Out.LowerBound=[0.0625 0.0625 10 10]; Out.UpperBound=[0.0625*99 0.0625*99 200 200];% Lower and upper bounds
        
        g=zeros(Npopulation,4);
        penalty=zeros(1,6);
        penalty_constant=1*10^6;
        penalty_constant2=2*10^3;
        penalty_constant3=5*10^3;
        for i=1:Npopulation
            g(i,1)=-X(i,1)+0.0193*X(i,3);
            g(i,2)=-X(i,2)+0.00954*X(i,3);
            g(i,3)=-pi*X(i,3)^2 *X(i,4)-4/3*pi*X(i,3)^3 +1296000;
            g(i,4)=X(i,4)-240;
            
            for j=1:4
                if g(i,j)<=0
                    penalty(j)=0;
                else
                    penalty(j)=penalty_constant*g(i,j);
                end
            end
            
            
            if mod(X(i,1),0.0625)==0
                penalty(5)=0;
            else
                penalty(5)=penalty_constant2*mod(X(i,1),0.0625);
            end
            
            if mod(X(i,2),0.0625)==0
                penalty(6)=0;
            else
                penalty(6)=penalty_constant3*mod(X(i,2),0.0625);
            end
            cost =0.6224*X(i,1)*X(i,3)*X(i,4)+1.7781*X(i,2)*X(i,3)^2 +3.1661*X(i,1)^2 *X(i,4)+19.84*X(i,1)^2 *X(i,3);
            
            ft(i)=cost+abs(sum(penalty));
        end
        
end