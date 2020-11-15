%The main file to set the algorithms and run for CSA, PSO, and GA
format long; close all; clear all; clc
%%Common parameters setting
Npop=20;  %Population size
Nvar=2;  %Number of decision variables
Func=13;  %Number of fitness function according to fitness file
Nrun=1; %Number of runs
itermax=100;  %Maximum number of iterations
LB=-10; %Lower bound of variables
UB=10;  %Upper bound of variables
Algorithm='PSO'; % 'CSA' 'PSO' 
% This is new test

%%Parameters setting for the CSA
AP=0.1; % Awareness probability
fl=2; % Flight length (fl)

%%Parameters setting for the PSO
 w=1;            % Inertia Weight
 wdamp=0.99;     % Inertia Weight Damping Ratio
 c1=2;           % Personahl Learning Coefficient
 c2=2;           % Global Learning Coefficient
 
 
 Legend2=cell(1,2);
 
% [Global fit_mem g_best]=CSA(Npop,Nvar,Func,Nrun,itermax,LB,UB,AP,fl);
for Func=5:13

%% ************** New Algorithm ****************** 
 [BestDVs BestFittVal OptiVals BestSol BestDV Pareto]=NAI(Npop,Nvar,Func,Nrun,itermax);
 
 % compare with other (e.g. CSA)
 [Global fit_mem g_best]=CSA(Npop,Nvar,Func,Nrun,itermax,LB,UB,AP,fl);

 BestSolutionFound=min(Global)
 
 figure(Func)
 plot(BestFittVal,'g*','MarkerSize',5)
 
 %hold on
 %plot(BestSol,'ro','MarkerSize',10)
 hold on
 plot(Global,'b.','MarkerSize',15)
 
 
 legend ('New Algorithm','CSA')
 %plot(BestSolutionFound,'yo','MarkerSize',10)
 
end
%% 
 
 for Func=1:13
     
%switch Algorithm
%%Crow Search Algorithm
    %case 'CSA'
    
    for Algorithm=1:2
    
        if Algorithm==1
            Algorithm='CSA'
        
[Global fit_mem g_best]=CSA(Npop,Nvar,Func,Nrun,itermax,LB,UB,AP,fl);

BestSolutions=Global;
P=plt(Nrun,Func,itermax,Algorithm,BestSolutions);


    Legend2{1}=(['Function No :',num2str(Func)]);
    Legend2{2}=(['Algorithm Type :',Algorithm]);
      
    legend(['Function No :',num2str(Func),' ; ','Algorithm Type :',Algorithm]);
    
     %legend(Legend2);


    %case 'PSO'
    
    elseif Algorithm==2;
         Algorithm='PSO';
         
        [BestCost BestSolution]=PSO(Npop,Nvar,Func,Nrun,itermax,LB,UB,w,wdamp,c1,c2);
      
        
        
           
     hold on   
BestSolutions=BestCost;
P=plt(Nrun,Func,itermax,Algorithm,BestSolutions);
        
  %legend(['Function No :',num2str(Func),' ; ','Algorithm Type :',Algorithm]);      
%end

        end
        
        
        
    end

  
 
    
    
 end
 
 
 
 
 
 
 
kads=1; 
 
