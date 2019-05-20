function [ opt_sv] = sensoryuncertainty( datatable)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

%%___________________________________________________________%%
err=datatable(:,12);  
t = datatable(:,2) ;         
v = abs(datatable(:,1));
opt_sv=fminsearch('fit_model_sv',[1 1 1],[ ],err,t,v);  
predicted=opt_sv(1,1).*(t.^opt_sv(1,2) ).*(v.^opt_sv(1,3));


end

