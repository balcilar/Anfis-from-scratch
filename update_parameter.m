function mynet=update_parameter(mynet, step_size)
%% written by Muhammet Balcilar, France
%  all rights reserved
tmp=mynet.mparam_de_do;
tmp=tmp.*tmp;
len=sqrt(sum(tmp(:)));
mynet.mparams= mynet.mparams - step_size * mynet.mparam_de_do/len;

