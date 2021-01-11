
function [Students] = Define_rangeopti(select, Students) 


global  upper_limit ll  
for i = 1 : select.classsize 
    for k = 1 : select.var_num 
        Students(i).mark(k) = max(Students(i).mark(k), ll(k)); 
        Students(i).mark(k) = min(Students(i).mark(k), upper_limit(k)); 
    end 
end 
return;