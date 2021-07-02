%% CSA first modified by KB 25 Dec 2020
function [Results]=CSA(Out)
%% Setting and definition of variables
 
Results.AllBestFitnesses=zeros(Out.NRun,Out.MaxIter);
Results.AllBestSolution=zeros(Out.NRun,Out.NDecisionVariable);
Results.Feasible=zeros(Out.NRun,Out.MaxIter);
Results.NFE=zeros(Out.NRun,Out.MaxIter);
Results.NFEAll=0;
NFEAll=0;

Results.PenaltyCount=0;
PenaltyCountAll=0;
Npopulation=Out.Npopulation; % Flock (population) size
NDecisionVariable=Out.NDecisionVariable; % Problem dimension (number of decision variables)
fitnessMemory=zeros(1,Npopulation);
AP=Out.AP;
fl=Out.fl;
LowerBound = Out.LowerBound;
UpperBound = Out.UpperBound;

%% Main loop of indepdendent runs
for iRun=1:Out.NRun
    %% initialization
    Position=init(Out); % Initialization of solutions
%     Position(1,:)=[0.0516890284000, 0.3567169544000, 11.2890117993000];
    
%     [fitnessMemory(1:Npopulation), BoolPenalty(1:Npopulation)] = fitness(Position, 1:Npopulation, Out);   % Fitness evaluation
%     PenaltyCountAll = sum(BoolPenalty);
%     NFEAll=NFEAll+Npopulation;     %????
    
    
    for i=1:Npopulation
        [fitnessMemory(i), BoolPenalty] = fitness(Position, i, Out);   % Fitness evaluation
        NFEAll=NFEAll+1;
        if BoolPenalty==1
            PenaltyCountAll=PenaltyCountAll+1;
        end
    end
    
    PositionMemory=Position; % Memorise Position of solutions
    Results.NFE(iRun,1)=NFEAll;
    Results.Feasible(iRun,1)=Npopulation-PenaltyCountAll;
    %% CSA Main Loop
    Bestfit=zeros(1,Out.MaxIter);
    Xnew=zeros(Npopulation,NDecisionVariable);
    for iIter=1:Out.MaxIter % Maximum number of iterations (itermax)
        NFE=0;PenaltyCount=0;
        rr=rand(1,Npopulation);
        num=ceil(Npopulation*rr); % Generation of random candidate crows for following (chasing)
        Mea=mean(PositionMemory(:,:));
        for i=1:Npopulation
            r=rand;
            if r>AP
                Xnew(i,:)= Position(i,:)+fl*(PositionMemory(num(i),:)-Position(i,:)); % Generation of a new position for crow i (state 1)
            else
                random_array = rand(1, NDecisionVariable);
                Xnew(i,:)=LowerBound(1,:)+(UpperBound(1,:)-LowerBound(1,:)).*random_array(1,:); % Generation of a new position for crow i (state 2)
            end
            
            Bool=1;
            for j=1:NDecisionVariable % Update position and memory
                if Xnew(i,j)<LowerBound(j) || Xnew(i,j)>UpperBound(j)
                    Bool=0;
                    break
                end
            end
            if(Bool==1)
                Position(i,:)=Xnew(i,:); % Update position
                [fitne, BoolPenalty] =fitness(Position,i,Out); % Fitness evaluation
                if BoolPenalty==1
                    PenaltyCountAll=PenaltyCountAll+1;
                    PenaltyCount=PenaltyCount+1;
                end
                NFEAll=NFEAll+1;
                NFE=NFE+1;
                if fitne<fitnessMemory(i)% Update memory only if fitness is better
                    PositionMemory(i,:)=Xnew(i,:);
                    fitnessMemory(i)=fitne;
                end
            end
        end
        Bestfit(iIter)=min(fitnessMemory); % Best fitness found at iteration t
        Results.NFE(iRun,iIter)=NFE;
        Results.Feasible(iRun,iIter)=NFE-PenaltyCount;
    end
    
    %% Saving results of the solution
    [~,ngbest]=min(fitnessMemory);
    Results.AllBestSolution(iRun,:)=PositionMemory(ngbest(1),:); % Solutin of the problem
    Results.AllBestFitnesses(iRun,:)=Bestfit;
% Results.NFEAll=NFEAll;
% Results.PenaltyCount=PenaltyCountAll;
end
Results.NFEAll=NFEAll;
Results.PenaltyCount=PenaltyCountAll;