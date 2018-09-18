function [bestnet,anfis_output,RMSE]=myanfis(data,epoch_n,mf,step_size,decrease_rate,increase_rate)

%% written by Muhammet Balcilar, France
%  all rights reserved

% divide data as input and output
inputs=data(:,1:end-1);
output=data(:,end);
% data lenght
ndata=size(data,1);



% define minimum and maximum of input to determine initial memberhip
% functions
mn=min(inputs);
mx=max(inputs);
mm=mx-mn;
% number of input
ni=size(inputs,2);
% number of rules
nc=mf^ni;
% total number of nodes
Node_n = ni + ni*mf + 3*nc + 1;

min_RMSE=999999999999;
% define initial membership functions
mparams=[];
for i=1:ni
    tmp=linspace(mn(1),mx(1),mf)';
    mparams=[mparams;repmat([mm(i)/6 2],mf,1) tmp];
end
% define initial kalman parameters with all zero
kparams=zeros(nc,(ni+1));




% create connection matrix and node array
% connection matrix show which node connect to another
% nodes vector shows the output of certain node

config=zeros(Node_n);
nodes=zeros(Node_n,1);

% inputs - layer1 connections
st=ni;
for i=1:ni
    config(i,st+[1:mf])=1;
    st=st+mf;
end

% layer1-layer2 connections
st=ni+ni*mf+1;

if size(inputs,2)==2
    for i=1:mf
        for j=1:mf
            config(ni+i,st)=1;
            config(ni+mf+j,st)=1;
            st=st+1;
        end
    end
elseif size(inputs,2)==3
    for i=1:mf
        for j=1:mf
            for k=1:mf
                config(ni+i,st)=1;
                config(ni+mf+j,st)=1;
                config(ni+2*mf+k,st)=1;
                st=st+1;
            end
        end
    end
elseif size(inputs,2)==4
    for i=1:mf
        for j=1:mf
            for k=1:mf
                for l=1:mf
                    config(ni+i,st)=1;
                    config(ni+mf+j,st)=1;
                    config(ni+2*mf+k,st)=1;
                    config(ni+3*mf+l,st)=1;
                    st=st+1;
                end
            end
        end
    end
elseif size(inputs,2)==5
    for i=1:mf
        for j=1:mf
            for k=1:mf
                for l=1:mf
                    for m=1:mf
                        config(ni+i,st)=1;
                        config(ni+mf+j,st)=1;
                        config(ni+2*mf+k,st)=1;
                        config(ni+3*mf+l,st)=1;
                        config(ni+4*mf+m,st)=1;
                        st=st+1;
                    end
                end
            end
        end
    end
else
    return;
end

% layer2-layer3 connections
for i=1:nc
    for j=1:nc
        config(ni+ni*mf+i,ni+ni*mf+nc+j)=1;
    end
end

% layer3-layer4 connections
for i=1:nc
    config(ni+ni*mf+nc+i,ni+ni*mf+2*nc+i)=1;
end


% layer4-layer5 connections
for i=1:nc
    config(ni+ni*mf+2*nc+i,end)=1;
end

% inputs - layer4  connections
for i=1:ni
    for j=1:nc
        config(i,ni+ni*mf+2*nc+j)=1;
    end
end

% create network struct
mynet.config=config;
mynet.mparams=mparams;
mynet.kparams=kparams;
mynet.nodes=nodes;
mynet.ni=ni;
mynet.mf=mf;
mynet.nc=nc;
mynet.last_decrease_ss=1;
mynet.last_increase_ss=1;


% iteration loop
for iter=1:epoch_n
    for j=1:ndata
        
        % set j th input into the networks
        mynet.nodes(1:mynet.ni)=inputs(j,:)';
        
        % get node outputs from layer 1 to layer 3
        mynet=calculate_output1(mynet);
        mynet=calculate_output2(mynet);
        mynet=calculate_output3(mynet);
        
        % save outputs of layer 1 to 3
        layer_1_to_3_output(:,j)=mynet.nodes;
        
        % calculate kalman params
        kalman_data=get_kalman_data(mynet,output(j));
        % update kalman params
        mynet=mykalman(mynet,kalman_data,j);
        
    end
    % clear all derivatives as zero
    mynet=clear_de_dp(mynet);
    
    for j=1:ndata
        
        % get output of layer 1 to 3 from layer_1_to_3_output to avoid
        % recalculation of layer1-2-3
        mynet.nodes=layer_1_to_3_output(:,j);
        
        % calculate outputs of layer 4
        mynet=calculate_output4(mynet);
        
        % calculate outputs of layer 5
        mynet=calculate_output5(mynet);
        % calculate network output
        anfis_output(j,1)=mynet.nodes(end);
        target=output(j);
        % calculate differential of error
        de_dout = -2*(target - anfis_output(j,1));
        % backpropagete errors
        mynet=calculate_de_do(mynet,de_dout);
        mynet=update_de_do(mynet);
        
        
    end
    
    % calculate one train loop error
    diff=anfis_output-output;
    total_squared_error=sum(diff.*diff);
    RMSE(iter,1) = sqrt(total_squared_error/ndata);
    fprintf('%g. rmse error : %g \n',iter,RMSE(iter,1));
    % if error is the best up to now then keep it
    if RMSE(iter,1)<min_RMSE
        bestnet=mynet;
        min_RMSE=RMSE(iter,1);
    end
    
    % update membership parameter
    mynet=update_parameter(mynet, step_size);
    % update step size
    [mynet step_size]=update_step_size(mynet,RMSE,iter,step_size,decrease_rate, increase_rate);
    
end


% calculate best nets output
mynet=bestnet;
for j=1:ndata
    mynet.nodes(1:mynet.ni)=inputs(j,:)';
    mynet=calculate_output1(mynet);
    mynet=calculate_output2(mynet);
    mynet=calculate_output3(mynet);
    mynet=calculate_output4(mynet);
    mynet=calculate_output5(mynet);
    anfis_output(j,1)=mynet.nodes(end);
end


