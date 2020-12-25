function t=BenchMarkFunction(Sol)

global NFE FunctionNumber
FuncNum=FunctionNumber;
NumSol=numel(Sol(:,1));
t=zeros(NumSol,1);

for jj=1:NumSol 
    NFE=NFE+1;
    x=Sol(jj,:);
    switch FuncNum

        case 1 %NumVar=1, -Inf<x<+Inf, f(0)=1
            z=abs(x)+cos(x);

        case 2 %NumVar=1, -Inf<x<+Inf, f(0)=0
            z=abs(x)+sin(x);        

        case 3 
            z=sum(x'.^2)';

        case 4 % Rosen Brock
            n=numel(x);
            z=sum((1-x(1:n-1)).^2)+100*sum((x(2:n)-x(1:n-1).^2).^2);

        case 5  
            z=sum(abs(x) -10*cos(sqrt(abs(10*x))));   

        case 6 
            z=sum((x.^2+x).*cos(x));   

        case 7 
            z=x(1)*sin(4*x(1))+1.1*x(2)*sin(2*x(2));       

        case 8 
            z=x(2)*sin(4*x(1))+1.1*x(1)*sin(2*x(2));      

        case 9 % Rastrigin
            z=10*numel(x)+sum(x.^2-10*cos(2*pi*x));   

        case 10 
            z=1+sum(x.^2/4000)-prod(cos(x)./sqrt(1:numel(x)));

        case 11 
            z=0.5+((sin(sqrt(x(1)^2+x(2)^2)))^2-0.5) ./(1+0.01*(x(1).^2+x(2).^2));

        case 12 % Ackly  
            n = size(x,2);
            z = -20*exp(-0.2*sqrt(1/n*(sum(x.^2))))-exp(1/n*(sum(cos(2*pi*x))))+20+exp(1);      
    end
    
    t(jj,1)=z;
end
 
end
