%% PSO first modified by KB 26 Dec 2020
function [AllBestFitnesses,AllBestSolution]=PSO(Out)
%% Setting and definition of variables
rng('default')
% rng(2)

AllBestFitnesses=zeros(Out.NRun,Out.MaxIter);
AllBestSolution=zeros(Out.NRun,Out.NDecisionVariable);
Npopulation=Out.Npopulation; % Flock (population) size
NDecisionVariable=Out.NDecisionVariable; % Problem dimension (number of decision variables)
% LowerBound=Out.LowerBound;
% UpperBound=Out.UpperBound;
[LowerBound, UpperBound]=EngineeringBounds(Out.EngFunction);
InterWeight=Out.InterWeight;% Inertia Weight
DampRatio=Out.DampRatio;% Inertia Weight Damping Ratio
c1=Out.c1; % Personahl Learning Coefficient
c2=Out.c2;% Global Learning Coefficient

Velocity=zeros(Npopulation,NDecisionVariable);
Best.Position=zeros(Npopulation,NDecisionVariable);
Best.Fitness=zeros(Npopulation,1);
GlobalBest.Position=zeros(1,NDecisionVariable);
GlobalBest.Fitness=zeros(1);

% Velocity Limits
LowerBound=LowerBound.';
UpperBound=UpperBound.';
VelMax=0.1*(UpperBound-LowerBound);
VelMin=-VelMax;

%% Main loop of indepdendent runs
for iRun=1:Out.NRun
    %% Initialisation
    Position=init(Out); % Initialization of solutions
    %     Fitness =fitness(Position,Out); % Fitness evaluation
    for i=1:Npopulation
        Best.Fitness(i)=EngineeringFitness(Position,i,Out.EngFunction); % Fitness evaluation
    end
    Best.Position=Position;
    [GlobalBest.Fitness, LocationMin]=min(Best.Fitness);
    GlobalBest.Position(:)=Best.Position(LocationMin(1),:);
    
    %% PSO Main Loop
    Bestfit=zeros(Out.MaxIter,1);
    for it=1:Out.MaxIter
        
        for i=1:Npopulation
            
            % Update Velocity
            Velocity(i,:)= InterWeight*Velocity(i,:)+...
                c1*rand*(Best.Position(i,:)-Position(i,:))+...
                c2*rand*(GlobalBest.Position(1,:)-Position(i,:));
            
            % Apply Velocity Limits
            Velocity(i,:) = max(Velocity(i,:),VelMin(1,:));
            Velocity(i,:) = min(Velocity(i,:),VelMax(1,:));
            
            % Update Position
            Position(i,:) = Position(i,:)+ Velocity(i,:);
            
            % Velocity Mirror Effect
            IsOutside=(Position(i,:)<LowerBound(1,:) | Position(i,:)>UpperBound(1,:));
            Velocity(i,IsOutside)=-Velocity(i,IsOutside);
            
            %             % Apply Position Limits
            %             Position(i,:) = max(Position(i,:),LowerBound(1,:));
            %             Position(i,:) = min(Position(i,:),UpperBound(1,:));
            Bool=1;
            for j=1:NDecisionVariable % Update position and memory
                if Position(i,j)<=LowerBound(j) || Position(i,j)>=UpperBound(j)
                    Bool=0;
                    break
                end
            end
            if(Bool==1)
                %     Fitness =fitness(Position,Out); % Fitness evaluation
                Fitn=EngineeringFitness(Position,i,Out.EngFunction); % Fitness evaluation
                % Update Personal Best
                if Fitn<Best.Fitness(i)
                    Best.Position(i,:)=Position(i,:);
                    Best.Fitness(i)=Fitn;
                    
                    % Update Global Best
                    if Best.Fitness(i)<GlobalBest.Fitness
                        GlobalBest.Position(:)=Best.Position(i,:);
                        GlobalBest.Fitness=Best.Fitness(i);
                    end
                end
            end
        end
        
        Bestfit(it)=GlobalBest.Fitness;
        InterWeight=InterWeight*DampRatio;
        %         disp(['Iteration ' num2str(it) ' Best Fitness = ' num2str(Bestfit(it))]);
        
    end
    
    %% Saving results of the solution
    AllBestSolution(iRun,:)=GlobalBest.Position;
    AllBestFitnesses(iRun,:)=Bestfit;
end