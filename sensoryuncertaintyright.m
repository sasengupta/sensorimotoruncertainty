function [ opt_sv ] = sensoryuncertaintyright( datatable)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

%%___________________________________________________________%%
err=datatable(441:end,12);  
t = datatable(441:end,2) ;         
v = abs(datatable(441:end,1));
opt_sv=fminsearch('fit_model_sv',[1 1 1],[ ],err,t,v);  

end
