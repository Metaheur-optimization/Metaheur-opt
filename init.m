function InitArray=init(Out) % Function for initialization

LB=Out.LowerBound; UB=Out.UpperBound; % Lower and upper bounds

InitArray=zeros(Out.Npopulation,Out.NDecisionVariable);

for i=1:Out.Npopulation % Generation of initial solutions (position of crows)
    for j=1:Out.NDecisionVariable
        InitArray(i,j)=LB(j)+(UB(j)-LB(j))*rand; % Position of the crows in the space
        if (Out.Function == 39) && (j == 2)
            if InitArray(i,2) >= InitArray(i,1)
                InitArray(i,2) = rand * (InitArray(i,1));
            end
        end
    end 
end
