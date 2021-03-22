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
       
       ft=sumsqr(X(i,:));
         
    case 2
       
        ft=sum(100*(X(i,2:end)-X(i,1:end-1).^2).^2+(X(i,1:end-1)-1).^2);
        %% Griewank function (f3 in Asghazadeh's paper)
    case 3
        In=1:size(X,2);
        ft=sumsqr(X(i,:))/4000-prod(cos(X(i,:)./sqrt(In(1,:))))+1;
        
        %% Sphere function (f1 in Asghazadeh's paper)
    case 4       

        
    case 5
     [s,~]=sumsqr(X(i,:));
       ft=-20*exp(-0.2*sqrt(1/NDecisionVariable*(s)))-exp(1/NDecisionVariable*(sum(cos(2*pi*X(i,:)))))++20+exp(1);
          
       
        
end

