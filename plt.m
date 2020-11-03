function P=plt(Nrun,Func,itermax,Algorithm,BestSolutions)
    figure(Func);
    P=plot(BestSolutions,'o','Color',[rand,rand,rand],...
    'LineWidth',2,...
    'MarkerEdgeColor',[rand,rand,rand],...
    'MarkerFaceColor',[rand,rand,rand],...
    'MarkerSize',10);
    
    xlabel('No.Iteration');
    ylabel('Fittness Value');
    
    Legend2=cell(2,1);
    
    
%     Legend2{1}=(['Function No :',num2str(Func)]);
%     Legend2{2}=(['Algorithm Type :',Algorithm]);
%       
%     legend(['Function No :',num2str(Func),' ; ','Algorithm Type :',Algorithm]);
%     
    %legend(['Function No :',num2str(Func)],Algorithm);

    
end