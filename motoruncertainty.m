function [ opt_mv ] = motoruncertainty( datatable)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
disp(size(datatable));

err=datatable(:,12);
t= datatable(:,2); 
x=datatable(:,6); 

opt_mv=fminsearch('fit_model_mv',[0 1.5],[ ],x,t,err);  
 
    

end

