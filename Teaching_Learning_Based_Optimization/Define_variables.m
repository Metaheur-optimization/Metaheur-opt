%% Prepared by Dr. R. VENKATA RAO and Dr. VIVEK PATEL  %% 
function [Students, select, upper_limit, lower_limit, ini_fun, min_result, avg_result, result_fun,  opti_fun,  result_fun_new,  opti_fun_new]  =  Define_variables(note1, obj_fun, RandSeed) 
global  VarSize MaxIt nPop  

format short; 
select.classsize = nPop;  
select.var_num = VarSize(2);  
select.itration = MaxIt; 
if ~exist('RandSeed', 'var') 
    rand_gen = round(sum(100*clock)); 
end 
rand('state', rand_gen) 
[ini_fun, result_fun, result_fun_new, opti_fun, opti_fun_new,] = obj_fun(); 
[upper_limit, lower_limit, Students, select] = ini_fun(select); 
Students = remove_duplicate(Students, upper_limit, lower_limit); 
Students = result_fun(select, Students); 
Students = sortstudents(Students); 
average_result = result_avg(Students); 
min_result = [Students(1).result]; 
avg_result = [average_result]; 
return; 