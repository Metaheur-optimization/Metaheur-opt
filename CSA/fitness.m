

function ft=fitness(xn,N,pd) % Function for fitness evaluation
s=zeros(1,pd-1);
for i=1:N
    for j=1:pd-1
      s(j)=(xn(i,j)^2)^(xn(i,j+1)+1) +(xn(i,j+1)^2)^(xn(i,j)+1);
    end
 
  ft(i) = sum(s);% Sphere function
end




