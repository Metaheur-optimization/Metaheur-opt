function i=TournamentSelection(pop,m)

nPop=numel(pop);

% S=randsample(nPop,m);
% S=zeros(1,m);
% for i=1:m
%     S(i)=randi([1 nPop]);
% end
S=ceil(rand(1,m,'single')*nPop);

% scosts=[pop(S).Cost];
scosts=(pop(S).Cost);

[~, j]=min(scosts);

i=S(j);

end