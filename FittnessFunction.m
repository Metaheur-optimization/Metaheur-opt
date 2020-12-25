function Ft=FittnessFunction(x)

Ft=sum(abs(x) -10*cos(sqrt(abs(10*x))));
end