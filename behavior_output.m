function [errorsummary, outliersummary,stat_table] = behavior_output(table_sm,diagnostic,color_out)
% % datatable=horzcat(ballspeed,st,error,paddlefinish,indicatedposition,
% %                   correctposition,ballfinishposition,dir);
index=1;
colorchar=color_out;
%undo table
velocity_amp=abs(table_sm(:,1));
time_sm=table_sm(:,2);
landingerror=table_sm(:,3);
indicatedposition=table_sm(:,5);
dir=table_sm(:,8);
peak_vel=table_sm(:,9);
deliberation_time=.001*table_sm(:,11);
ball_dir=[-1,1];
%check that experiment code works fine
correctposition=table_sm(:,5);
% % paddlefinish=abs((table_sm(:,4)-20));
% % ball_finish=abs((table_sm(:,6)-20));
%________________________________________________________________________%
%figure;hold on;
outliersummary=0;
timecount=(unique(time_sm))
ampcount=(unique(abs(velocity_amp)))
    for count1=1:1:length(timecount)
       for count2 =1:1:length(ampcount)
           casetrials1=find((time_sm==timecount(count1))& ...
                           (velocity_amp==ampcount(count2))& ...
                                                     (dir==-1));
        %new function for detecting outliers
        errorsummary(1).meanerror(count1,count2)=nanmean(landingerror(casetrials1));
        errorsummary(1).stderror(count1,count2)=std(landingerror(casetrials1),'omitnan');
        errorsummary(1).deliberationtime(count1,count2)=mean(deliberation_time(casetrials1),'omitnan');
        errorsummary(1).peakvel(count1,count2)=mean(peak_vel(casetrials1),'omitnan');
        %%______________________________________________________________________________
        stat_table(index,1)=count1;timecount(count1);
        stat_table(index,2)=count2;ampcount(count2);
        stat_table(index,3)=-1;
        stat_table(index,4)=nanmean(landingerror(casetrials1));
        stat_table(index,5)=std(indicatedposition(casetrials1),'omitnan');
        stat_table(index,6)=errorsummary(1).deliberationtime(count1,count2);
        stat_table(index,7)=errorsummary(1).peakvel(count1,count2);
        %%_______________________________________________________________________________
           if (diagnostic==1)
            plot((ampcount(count2)+(count1*.2))*ones(1,length(casetrials1)),landingerror(casetrials1), ...
                 'LineStyle','none','Marker','o','MarkerSize',6,'MarkerEdgeColor',colorchar, 'MarkerFaceColor',colorchar)
           shg;%pause;
           end
           casetrials2=find((time_sm==timecount(count1))& ...
                           (velocity_amp==ampcount(count2))& ...
                                                     (dir==1));
        %add new function for detecting outliers
        errorsummary(2).meanerror(count1,count2)=nanmean(landingerror(casetrials2));
        errorsummary(2).stderror(count1,count2)=std(landingerror(casetrials2),'omitnan');
        errorsummary(2).deliberationtime(count1,count2)=mean(deliberation_time(casetrials2),'omitnan');
        errorsummary(2).peakvel(count1,count2)=mean(peak_vel(casetrials2),'omitnan');
        %%_____________________________________________________________________________
        stat_table(1+index,1)=count1;%timecount(count1);
        stat_table(1+index,2)=count2;%ampcount(count2);
        stat_table(1+index,3)=1;
        stat_table(1+index,4)=nanmean(landingerror(casetrials2));
        stat_table(1+index,5)=std(indicatedposition(casetrials2),'omitnan');
        stat_table(1+index,6)=errorsummary(2).deliberationtime(count1,count2);
        stat_table(1+index,7)=errorsummary(2).peakvel(count1,count2);
        %%_______________________________________________________________________________
           if (diagnostic==1)
            plot(((ampcount(count2)+(count1*.2))*ones(1,length(casetrials1))),landingerror(casetrials1), ...
                 'LineStyle','none','Marker','^','MarkerSize',6,'MarkerEdgeColor',colorchar, 'MarkerFaceColor',colorchar)
           shg;%pause;
           end
       %casetrials1=find((time_sm==timecount(count1))& (velocity_amp==ampcount(count2)));
        errorsummary(3).meanerror(count1,count2)=nanmean(vertcat(landingerror(casetrials1),-1*landingerror(casetrials2)));
        errorsummary(3).stderror(count1,count2)=std((vertcat(landingerror(casetrials1),-1*landingerror(casetrials2))),'omitnan');
        errorsummary(3).deliberationtime(count1,count2)=mean(deliberation_time(casetrials1),'omitnan');
        errorsummary(3).peakvel(count1,count2)=mean(peak_vel(casetrials1),'omitnan');
        %%_____________________________________________________________________________
        stat_table(2+index,1)=count1;%timecount(count1);
        stat_table(2+index,2)=count2;%ampcount(count2);
        stat_table(2+index,3)=0;
        stat_table(2+index,4)=nanmean(landingerror(casetrials1));
        stat_table(2+index,5)=std(landingerror(casetrials1),'omitnan');
        stat_table(2+index,6)=mean(deliberation_time(casetrials1),'omitnan');
        stat_table(2+index,7)=mean(peak_vel(casetrials1),'omitnan');
        %%_______________________________________________________________________________ 
        %checkvariables
        %check that experiment code works fine
% %         direction(count3).meanLP(count1,count2)=mean(paddlefinish(casetrials));
% %         Error_inmodel(casetrials)=paddlefinish(casetrials)-direction(count3).meanLP(count1,count2);
% %         direction(count3).compare_err(count1,count2)=direction(count3).meanLP(count1,count2)-mean(correctposition(casetrials));
% %         direction(count3).compare_stderr(count1,count2)=std(paddlefinish(casetrials));
        
      index=index+3; 
      end
    end
end


