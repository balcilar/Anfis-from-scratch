function mynet=calculate_output1(mynet)
%% written by Muhammet Balcilar, France
%  all rights reserved
mparams=mynet.mparams;

for i=1:mynet.ni
    for j=1:mynet.mf
        
        ind=mynet.ni+(i-1)*mynet.mf+j;
        
        x = mynet.nodes(i);
        a = mparams((i-1)*mynet.mf+j,1);
        b = mparams((i-1)*mynet.mf+j,2);
        c = mparams((i-1)*mynet.mf+j,3);
        
        tmp1 = (x - c)/a;
        if tmp1 == 0
            tmp2=0;
        else
            tmp2 = (tmp1*tmp1)^b;
        end
        mynet.nodes(ind)=1/(1+ tmp2); 
    end
    
end
