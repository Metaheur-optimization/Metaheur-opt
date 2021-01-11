%% Prepared by Dr. R. VENKATA RAO and Dr. VIVEK PATEL  %% 
 
function  [ini_fun,  result_fun,  result_fun_new,  opti_fun,  opti_fun_new]  = Define_range 

format short; 
ini_fun = @Define_rangeDefine_variables ; 
result_fun = @Define_rangeresult; 
result_fun_new = @Define_rangeresult_new; 
opti_fun = @Define_rangeopti; 
opti_fun_new = @Define_rangeopti_new; 
return; 
   
 
       