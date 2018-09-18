function mynet=calculate_output(mynet,from, to)
%% written by Muhammet Balcilar, France
%  all rights reserved
mparams=mynet.mparams;
for i=from:to
    
    mparam=mynet.nodes(i).mparam;
    
    mynet.nodes(i)=1;
    
    
end
