function [AllNewPositionMemory,BossLionPositionMemory,SupportLionPositionMemory]=ObjFucEval(AllPositionMemory,ObjectiveType,NoofBossLions)

if ObjectiveType==0   % (Minimization)
    [NDV LastCol]=size(AllPositionMemory);
   AllNewPositionMemory=sortrows(AllPositionMemory,LastCol);
   BossLionPositionMemory=AllNewPositionMemory(1:NoofBossLions,:); 
   SupportLionPositionMemory=AllNewPositionMemory(NoofBossLions+1:end,:);
      
else    %(Maximization)
    
  
    
    
    
    
    
    
    
    
    
    
    
    
    
    
end 







end