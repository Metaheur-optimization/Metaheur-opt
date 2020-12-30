function [LowerBound, UpperBound]=EngineeringBounds(EngFunction)

switch EngFunction
    %% 1. Three bar truss problem
    case 1
        LowerBound=[0 0]; UpperBound=[1 1];% Lower and upper bounds
        %% 2. Tension problem
    case 2
        LowerBound=[0.05 0.25 2]; UpperBound=[2 1.3 15];% Lower and upper bounds
        
        %% 3. Welded beam problem
    case 3
        LowerBound=[0.1 0.1 0.1 0.1]; UpperBound=[2 10 10 2]; % Lower and upper bounds
        
        %% 4. Reducing
    case 4
        LowerBound=[2.6 0.7 17 7.3 7.3 2.9 5]; UpperBound=[3.6 0.8 28 8.3 8.3 3.9 5.5]; % Lower and upper bounds
        %% 5. Pressure vessel problem
    case 5
        LowerBound=[0.0625 0.0625 10 10]; UpperBound=[0.0625*99 0.0625*99 200 200];% Lower and upper bounds
end



