function Z=fitness(x)

xn=x;
s1=zeros(1,10);
s2=zeros(1,10);
for i=1:size(xn,1)
    for j=1:10
       s1(j)=xn(i,j)^2;
       s2(j)=0.5*j*xn(i,j);
    end
 
  Z(i) = sum(s1)+(sum(s2))^2 +(sum(s2))^4;% Sphere function
end








%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                   %
%                          www.matlabnet.ir                         %
%                   Free Download  matlab code and movie            %
%                          Shahab Poursafary                        %
%                                                                   %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%