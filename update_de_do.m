function mynet=update_de_do(mynet)
%% written by Muhammet Balcilar, France
%  all rights reserved
s=1;
for i=mynet.ni+1:mynet.ni+mynet.ni*mynet.mf
    
    for j=1:3
        do_dp = dmf_dp(mynet,i, j);
        mynet.mparam_de_do(s,j)=mynet.mparam_de_do(s,j) + mynet.de_do(i)*do_dp;
    end
    s=s+1;
end
s=1;
for i=1+mynet.ni+mynet.ni*mynet.mf+2*mynet.nc:size(mynet.config)-1%16+mynet.ni+mynet.ni*mynet.mf+2*mynet.nc    
    for j=1:mynet.ni+1
        do_dp = dconsequent_dp(mynet,i, j);        
        mynet.kparam_de_do(s,j)=mynet.kparam_de_do(s,j) + mynet.de_do(i)*do_dp;
    end
    s=s+1;
end



function tmp=dmf_dp(mynet,i, j)
I=find(mynet.config(:,i)==1);
x=mynet.nodes(I);
a=mynet.mparams(i-mynet.ni,1);
b=mynet.mparams(i-mynet.ni,2);
c=mynet.mparams(i-mynet.ni,3);
tmp1 = (x - c)/a;
if tmp1==0
    tmp2=0;
else
    tmp2 = (tmp1*tmp1)^b;
end
denom = (1 + tmp2)*(1 + tmp2);
if j==1
    tmp=(2*b*tmp2/(a*denom));
elseif j==2 && tmp1==0
    tmp=0;
elseif j==2 && tmp1~=0
    tmp=(-log(tmp1*tmp1)*tmp2/denom);
elseif j==3 && x==c
    tmp=0;
elseif j==3 && x~=c
    tmp=(2*b*tmp2/((x - c)*(denom)));
end


function tmp=dconsequent_dp(mynet,i, j)

wn=mynet.nodes(i-mynet.nc); 
inp=mynet.nodes(1:mynet.ni)';
inp=[inp 1];
tmp=wn*inp(j);

   
    

    