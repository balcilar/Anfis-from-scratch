function mynet=calculate_output2(mynet)
%% written by Muhammet Balcilar, France
%  all rights reserved
st=mynet.ni+mynet.ni*mynet.mf;
for i=st+1:st+mynet.nc
    I=find(mynet.config(:,i)==1);    
    tmp=cumprod(mynet.nodes(I));
    mynet.nodes(i)=tmp(end);
end