%% written by Muhammet Balcilar, France
%  all rights reserved
clear all
clc

% define parameters
epoch_n=100;
mf=4;
step_size=0.1;
decrease_rate=0.9;
increase_rate=1.1;


% load data, last column is output, rest columns are inputs
data=load('Input/data2input.trn');


% run our anfis model
[bestnet,y_myanfis,RMSE]=myanfis(data,epoch_n,mf,step_size,decrease_rate,increase_rate);

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
