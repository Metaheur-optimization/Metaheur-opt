
function [Students] = Define_rangeresult(select, Students) 

global CostFunction
classsize = select.classsize; 
for popindex = 1 : classsize 
    for k = 1 : select.var_num 
        x(k) = Students(popindex).mark(k); 
    end 
    Students(popindex).result = CostFunction(x); 
end 
return 