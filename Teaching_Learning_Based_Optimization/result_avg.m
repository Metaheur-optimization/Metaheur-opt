%% Prepared by Dr. R. VENKATA RAO and Dr. VIVEK PATEL  %% 
function [result_av, within_bound] = result_avg(Students)


format short; 
Result = []; 
within_bound = 0; 
for i = 1 : length(Students) 
    if Students(i).result < inf 
        Result = [Result Students(i).result]; 
        within_bound = within_bound + 1; 
    end 
end 
result_av = mean(Result); 
return; 
        %% Prepared by Dr. R. VENKATA RAO and Dr. VIVEK PATEL  %% 