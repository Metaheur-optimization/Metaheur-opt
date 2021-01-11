 %% Prepared by Dr. R. VENKATA RAO and Dr. VIVEK PATEL  %% 
function ETLBO(obj_fun, note1, ~) 
global  NFE AlgorithmTermination

format short; 
global ll 
if ~exist('note1', 'var') 
    note1 = true; 
end 
if ~exist('note2', 'var') 
    note2 = true; 
end 
[Students,  select,  upper_limit,  lower_limit,  ini_fun,  min_result,  avg_result, result_fun,  opti_fun,  result_fun_new,  opti_fun_new]  =  Define_variables(note1, obj_fun); 
ul=upper_limit; 
ll=lower_limit; 
elite=4; 
for COMP = 1 : select.itration 
    for i = 1 : elite 
        markelite(i,:) = Students(i).mark; 
        resultelite(i) = Students(i).result; 
    end 
    for i=1:length(Students) 
    cs(i,:)=Students(i).mark; 
    cs_result(i)=Students(i).result; 
   
    end 
    cs_new=cs; 
    cs; 
    cs_result; 
    Stdev_cs=std(cs); 
    Mean_cs=mean(cs); 
    
     for i = 1 : length(Students)    
    mean_result=mean(cs); 
    Stdev_cs=std(cs); 
    TF=round(1+rand*(1)); 
    [r1, r2]=sort(cs_result); 
    best=cs(r2(1),:); 
        for k = 1 : select.var_num 
        Stdev_cs(i,k)=std(cs(i,k)); 
        cs_new(i,k)=cs(i,k)+((best(1,k)-TF*mean_result(k))*rand)-(Stdev_cs(1,k)- Stdev_cs(i,k))*rand;%((1)*((cs(hh,k)-(LF)*cs(i,k)))*(rand)); 
        end 
        cs_new(i,:) = opti_fun_new(select, cs_new(i,:)); 
        cs_new_result(i) = result_fun_new(select, cs_new(i,:)); 
        if cs_new_result(i)<Students(i).result 
             Students(i).mark =cs_new(i,:); 
             cs(i,:)=cs_new(i,:); 
             Students(i).result=cs_new_result(i);    
        end   
        hh=ceil(length(Students)*rand); 
        while hh==i 
                hh=ceil(length(Students)*rand); 
        end 
       if Students(i).result<Students(hh).result 
          for k = 1 : select.var_num 
           cs_new(i,k)=  Students(i).mark(k)  +  (((Students(i).mark(k)  - Students(hh).mark(k))*(rand)*(1))); 
          end 
       else 
          for k = 1 : select.var_num 
           cs_new(i,k)=  Students(i).mark(k)  +  ((Students(hh).mark(k)  - Students(i).mark(k))*(rand)*(1)); 
   
           end 
       end 
          cs_new(i,:) = opti_fun_new(select, cs_new(i,:)); 
          cs_new_result(i) = result_fun_new(select, cs_new(i,:)); 
       if cs_new_result(i)<Students(i).result 
             Students(i).mark =cs_new(i,:); 
             cs(i,:)=cs_new(i,:); 
             Students(i).result=cs_new_result(i); 
       end 
     end 
  
    n = length(Students); 
    Students = opti_fun(select, Students); 
    Students = result_fun(select, Students); 
    Students = sortstudents(Students); 
    for i = 1 : elite 
        Students(n-(i-1)).mark = markelite(i,:); 
        Students(n-(i-1)).result = resultelite(i);                
    end 
    if rand<1 
    Students = remove_duplicate(Students, upper_limit, lower_limit); 
    end 
    Students = sortstudents(Students); 
    [average_result, within_bound] = result_avg(Students); 
    min_result = [min_result Students(1).result]; 
    avg_result = [avg_result average_result]; 
    Mark = (Students(1).mark);  
    if note1 
%                   disp([num2str(min_result(end))]); 
%                   disp([num2str(Mark)]);  
    end 
    disp(['Iteration ' num2str(COMP) ' , Best Cost = ' num2str(min_result(end)) ' , NFE=' num2str(NFE)]);
    if AlgorithmTermination.Order==1&&NFE>AlgorithmTermination.MaxNFE
         break
    end
end 

BestSolution= Mark

disp('Teaching Learning Based Optimization (TLBO)')
disp(' ')

% fprintf('\n %e',min_result(end)); 
% fprintf('\n %e',Mark); 
        %% Prepared by Dr. R. VENKATA RAO and Dr. VIVEK PATEL  %%