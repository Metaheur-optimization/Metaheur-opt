
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%This function returns the lower and upper boundary of variables into the main function according to only number of function
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [l u]=BoundaryOfVariables(Func) % Function for returning lower and upper boundary of variables

switch Func
    
    %% 1. Ackley's problem
    case 1
        l(1:10)=-30;
        u(1:10)=30;
        
        %% 2. Aluffi-Pentini's problem
    case 2
        l(1:2)=-10;
        u(1:2)=10;  
    
       %% 3. Becker and Lago problem
    case 3
       l(1:2)=-10;
       u(1:2)=10; 
       
       %% 4. Bohachevsky 1 problem
    case 4
       l(1:2)=-50;
       u(1:2)=50; 
       
       %% 5. Bohachevsky 2 problem 
    case 5
       l(1:2)=-50;
       u(1:2)=50;
       
       %% 6. Branin problem 
    case 6
        l=[-5 0];
        u=[10 15];
        
        %% 7. Camel back 3- three hump problem 
    case 7
       l(1:2)=-5;
       u(1:2)=5;
       
       %% 8. Camel back 6 - six hump problem
    case 8
       l(1:2)=-5;
       u(1:2)=5;
       
       %% 9. Cosine mixture problem 
    case 9
       l(1:2)=-1;
       u(1:2)=1; 
       
       %% 10. Dekkers and Aarts problem
    case 10
    l(1:2)=-20;
    u(1:2)=20; 
    
     %% 11. Easom problem
    case 11
    l(1:2)=-10;
    u(1:2)=10; 
       
     %% 12. Epistatic michalewics 5 problem   
    case 12
    l(1:5)=0;
    u(1:5)=pi;  
    
    %% 13. Goldstein and price problem 
    case 13
    l(1:2)=-2;
    u(1:2)=2;
    
    %% 14. Gulph research problem 
    case 14
    l(1:3)=0;
    u(1:3)=100; 
    
    %% 15. Hosaki problem  
    case 15
    l(1:2)=0;
    u(1:2)=10; 
    
    %% 16. Kowalic problem   
    case 16
    l(1:4)=0;
    u(1:4)=0.42; 
    
    %% 17. Meyer and roth problem
    case 17
    l(1:3)=-10;
    u(1:3)=10; 
    
    %% 18. Miele and cantrell problem
    case 18
    l(1:4)=-1;
    u(1:4)=1;  
    
     %% 19. Rosenbrock problem
    case 19
    l(1:10)=-30;
    u(1:10)=30;     
    
    %% 20. Box-Betts' Exponential Quadratic Sum Function:
    case 20
        l=[0.9 9 0.9];
        u=[1.2 11.2 1.2];
        
        %% 21. Deflected corrugated spring problem
    case 21
        
        
          %% 22. Dixon-price problem
    case 22
    l(1:10)=-10;
    u(1:10)=10; 
    
    %% 23. Zakharov's problem
    case 23
    l(1:10)=-5;
    u(1:10)=10;
    
    %% 24. EX3 problem
    case 24
        
        
        %% 25. Deb 1 problem
    case 25
    l(1:10)=-1;
    u(1:10)=1;
    
    %% 26. Deb 2 problem
    case 26
    l(1:10)=0;
    u(1:10)=1; 
    
    %% 27. Egg-holder problem
    case 27
    l(1:2)=-512;
    u(1:2)=512;    
      
end

