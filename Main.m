% %The main file to set the algorithms and run for CSA, PSO, and GA
format long; close all; clear all; clc

AlgorithmType='MGA';

out = get_config(AlgorithmType);

switch AlgorithmType
    %%Crow Search Algorithm
    case 'CSA'
        [Global fit_mem g_best]=CSA(Npop,Nvar,Func,Nrun,itermax,LB,UB,AP,fl);
        
    case 'PSO'
        [BestCost BestSolution]=PSO(Npop,Nvar,Func,Nrun,itermax,LB,UB,w,wdamp,c1,c2);
       
       case 'MGA' 
       
       [BestCo,BestSolution]=MGA(out)
       
       
       
end


