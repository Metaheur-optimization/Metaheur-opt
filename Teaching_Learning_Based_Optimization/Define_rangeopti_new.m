
function [Students] = Define_rangeopti_new(select, Students) 

global  upper_limit ll  
for i = 1 : size(Students,1) 
    for k = 1 : select.var_num 
        Students(i,k)= max(Students(i,k), ll(k)); 
        Students(i,k) = min(Students(i,k), upper_limit(k)); 
    end 
end 
return; 