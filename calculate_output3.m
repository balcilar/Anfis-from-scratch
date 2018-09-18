function mynet=calculate_output3(mynet)
%% written by Muhammet Balcilar, France
%  all rights reserved
st=mynet.ni+mynet.ni*mynet.mf +mynet.nc ;
for i=st+1:st+mynet.nc
    I=find(mynet.config(:,i)==1);    
    denom=sum(mynet.nodes(I));    
    mynet.nodes(i)=mynet.nodes(i-mynet.nc)/denom;
end

