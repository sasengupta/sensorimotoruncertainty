function [ opt_sv] = sensoryuncertaintyleft( datatable)
%fit the combined model, check the error column
%%___________________________________________________________%%
err=datatable(1:440,12);  
t = datatable(1:440,2) ;         
v = abs(datatable(1:440,1));
opt_sv=fminsearch('fit_model_sv',[1 1 1],[ ],err,t,v);  
 

end
