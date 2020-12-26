%% CSA first modified by KB 25 Dec 2020
function [AllBestFitnesses,BestSolution]=CSA(Out)
%% Setting and definition of variables
rng('default')
AllBestFitnesses=zeros(Out.NRun,Out.MaxIter);
Npopulation=Out.Npopulation; % Flock (population) size
NDecisionVariable=Out.NDecisionVariable; % Problem dimension (number of decision variables)
LowerBound=Out.LowerBound;
UpperBound=Out.UpperBound;
AP=Out.AP;
fl=Out.fl;
%%Define structure for the array of solutions
Memory=zeros(Npopulation,NDecisionVariable);

%% Main loop of indepdendent runs
for iRun=1:Out.NRun
    %% initialization
    Position=init(Out); % Initialization of solutions
    fitnessMemory=fitness(Position,Out); % Fitness evaluation
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
        end
        
        
        % Apply Position Limits (Suggested by KB 26 Dec 2020)
        Xnew(i,:) = max(Xnew(i,:),transpose(LowerBound(:,1)));
        Xnew(i,:) = min(Xnew(i,:),transpose(UpperBound(:,1)));

        fitne=fitness(Xnew,Out); % Function for fitness evaluation of new solutions
        
        for i=1:Npopulation % Update position and memory
            Bool=1;
            for j=1:NDecisionVariable % Update position and memory
                if Xnew(i,j)<=LowerBound(j) || Xnew(i,j)>=UpperBound(j)
                    Bool=0;
                    break
                end
            end
            if(Bool==1)
                Position(i,:)=Xnew(i,:); % Update position
                if fitne(i)<fitnessMemory(i)% Update memory only if fitness is better
                    PositionMemory(i,:)=Xnew(i,:); 
                    fitnessMemory(i)=fitne(i);
                end
            end
        end
        Bestfit(iIter)=min(fitnessMemory); % Best fitness found at iteration t
        %         disp(['run =   ',num2str(iRun),'  iter =   ',num2str(iIter),' BEST Fitness= ',num2str(Bestfitness(iIter))])
    end
    
    %% Saving results of the solution
    [~,ngbest]=min(fitnessMemory);
    BestSolution=Memory(ngbest(1),:); % Solutin of the problem
    AllBestFitnesses(iRun,:)=Bestfit;    
end
