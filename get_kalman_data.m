function kalman_data=get_kalman_data(mynet,target)
%% written by Muhammet Balcilar, France
%  all rights reserved
kalman_data=zeros( (mynet.ni+1)*mynet.nc+1,1);

st=mynet.ni+mynet.ni*mynet.mf +mynet.nc ;

j=1;
for i=st+1:st+mynet.nc
    for k=1:mynet.ni
        kalman_data(j)=mynet.nodes(i)*mynet.nodes(k);
        j=j+1;
    end
    kalman_data(j)=mynet.nodes(i);
    j=j+1;
end
kalman_data(j)=target;