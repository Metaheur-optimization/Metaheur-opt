%% New Algorithm Development
function [Results]=LAL(Out)

rng('default');
rng(20);
Npopulation=Out.Npopulation; % Flock (population) size
NDecisionVariable=Out.NDecisionVariable; % Problem dimension (number of decision variables)
fitnessMemory=zeros(1,Npopulation);
ObjectiveType=Out.ObjectiveType;
NoofBossLions=ceil(0.2*Npopulation);
NoofSupportLion=(Npopulation-NoofBossLions);

Hunt_Boss=Out.Hunt_Boss;
hunt_support=Out.hunt_support;

NoFuncEval=0; % Number of function Evalutions

LB=Out.LowerBound(1);
UB=Out.UpperBound(1);





for iRun=1:Out.NRun
    %rng(iRun);
    
    %% initialization
    Position=init(Out); % Initialization of solutions
    AllPositionMemory=Position; % Memorise Position of solutions
    
    for i=1:Npopulation
    fitnessMemory=fitness(Position,i,Out); % Fitness evaluation 
    AllPositionMemory(i,Out.NDecisionVariable+1)=fitnessMemory;
    end
    
    % Assess Fittness Values
    [AllNewPositionMemory,BossLionPositionMemory,SupportLionPositionMemory]=ObjFucEval(AllPositionMemory,ObjectiveType,NoofBossLions);  %(ObjectiveType: 0 Minimization, 1 Maximization) 
    
    % Plotting Positions
    BossLionPosition=BossLionPositionMemory;
    SupportLionPosition=SupportLionPositionMemory;
   % P=PlotPositions(BossLionPosition,SupportLionPosition,NDecisionVariable,NoFuncEval);
   
    %% NAL Main Loop
    for iIter=1:Out.MaxIter % Maximum number of iterations (itermax)
        
        
        % 1. Generate New Boss_Lions 
        RandomBossLionIndex=reshape(randperm(NoofBossLions),[],1);
%         RandomLionHunt=randi([1 3],1,NoofBossLions);
        for i=1:NoofBossLions
            for j=1:NDecisionVariable
                NewBossLionPositionMemory(i,j)=BossLionPositionMemory(i,j)+rand*Hunt_Boss*(BossLionPositionMemory(RandomBossLionIndex(i),j)-BossLionPositionMemory(i,j));

              % NewBossLionPositionMemory(i,j)=BossLionPositionMemory(i,j)+rand*Hunt_Boss*((BossLionPositionMemory(RandomBossLionIndex(i),j)-BossLionPositionMemory(i,j))/2);    

            end
        end
        %%% memory for Lions %%%%%%
        %%% fitness for newBossLionPositionMemory
        [row, ~] = size(NewBossLionPositionMemory);
        for ii=1:row
            fitnessMemory=fitness(NewBossLionPositionMemory,ii,Out); % Fitness evaluation
            NewBossLionPositionMemory(ii,Out.NDecisionVariable+1)=fitnessMemory;
        end
        combineBossLions = [NewBossLionPositionMemory; BossLionPositionMemory];
        [~ , NewBossLionPositionMemory, ~] = ObjFucEval(combineBossLions, ObjectiveType, NoofBossLions);
        
        
        
            
        % 2. Generate New Support_Lions     
        for s=1:NoofSupportLion
            for k=1:NDecisionVariable
               NewSupportLionPositionMemory(s,k)=NewBossLionPositionMemory(randperm(NoofBossLions,1),k)+rand*hunt_support*(NewBossLionPositionMemory(randperm(NoofBossLions,1),k));
               % NewSupportLionPositionMemory(s,k)=NewBossLionPositionMemory(randperm(NoofBossLions,1),k)+rand*(NewBossLionPositionMemory(randperm(NoofBossLions,1),k));          
            end
        end
        
        % evalute objective function
        AllPositionMemory=[NewBossLionPositionMemory(:,1:(end-1));NewSupportLionPositionMemory];
        [row, ~] = size(AllPositionMemory);
        for ii=1:row
            fitnessMemory=fitness(AllPositionMemory,ii,Out); % Fitness evaluation
            AllPositionMemory(ii,Out.NDecisionVariable+1)=fitnessMemory;
        end
        
         % Assess Fittness Values
        [AllNewPositionMemory,BossLionPositionMemory,SupportLionPositionMemory]=ObjFucEval(AllPositionMemory,ObjectiveType,NoofBossLions);  %(ObjectiveType: 0 Minimization, 1 Maximization) 
        NoFuncEval=NoFuncEval+1
            
    BossLionPosition=BossLionPositionMemory;
    SupportLionPosition=SupportLionPositionMemory;
   % P=PlotPositions(BossLionPosition,SupportLionPosition,NDecisionVariable,NoFuncEval);
  % pause()
           
    end
    
    %% Saving results of the solution
    
  BestSolution(iRun,1)=AllNewPositionMemory(1,end);
     
    
end
Mea=mean(BestSolution(:,1));
St=std(BestSolution(:,1));
besteverSolution=min(BestSolution(:,1));

 Results.NoFuncEval=NoFuncEval;
 Results.BossLionPosition=BossLionPosition;
 Results.SupportLionPosition=SupportLionPosition;
 Results.AllNewPositionMemory=AllNewPositionMemory;
 Results.Mea=Mea
 Results.St=St
 Results.besteverSolution=besteverSolution
 Results.BestSolution=BestSolution;
 
 
 
 
 

