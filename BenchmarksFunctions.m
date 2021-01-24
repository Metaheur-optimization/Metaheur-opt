function [fitness]=BenchmarksFunctions(x,i,Out.EngFunction)

StartLoop=Out.EngFunction;
switch Out.Function
    
    
%% 1. griewank Function   
case 1
    % Type: minimization
    % Range: x ?[?600,600]
    % Number of decision Variable =1
    LowerBound=-600;
    UpperBound=600;
  
    T1=((x(i,1))^2/4000);
    T2=cos(x(i,1)/(sqrt(i)));
    
    fitness=T1-T2+1;
  
 
 %% 2. himmelblau Function
 case 2
     % Type: minimization
    % Range: x ?[?6,6]
    % Number of decision Variable =2
    
    LowerBound=-6;
    UpperBound=6;  
     
    T1=((x(i,1))^2+x(i,2)-11)^2;
    T2=(x(i,1)+(x(i,2))^2-7)^2;
       fitness= T1+T2;
  %% 3. rastrigin Function
    case 3
     % Type: minimization
    % Range: x ?[?5.12,5.12]
    % Number of decision Variable =1
       
        LowerBound=-5.12;
        UpperBound=5.12; 
        T1=(x(i,1))^2;
        T2=10 *cos(2*pi*x(i,1));
        fitness=T1-T2;
       
  %% 4. schaffer Function
    case 4
    % Type: minimization
    % Range: x ?[?100,100]
    % Number of decision Variable =2
       LowerBound=-100;
       UpperBound=100;
       
        T1=(sin((x(i,1)^2)-(x(i,2)^2))^2)-0.5;
        T2=(1+0.001*((x(i,1)^2)+(x(i,2)^2)))^2;
        fitness=0.5 (T1/T2);
       
  %% 5. schwefel Function
    case 5
    % Type: minimization
    % Range: x ?[?500,500]
    % Number of decision Variable =1   
        
       LowerBound=-500;
       UpperBound=100;
       fitness=(x(i,1)*sin(sqrt(abs(x(i,1))));
       
end
















end 