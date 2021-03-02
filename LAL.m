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

LowerBound=Out.LowerBound;
UpperBound=Out.UpperBound;

%%% indicators definintion %%%%%%
Results.AllBestFitnesses=zeros(Out.NRun,Out.MaxIter);
Results.AllBestSolution=zeros(Out.NRun,Out.NDecisionVariable);
Results.Feasible=zeros(Out.NRun,Out.MaxIter);
Results.NFE=zeros(Out.NRun,Out.MaxIter);
Results.NFEAll=0;
NFEAll=0;
Results.PenaltyCount=0;
PenaltyCountAll=0;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


for iRun=1:Out.NRun
    %rng(iRun);
    
    %% initialization
    Position=init(Out); % Initialization of solutions
    PositionMemory=Position; % Memorise Position of solutions
    [fitnessMemory(1:Npopulation), BoolPenalty(1:Npopulation)] = fitness(Position, 1:Npopulation, Out); % Fitness evaluation 
    PositionMemory((1:Npopulation),Out.NDecisionVariable+1)= fitnessMemory(1:Npopulation);
    PenaltyCountAll = sum(BoolPenalty);
    NFEAll = NFEAll + Npopulation;
    Results.NFE(iRun,1)=NFEAll;
    Results.Feasible(iRun,1)=Npopulation-PenaltyCountAll;
%     for i=1:Npopulation
%         [fitnessMemory, ~] = fitness(Position,i,Out); % Fitness evaluation 
%         AllPositionMemory(i,Out.NDecisionVariable+1)=fitnessMemory;
%     end
    
    % Assess Fittness Values
    [AllNewPositionMemory,BossLionPositionMemory,SupportLionPositionMemory]=ObjFucEval(PositionMemory,ObjectiveType,NoofBossLions);  %(ObjectiveType: 0 Minimization, 1 Maximization) 
    
    % Plotting Positions
    BossLionPosition=BossLionPositionMemory;
    SupportLionPosition=SupportLionPositionMemory;
   % P=PlotPositions(BossLionPosition,SupportLionPosition,NDecisionVariable,NoFuncEval);
   
    %% NAL Main Loop
    Bestfit = zeros(1,Out.MaxIter);
    
    for iIter=1:Out.MaxIter % Maximum number of iterations (itermax)
        NFE=0;
        PenaltyCount=0;
        % 1. Generate New Boss_Lions 
        RandomBossLionIndex=reshape(randperm(NoofBossLions),[],1);
%         RandomLionHunt=randi([1 3],1,NoofBossLions);
        for i=1:NoofBossLions
            for j=1:NDecisionVariable
                NewBossLionPositionMemory(i,j)=BossLionPositionMemory(i,j)+rand*Hunt_Boss*(BossLionPositionMemory(RandomBossLionIndex(i),j)-BossLionPositionMemory(i,j));

              % NewBossLionPositionMemory(i,j)=BossLionPositionMemory(i,j)+rand*Hunt_Boss*((BossLionPositionMemory(RandomBossLionIndex(i),j)-BossLionPositionMemory(i,j))/2);    

            end
            Bool=1;
            for j=1:NDecisionVariable % Update position and memory
                if NewBossLionPositionMemory(i,j)<LowerBound(j) || NewBossLionPositionMemory(i,j)>UpperBound(j)
                    Bool=0;
                    NewBossLionPositionMemory(i, NDecisionVariable+1) = 10^18;
                    break
                end
            end
            if(Bool==1)
                Position(i,:) = NewBossLionPositionMemory(i, 1:NDecisionVariable);
                [fitne, BoolPenalty] = fitness(Position,i,Out); % Fitness evaluation
                if BoolPenalty==1
                    PenaltyCountAll=PenaltyCountAll+1;
                    PenaltyCount=PenaltyCount+1;
                end
                NFEAll=NFEAll+1;
                NFE=NFE+1;
                fitnessMemory(i)=fitne;
                NewBossLionPositionMemory(i, NDecisionVariable+1) = fitne;
            end
        end
        
        
        combineBossLions = [NewBossLionPositionMemory; BossLionPositionMemory];
        [~ , NewBossLionPositionMemory, ~] = ObjFucEval(combineBossLions, ObjectiveType, NoofBossLions);
        
        
        
            
        % 2. Generate New Support_Lions     
        for s=1:NoofSupportLion
            random_array = rand(1, NDecisionVariable);
            NewSupportLionPositionMemory(s,(1:NDecisionVariable)) = NewBossLionPositionMemory(randperm(NoofBossLions,1),(1:NDecisionVariable))+ ...
                   random_array * hunt_support .* (NewBossLionPositionMemory(randperm(NoofBossLions,1),(1:NDecisionVariable)));
