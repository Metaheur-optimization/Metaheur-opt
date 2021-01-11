function  [upper_limit,  lower_limit,  Students,  select]  = Define_rangeDefine_variables(select) 
global  VarSize VarMin VarMax lower_limit upper_limit ll ul 
% global 
Granularity = 1; 
% lower_limit = ll; 
% upper_limit = ul; 
 
% ll=[-10 -10 -10 -10 -10 -10 -10 -10 -10 -10 -10 -10 -10 -10 -10 -10 -10 -10 -10 -10 -10 -10 -10 -10 -10 -10 -10 -10 -10 -10];% -10 -10 -10 -10 -10 -10 -10 -10 -10 -10 -10 -10 -10 -10 -10 -10 -10 -10 -10 -10]; 
% ul=[10 10 10 10 10 10 10 10 10 10 10 10 10 10 10 10 10 10 10 10 10 10 10 10 10 10 10 10 10 10];% 10 10 10 10 10 10 10 10 10 10 10 10 10 10 10 10 10 10 10 10]; 
 
ll=repmat(VarMin,VarSize);
ul=repmat(VarMax,VarSize);

lower_limit = ll; 
upper_limit = ul; 
for popindex = 1 : select.classsize 
    for k = 1 : select.var_num 
        mark(k) =(ll(k))+ ((ul(k) - ll(k)) * rand);   
    end 
        Students(popindex).mark = mark; 
end 
select.OrderDependent = true; 
return; 