

function [x l u]=init(N,pd) % Function for initialization

l=[0.05 0.25 2]; u=[2 1.3 15]; % Lower and upper bounds

for i=1:N % Generation of initial solutions (position of crows)
    for j=1:pd
        x(i,j)=l(j)-(l(j)-u(j))*rand; % Position of the crows in the space
    end
end