%             for k=1:NDecisionVariable
%                NewSupportLionPositionMemory(s,k)=NewBossLionPositionMemory(randperm(NoofBossLions,1),k)+ ...
%                    rand*hunt_support*(NewBossLionPositionMemory(randperm(NoofBossLions,1),k));
%                NewSupportLionPositionMemory(s,k)=NewBossLionPositionMemory(randperm(NoofBossLions,1),k)+rand*(NewBossLionPositionMemory(randperm(NoofBossLions,1),k));          
%             end
            Bool=1;
            for j=1:NDecisionVariable % Update position and memory
                if NewSupportLionPositionMemory(s,j)<LowerBound(j) || NewSupportLionPositionMemory(s,j)>UpperBound(j)
                    Bool=0;
                    NewSupportLionPositionMemory(s, NDecisionVariable+1) = 10^18;
                    break
                end
            end
            if(Bool==1)
                Position(s,:) = NewSupportLionPositionMemory(s, 1:NDecisionVariable);
                [fitne, BoolPenalty] = fitness(Position,s,Out); % Fitness evaluation
                if BoolPenalty==1
                    PenaltyCountAll=PenaltyCountAll+1;
                    PenaltyCount=PenaltyCount+1;
                end
                NFEAll=NFEAll+1;
                NFE=NFE+1;
                fitnessMemory(NoofBossLions + s)=fitne;
                NewSupportLionPositionMemory(s, NDecisionVariable+1) = fitne;
            end
        end
        
        
        % Assess Fittness Values
        combineBossLions = [NewBossLionPositionMemory; NewSupportLionPositionMemory];
        [~ , NewBossLionPositionMemory, ~] = ObjFucEval(combineBossLions, ObjectiveType, NoofBossLions);
%     end
        
       
         
        %[AllNewPositionMemory,BossLionPositionMemory,SupportLionPositionMemory]=ObjFucEval(PositionMemory,ObjectiveType,NoofBossLions);  %(ObjectiveType: 0 Minimization, 1 Maximization) 
        NoFuncEval=NoFuncEval+1;
            
        BossLionPosition=BossLionPositionMemory;
        SupportLionPosition=SupportLionPositionMemory;
   % P=PlotPositions(BossLionPosition,SupportLionPosition,NDecisionVariable,NoFuncEval);
  % pause()
        Bestfit(iIter)=min(fitnessMemory); % Best fitness found at iteration t
        Results.NFE(iRun,iIter)=NFE;
        Results.Feasible(iRun,iIter)=NFE-PenaltyCount;
    end
    
    %% Saving results of the solution
    
    BestSolution(iRun,1)=AllNewPositionMemory(1,end);
     
    %% Saving results of the solution
    [~,ngbest]=min(fitnessMemory);
    Results.AllBestSolution(iRun,:)=PositionMemory(ngbest(1),1:(end-1)); % Solutin of the problem
    Results.AllBestFitnesses(iRun,:)=Bestfit;
end
Results.NFEAll=NFEAll;
Results.PenaltyCount=PenaltyCountAll;



% Mea=mean(BestSolution(:,1));
% St=std(BestSolution(:,1));
% besteverSolution=min(BestSolution(:,1));
% 
%  Results.NoFuncEval=NoFuncEval;
%  Results.BossLionPosition=BossLionPosition;
%  Results.SupportLionPosition=SupportLionPosition;
%  Results.AllNewPositionMemory=AllNewPositionMemory;
%  Results.Mea=Mea
%  Results.St=St
%  Results.besteverSolution=besteverSolution
%  Results.BestSolution=BestSolution;
 
 
 
 
 

