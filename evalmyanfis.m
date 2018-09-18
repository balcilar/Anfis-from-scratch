function yhat=evalmyanfis(mynet,inputs)
%% written by Muhammet Balcilar, France
%  all rights reserved

ndata=size(inputs,1);
% calculate best nets output
for j=1:ndata
    mynet.nodes(1:mynet.ni)=inputs(j,:)';
    mynet=calculate_output1(mynet);
    mynet=calculate_output2(mynet);
    mynet=calculate_output3(mynet);    
    mynet=calculate_output4(mynet);
    mynet=calculate_output5(mynet);    
    yhat(j,1)=mynet.nodes(end);
end


