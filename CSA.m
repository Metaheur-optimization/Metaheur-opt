%% CSA first modified by KB 25 Dec 2020
function [Results]=CSA(Out)
%% Setting and definition of variables
rng('default')
%rng(20)
Results.AllBestFitnesses=zeros(Out.NRun,Out.MaxIter);
Results.AllBestSolution=zeros(Out.NRun,Out.NDecisionVariable);
Results.Feasible=zeros(Out.NRun,Out.MaxIter);
Results.NFE=zeros(Out.NRun,Out.MaxIter);
Results.NFEAll=0;
NFEAll=0;
Hybrid=0;% 1=HCSA active and 0=HCSA inactive

Results.PenaltyCount=0;
PenaltyCountAll=0;
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
        [fitnessMemory(i), BoolPenalty]=EngineeringFitness(Position,i,Out.EngFunction); % Fitness evaluation
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
        %         Mea=mean(PositionMemory(:,:));

        if Hybrid==1
            BestGlobalMemory=find(fitnessMemory== min(fitnessMemory));  %HCSA   %The best Global memory during all iterations
            [~,ds]=sort(fitnessMemory,'descend');     %HCSA                    %Sorting Memories accordig to their fitness
            final_per=2; %HCSA
            kbest=final_per+(1-iIter/Out.MaxIter)*(100-final_per);         %%HCSA Percentage of the best crows at the last iteration
            kbest=round(Npopulation*kbest/100); %HCSA
        end
        for i=1:Npopulation
            r=rand;
            if r>AP
                
                if Hybrid==1
                    dif=zeros(kbest,NDecisionVariable);%HCSA
                    for j=1:kbest %HCSA
                        k=ds(j);%HCSA
                        if i~=k %HCSA
                            dif(j,:)=fl*rand*(PositionMemory(k,:)-Position(i,:)); %HCSA
                        end %HCSA
                    end %HCSA
                    difference=sum(dif)/kbest; %HCSA
                    XXnew(i,:)= Position(i,:)+difference;       %HCSA   %New positions at the first stage of mutation
                    Xnew(i,:)=XXnew(i,:)+fl*rand*(PositionMemory(BestGlobalMemory(1),:)-XXnew(i,:)); %New position at the second and final stage of mutation
                else
                    Xnew(i,:)= Position(i,:)+fl*rand*(PositionMemory(num(i),:)-Position(i,:)); %Original CSA % Generation of a new position for crow i (state 1)
                end
                
                % Xnew(i,j)= Position(i,j)+fl*rand*(mean(PositionMemory(:,j)-Position(i,j))); % Generation of a new position for crow i (state 1)
                %Xnew(i,j)= Position(i,j)+((PositionMemory(num(i),j)-Position(i,j))/2); % Generation of a new position for crow i (state 1)
                %Xnew(i,j)= Position(i,j)+fl*rand*(Mea(1,j)-Position(i,j)); % Generation of a new position for crow i (state 1)
            else
                Xnew(i,:)=LowerBound(:,1)+(UpperBound(:,1)-LowerBound(:,1))*rand; % Generation of a new position for crow i (state 2)
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
                %     fitne=fitness(Position,Out); % Fitness evaluation
                [fitne,BoolPenalty]=EngineeringFitness(Position,i,Out.EngFunction); % Fitness evaluation
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
end
Results.NFEAll=NFEAll;
Results.PenaltyCount=PenaltyCountAll;