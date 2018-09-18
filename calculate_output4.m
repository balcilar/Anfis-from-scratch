function mynet=calculate_output4(mynet)
%% written by Muhammet Balcilar, France
%  all rights reserved
st=mynet.ni+mynet.ni*mynet.mf +2*mynet.nc ;
inp=mynet.nodes(1:mynet.ni)';
kparam=mynet.kparams;

for i=1:mynet.nc
    wn=mynet.nodes(i+st-mynet.nc);
    mynet.nodes(i+st)=wn*(sum(kparam(i,1:end-1).*inp)+kparam(i,end));
end
    
    
    
    
    
    
    
    

