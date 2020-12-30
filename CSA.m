%% CSA first modified by KB 25 Dec 2020
function [AllBestFitnesses,AllBestSolution]=CSA(Out)
%% Setting and definition of variables
rng('default')
% rng(2)
AllBestFitnesses=zeros(Out.NRun,Out.MaxIter);
AllBestSolution=zeros(Out.NRun,Out.NDecisionVariable);

Npopulation=Out.Npopulation; % Flock (population) size
NDecisionVariable=Out.NDecisionVariable; % Problem dimension (number of decision variables)
fitnessMemory=zeros(1,Npopulation);
% LowerBound=Out.LowerBound;
% UpperBound=Out.UpperBound;
[LowerBound, UpperBound]=EngineeringBounds(Out.EngFunction);
AP=Out.AP;
fl=Out.fl;

%% Main loop of indepdendent runs
for iRun=1:Out.NRun
    %% initialization
    Position=init(Out); % Initialization of solutions
%     Position(1,:)=[0.0516890284000, 0.3567169544000, 11.2890117993000];
    for i=1:Npopulation
        %     fitnessMemory=fitness(Position,i,Out); % Fitness evaluation
        fitnessMemory(i)=EngineeringFitness(Position,i,Out); % Fitness evaluation
    end
    PositionMemory=Position; % Memorise Position of solutions
    
    %% CSA Main Loop
    Bestfit=zeros(1,Out.MaxIter);
    Xnew=zeros(Npopulation,NDecisionVariable);
    for iIter=1:Out.MaxIter % Maximum number of iterations (itermax)
        num=ceil(Npopulation*rand(1,Npopulation)); % Generation of random candidate crows for following (chasing)
        for i=1:Npopulation
            if rand>AP
                for j=1:NDecisionVariable
                    Xnew(i,j)= Position(i,j)+fl*rand*(PositionMemory(num(i),j)-Position(i,j)); % Generation of a new position for crow i (state 1)
                end
            else
                Xnew(i,:)=LowerBound(:,1)+(UpperBound(:,1)-LowerBound(:,1))*rand; % Generation of a new position for crow i (state 2)
            end
            
            Bool=1;
            for j=1:NDecisionVariable % Update position and memory
                if Xnew(i,j)<=LowerBound(j) || Xnew(i,j)>=UpperBound(j)
                    Bool=0;
                    break
                end
            end
            if(Bool==1)
                Position(i,:)=Xnew(i,:); % Update position
                %     fitne=fitness(Position,Out); % Fitness evaluation
                fitne=EngineeringFitness(Position,i,Out); % Fitness evaluation
                if fitne<fitnessMemory(i)% Update memory only if fitness is better
                    PositionMemory(i,:)=Xnew(i,:);
                    fitnessMemory(i)=fitne;
                end
            end
        end
        Bestfit(iIter)=min(fitnessMemory); % Best fitness found at iteration t
        %         disp(['run =   ',num2str(iRun),'  iter =   ',num2str(iIter),' BEST Fitness= ',num2str(Bestfitness(iIter))])
    end
    
    %% Saving results of the solution
    [~,ngbest]=min(fitnessMemory);
    AllBestSolution(iRun,:)=PositionMemory(ngbest(1),:); % Solutin of the problem
    AllBestFitnesses(iRun,:)=Bestfit;
end
