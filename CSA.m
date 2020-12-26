
% -------------------------------------------------
function [Global,fitnessMemory,g_best]=CSA(Out)
Global=zeros(Out.NRun,Out.MaxIter);

Npopulation=Out.Npopulation; % Flock (population) size
NDecisionVariable=Out.NDecisionVariable; % Problem dimension (number of decision variables)
LowerBound=Out.LowerBound;
UpperBound=Out.UpperBound;
AP=Out.AP;
fl=Out.fl;

for iRun=1:Out.NRun
    
    InitArray=init(Out); % Function for initialization
    
    ft=fitness(InitArray,Out); % Function for fitness evaluation
    
    Memory=InitArray; % initialization of Memory of each Crow
    fitnessMemory=ft; % Fitness of memory positions
    
    Bestfitness=zeros(Out.MaxIter);
    
    %Main loop of iteration
    Xnew=zeros(Npopulation,NDecisionVariable);
    for iIter=1:Out.MaxIter % Maximum number of iterations (itermax)
        num=ceil(Npopulation*rand(1,Npopulation)); % Generation of random candidate crows for following (chasing)
        for i=1:Npopulation
            if rand>AP
                Xnew(i,:)= InitArray(i,:)+fl*rand*(Memory(num(i),:)-InitArray(i,:)); % Generation of a new position for crow i (state 1)
            else
                for j=1:NDecisionVariable
                    Xnew(i,j)=LowerBound-(LowerBound-UpperBound)*rand; % Generation of a new position for crow i (state 2)
                end
            end
        end
        
        ft=fitness(Xnew,Out); % Function for fitness evaluation of new solutions
        
        for i=1:Npopulation % Update position and memory
            if Xnew(i,:)>=LowerBound && Xnew(i,:)<=UpperBound
                InitArray(i,:)=Xnew(i,:); % Update position
                if ft(i)<fitnessMemory(i)
                    Memory(i,:)=Xnew(i,:); % Update memory
                    fitnessMemory(i)=ft(i);
                end
            end
        end
        Bestfitness(iIter)=min(fitnessMemory); % Best found value until iteration t
        disp([ 'run =   ' num2str(iRun)     '  iter =   '  num2str(iIter)   ' BEST = '  num2str(Bestfitness(iIter))])
    end
    ngbest=find(fitnessMemory== min(fitnessMemory));
    g_best=Memory(ngbest(1),:); % Solutin of the problem
    Global(iRun,:)=Bestfitness;
end
