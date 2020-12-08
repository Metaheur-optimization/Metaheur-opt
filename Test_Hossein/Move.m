function xnew=Move(x,mem,fit_mem,N,pd,fl,AP,l,u,t,tmax)

nglobal=find(fit_mem== min(fit_mem));
[Ms ds]=sort(fit_mem,'descend');
final_per=2;
     kbest=final_per+(1-t/tmax)*(100-final_per); %kbest in eq. 21.
     kbest=round(N*kbest/100);
  
    for i=1:N
        %if rand>AP  
        dif=zeros(kbest,pd);
        for j=1:kbest
            k=ds(j);
        if i~=k
            dif(j,:)=fl*rand*(mem(k,:)-x(i,:));
        end
        end
        
        difference=sum(dif)/kbest;
            XXnew(i,:)= x(i,:)+difference; % Generation of a new position for crow i (state 1)
            xnew(i,:)=XXnew(i,:)+fl*rand*(mem(nglobal(1),:)-XXnew(i,:));
            
       % else
             for j=1:pd
                 if rand>AP || randi([1,pd])~=j
               % xnew(i,j)=l(j)-(l(j)-u(j))*rand; % Generation of a new position for crow i (state 2)
               xnew(i,j)=x(i,j);
            end

        end
end