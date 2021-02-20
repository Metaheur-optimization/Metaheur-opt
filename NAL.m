%% New Algorithm Development
function [Results]=LAL(Out)

rng('default');

Npopulation=Out.Npopulation; % Flock (population) size
NDecisionVariable=Out.NDecisionVariable; % Problem dimension (number of decision variables)
fitnessMemory=zeros(1,Npopulation);
ObjectiveType=Out.ObjectiveType;
NoofBossLions=ceil(0.2*Npopulation)


for iRun=1:Out.NRun
    %% initialization
    Position=init(Out); % Initialization of solutions
    PositionMemory=Position; % Memorise Position of solutions
    
    for i=1:Npopulation
    fitnessMemory=fitness(Position,i,Out); % Fitness evaluation 
    PositionMemory(i,Out.NDecisionVariable+1)=fitnessMemory;
    end
    
    
    
    [NewPositionMemory]=ObjFucEval(PositionMemory,ObjectiveType)  %(ObjectiveType: 0 Minimization, 1 Maximization) 
    
    %% NAL Main Loop
    
    Xnew=zeros(Npopulation,NDecisionVariable);
    for iIter=1:Out.MaxIter % Maximum number of iterations (itermax)
        
        
        % Generate New Lions Boss
            for i=1:Npopulation
                % New Position Generation
                    for j=1:NDecisionVariable
                        Xnew(i,j)= Position(i,j)+fl*(PositionMemory(num(i),j)-Position(i,j)); % Generation of a new position for crow i (state 1)

                    end
            end
            
            
            
            
            
       
    end
    
    %% Saving results of the solution
    
end
Results.NFEAll=NFEAll;
Results.PenaltyCount=PenaltyCountAll;


