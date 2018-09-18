function mynet=mykalman(mynet,kalman_data,k)
%% written by Muhammet Balcilar, France
%  all rights reserved
k_p_n= (mynet.ni+1)*mynet.nc;
alpha = 1000000;

if k==1
    mynet.P=zeros(k_p_n,1);
    mynet.S=alpha*eye(k_p_n);
end

x=kalman_data(1:end-1);
y=kalman_data(end);

tmp1=(x'*mynet.S)';
denom=1+sum(tmp1.*x);
tmp1=(mynet.S*x);

tmp2=(x'*mynet.S)';
tmp_m=tmp1*tmp2';
tmp_m=-1/denom*tmp_m;
mynet.S=mynet.S+tmp_m;

diff=y-sum(x.*mynet.P);
tmp1=diff*(mynet.S*x);
mynet.P=mynet.P+tmp1;
mynet.kparams=reshape(mynet.P,[mynet.ni+1 mynet.nc])';







    
    
    

