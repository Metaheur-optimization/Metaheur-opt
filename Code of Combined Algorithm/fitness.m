

function ft=fitness(xn,N,pd) % Function for fitness evaluation

npop=N;nvar=pd;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for i=1:npop 

  ft(i)= (1 + (xn(i,1) + xn(i,2) + 1)^2 * (19- 14*xn(i,1) + 3*xn(i,1)^2- 14*xn(i,2) + 6*xn(i,1)*xn(i,2) + 3*xn(i,2)^2)) * (30 + (2*xn(i,1)- 3*xn(i,2))^2 * (18- 32*xn(i,1) + 12*xn(i,1)^2 + 48*xn(i,2) -36*xn(i,1)*xn(i,2) + 27*xn(i,2)^2)); %  function
end 

