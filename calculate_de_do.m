function mynet=calculate_de_do(mynet,de_dout)
%% written by Muhammet Balcilar, France
%  all rights reserved
mynet.de_do=zeros(size(mynet.nodes));
mynet.de_do(end)=de_dout;

for i=length(mynet.nodes)-1:-1:mynet.ni+1
    de_do=0;
    II=find(mynet.config(i,:)==1);
    I=find(II>i);
    for j=1:length(I)
        jj=II(I(j));
        tmp1=mynet.de_do(jj);
        tmp2=derivative_o_o(mynet,i, jj);
        de_do = de_do+tmp1*tmp2;
    end
    mynet.de_do(i)=de_do;
end



function tmp=derivative_o_o(mynet,i, j)

if i>mynet.ni+mynet.ni*mynet.mf +2*mynet.nc
    tmp=1;
elseif i>mynet.ni+mynet.ni*mynet.mf +mynet.nc
    tmp=do4_do3(mynet,i, j);
elseif i>mynet.ni+mynet.ni*mynet.mf 
    tmp=do3_do2(mynet,i, j);
elseif i>mynet.ni
    tmp=mynet.nodes(j)/mynet.nodes(i);
end


function tmp=do4_do3(mynet,i, j)
kparam=mynet.kparams;
inp=mynet.nodes(1:mynet.ni)';
jj=j-mynet.ni-mynet.ni*mynet.mf -2*mynet.nc;
tmp=sum(kparam(jj,1:end-1).*inp)+kparam(jj,end);

function tmp=do3_do2(mynet,i, j)
II=find(mynet.config(:,j)==1);
I=find(II<j);
total=sum(mynet.nodes(II(I)));
if j-i==mynet.nc
    tmp=(total-mynet.nodes(i))/(total*total);
else
    tmp=-mynet.nodes(j-mynet.nc)/(total*total);
end




        
    
    
