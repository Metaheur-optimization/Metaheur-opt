% for functions 112
function o=Ufun(x,a,k,m)
    o=k.*((x-a).^m).*(x>a)+k.*((-x-a).^m).*(x<(-a));
end