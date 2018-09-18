function  mynet=clear_de_dp(mynet)
%% written by Muhammet Balcilar, France
%  all rights reserved
mynet.mparam_de_do=zeros(mynet.ni*mynet.mf,3);
mynet.kparam_de_do=zeros(mynet.nc,mynet.ni+1);