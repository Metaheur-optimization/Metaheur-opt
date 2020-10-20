

function [x l u]=init(N,pd,LB,UB) % Function for initialization

l=LB; u=UB; % Lower and upper bounds

for i=1:N % Generation of initial solutions (position of crows)
    for j=1:pd
        x(i,j)=l-(l-u)*rand; % Position of the crows in the space
    end
end
