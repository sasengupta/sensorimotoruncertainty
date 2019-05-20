function [errorsummary, outliersummary,stat_table] = behavior_output_mv(table_sm,diagnostic,color_out)
% % datatable=horzcat(ballspeed,st,error,paddlefinish,indicatedposition,
% %                   correctposition,ballfinishposition,dir);

colorchar=color_out;
%undo table
velocity_amp=abs(table_sm(:,6));
time_sm=table_sm(:,2);
landingerror=table_sm(:,3);
indicatedposition=table_sm(:,5);
dir=table_sm(:,8);
ball_dir=[-1,1];
peak_vel=table_sm(:,9);
vel_at_end=table_sm(:,10);
%check that experiment code works fine
correctposition=table_sm(:,5);
% % paddlefinish=abs((table_sm(:,4)-20));
% % ball_finish=abs((table_sm(:,6)-20));
%________________________________________________________________________%
index=1;
outliersummary=0;
timecount=(unique(time_sm))
ampcount=(unique(abs(velocity_amp)))
    for count1=1:1:length(timecount)
       for count2 =1:1:length(ampcount)
           casetrials=find((time_sm==timecount(count1))& ...
                           (velocity_amp==ampcount(count2)));
        %new function for detecting outliers
        errorsummary(1).meanerror(count1,count2)=nanmean(landingerror(casetrials));
        errorsummary(1).stderror(count1,count2)=std(landingerror(casetrials),'omitnan');
        errorsummary(1).peakvel(count1,count2)=nanmean(peak_vel(casetrials));
        errorsummary(1).velatend(count1,count2)=std(vel_at_end(casetrials),'omitnan');
           if (diagnostic==1)
            plot(velocity_amp(casetrials)+(count1*.2),indicatedposition(casetrials), ...
                 'LineStyle','none','Marker','o','MarkerSize',6,'MarkerEdgeColor',colorchar, 'MarkerFaceColor',colorchar)
            %plot(velocity_amp(casetrials)+(count1*.2),peak_vel(casetrials), ...
             %    'LineStyle','none','Marker','square','MarkerSize',6,'MarkerEdgeColor',colorchar, 'MarkerFaceColor',colorchar)
 
            shg;%pause;
           end
          hline(mean(velocity_amp(casetrials)),'k');
        %checkvariables
        %check that experiment code works fine
% %         direction(count3).meanLP(count1,count2)=mean(paddlefinish(casetrials));
% %         Error_inmodel(casetrials)=paddlefinish(casetrials)-direction(count3).meanLP(count1,count2);
% %         direction(count3).compare_err(count1,count2)=direction(count3).meanLP(count1,count2)-mean(correctposition(casetrials));
% %         direction(count3).compare_stderr(count1,count2)=std(paddlefinish(casetrials));
        stat_table(index,1)=timecount(count1);
        stat_table(index,2)=ampcount(count2);
        stat_table(index,3)=nanmean(indicatedposition(casetrials));
        stat_table(index,4)=std(indicatedposition(casetrials),'omitnan');
        stat_table(index,5)=nanmean(vel_at_end(casetrials));
        stat_table(index,6)=nanmean(peak_vel(casetrials));
        stat_table(index,7)=std(peak_vel(casetrials),'omitnan');
        index=index+1;
       end
    end
end


