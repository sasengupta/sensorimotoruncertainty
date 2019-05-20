function [ mod_datatable ] = pre_model_sv( datatable )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
%%__subtract mean from the error_%%
% % datatable=horzcat(ballspeed,st,error,paddlefinish,...
% %                   indicatedposition,correctposition,ballfinishposition,dir,peakvel,velatend);
outlier_cut=3;
t = datatable(:,2) ;         
v = abs(datatable(:,1));
dir=datatable(:,8); 
t_con=unique(t);
v_con=unique(v);
upperbound=mean(datatable(:,3))+outlier_cut*std(datatable(:,3));lowerbound=mean(datatable(:,3))-outlier_cut*std(datatable(:,3));
for count1=1:1:length(t_con)
   for count2 =1:1:length(v_con)
    casetrials=find((t(1:end)==t_con(count1))& (v(1:end)==v_con(count2))& (dir==1));
    %err_mod(casetrials)=datatable(casetrials,5)-datatable(casetrials,6);
    err_mod(casetrials)=datatable(casetrials,5)-mean(datatable(casetrials,5));
            check_mean=mean(datatable(casetrials,5));check_std=std(datatable(casetrials,5));
            %outliers in each sensing time/ballvelocity pair, not an
            %adequate outlier detector.
            %upperbound=check_mean+outlier_cut*check_std;lowerbound=check_mean-outlier_cut*check_std;
            remtrials=find((datatable(casetrials,3)>upperbound) | (datatable(casetrials,3)<lowerbound));
            err_mod(casetrials(remtrials))=NaN;
    clear casetrials check_mean check_std;
    casetrials=find((t(1:end)==t_con(count1))& (v(1:end)==v_con(count2))& (dir==-1));
    err_mod(casetrials)=datatable(casetrials,5)-mean(datatable(casetrials,5)); 
          check_mean=mean(datatable(casetrials,5));check_std=std(datatable(casetrials,5));
          %upperbound=check_mean+outlier_cut*check_std;lowerbound=check_mean-outlier_cut*check_std;
          remtrials=find((datatable(casetrials,3)>upperbound) | (datatable(casetrials,3)<lowerbound));
          err_mod(casetrials(remtrials))=NaN;
   end

end
size(err_mod)
size(datatable)
mod_datatable=horzcat(datatable,err_mod');
exclude=isnan(mod_datatable(:,12));
mod_datatable(exclude,:)=[];
disp(size(mod_datatable))
end

