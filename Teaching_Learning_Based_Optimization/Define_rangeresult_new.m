
function [Studentss] = Define_rangeresult_new(select, Students) 

global CostFunction
classsize = select.classsize; 
   
for popindex = 1 : size(Students,1) 
    for k = 1 : select.var_num 
        x(k) = Students(popindex,k); 
    end 
    Studentss(popindex) = CostFunction(x); 
end 
return 