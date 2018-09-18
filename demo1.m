%% written by Muhammet Balcilar, France
%  all rights reserved
clear all
clc

% define parameters
epoch_n=100;
mf=2;
step_size=0.1;
decrease_rate=0.9;
increase_rate=1.1;


% load data, last column is output, rest columns are inputs
data=load('Input/data3input.trn');


% run our anfis model
[bestnet,y_myanfis,RMSE]=myanfis(data,epoch_n,mf,step_size,decrease_rate,increase_rate);

figure;imagesc(bestnet.config)
title('Node Connections');

figure;
for i=1:3
    subplot(1,3,i);
    x = -10:0.1:10;%min(data(:,i))-1:0.1:max(data(:,i))-1;
    y = gbellmf(x,bestnet.mparams((i-1)*2+1,:));plot(x,y)
    hold on;
    y = gbellmf(x,bestnet.mparams((i-1)*2+2,:));plot(x,y,'r-')
    msg=[num2str(i) 'th variables membership functions'];
    title(msg);
end


% make prediction
y_myanfis=evalmyanfis(bestnet,data(:,1:end-1));

% plot error decreasing
figure;plot(RMSE,'LineWidth',2);xlabel('iteration');
ylabel('rmse');title('Error by iteration');


% plot prediction plot

figure;
plot(data(:,end),'b*');
hold on;plot(y_myanfis,'r-','Linewidth',0.5);
xlabel('data point');ylabel('output value');
legend({'actual output','our anfis prediction'});

% calculate rmse's
rmse1=sqrt(sum((y_myanfis-data(:,end)).^2)/size(data,1));

msg=['Total rmse error myanfis:' num2str(rmse1)];
title(msg);
