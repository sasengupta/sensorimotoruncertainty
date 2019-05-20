function [ mod_datatable ] = pre_model_mv( datatable )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
%%__subtract mean from the error_%%
% % datatable=horzcat(1000*ones(length(mt),1),mt,error,paddlefinish,indicatedposition...
% %      correctposition,ballfinishposition,dir,peakvel,velatend);
outlier_cut=3;
t = datatable(:,2) ;         
amp = datatable(:,6);
dir=datatable(:,8); 
t_con=unique(t)
amp_con=unique(amp)
upperbound=mean(datatable(:,3))+outlier_cut*std(datatable(:,3));lowerbound=mean(datatable(:,3))-outlier_cut*std(datatable(:,3));
for count1=1:1:length(t_con)
   for count2 =1:1:length(amp_con)
        casetrials=find((t(1:end)==t_con(count1))& (amp(1:end)==amp_con(count2)));
        err_mod(casetrials)=datatable(casetrials,5)-datatable(casetrials,6);
        %err_mod(casetrials)=datatable(casetrials,5)-mean(datatable(casetrials,5));%amp_con(count2); 
        %mean(datatable(casetrials,5));
        % remove very short mt trials
          
% %method 2: remove outliers
          %upperbound=check_mean+2.5*check_std;lowerbound=check_mean-2.5*check_std;
          remtrials=find((datatable(casetrials,3)>upperbound) | (datatable(casetrials,3)<lowerbound));
          datatable(casetrials(remtrials),:)=NaN;
          err_mod(casetrials(remtrials))=NaN
          %pause;
          check_mean=nanmean(datatable(casetrials,5));
          check_std=std(datatable(casetrials,5),'omitnan');
% % remove conditions ____ checking for undershooting
          if ((~((check_mean+2*check_std >=amp_con(count2))&&(check_mean-2*check_std <=amp_con(count2)))) ...
                 &&(max(datatable(casetrials,5))<amp_con(count2)))
% %   %%((check_mean+1*check_std >=amp_con(count2)) &&(max(datatable(casetrials,5))<amp_con(count2)))
% % % %&& ((check_mean-2*check_std <=amp_con(count2))))
% %          %if(t_con(count1)==min(t_con))
% %           %   t_con(count1)
% %            %  pause;
            err_mod(casetrials)=NaN;
            disp(length(casetrials))
        %pause; 
        end
         
    end
end
size(err_mod)
size(datatable)
mod_datatable=horzcat(datatable,err_mod');
exclude=isnan(mod_datatable(:,12));
mod_datatable(exclude,:)=[];
disp(size(mod_datatable))
%pause;
end


