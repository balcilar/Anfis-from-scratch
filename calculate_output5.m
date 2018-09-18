function mynet=calculate_output5(mynet)
%% written by Muhammet Balcilar, France
%  all rights reserved
mynet.nodes(end)=sum( mynet.nodes(end-mynet.nc:end-1));