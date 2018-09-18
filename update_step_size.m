function [mynet step_size]=update_step_size(mynet,error_array,iter,step_size,decrease_rate, increase_rate)
%% written by Muhammet Balcilar, France
%  all rights reserved
if check_decrease_ss(error_array, mynet.last_decrease_ss, iter)
    step_size = step_size*decrease_rate;		
	mynet.last_decrease_ss = iter;
elseif check_increase_ss(error_array, mynet.last_increase_ss, iter)
    step_size = step_size*increase_rate;
	mynet.last_increase_ss = iter;
end


function sts=check_decrease_ss(error_array, last_change, current)
if (current - last_change < 4)
	sts=false;
elseif ((error_array(current)     < error_array(current - 1)) && ...
	    (error_array(current - 1) > error_array(current - 2)) && ...
	    (error_array(current - 2) < error_array(current - 3)) && ...
	    (error_array(current - 3) > error_array(current - 4)))
    sts=true;
else
    sts=false;
end

function sts=check_increase_ss(error_array, last_change, current)
if (current - last_change < 4)
	sts=false;
elseif ((error_array(current)     < error_array(current - 1)) && ...
	    (error_array(current - 1) < error_array(current - 2)) && ...
	    (error_array(current - 2) < error_array(current - 3)) && ...
	    (error_array(current - 3) < error_array(current - 4)))
    sts=true;
else
    sts=false;
end
		