% %The main file to set the algorithms and run for CSA, PSO, and GA
format long; close all; clc

Algorithm='CSA'; 

Out = get_config(Algorithm);

switch Algorithm
    %%Crow Search Algorithm
    case 'CSA'
        [Global,fit_mem,g_best]=CSA(Out);
        
    case 'PSO'
        [BestCost,BestSolution]=PSO(Out);
        
end


