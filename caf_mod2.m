subjectnums=[1,2,3,4,5,6,8,9,10];%[1:1:10]
numbins=7;
for sub=1:1:9
    run runal_init_pd
    subnos=subjectnums(sub);
    indexes=find(comdata(subnos).mod_table(:,2)>1.4);
    %clearup
    comdata(subnos).mod_table(indexes,:)=[]
    leftfirst=find(comdata(subnos).mod_table(:,9)==-1,1)
    %pause;
    balls_left=comdata(subnos).mod_table(leftfirst:end,:)
    quantile_left=quantile(balls_left(:,2),numbins);
    balls_right=comdata(subnos).mod_table(1:leftfirst-1,:);
    quantile_right=quantile(balls_right(:,2),numbins)
    length(balls_left)+length(balls_right)
    %pause;
%left
quantile_count(length(balls_left(:,2)),numbins+1)=0;
for bins=1:1:(numbins)
indexes=find((balls_left(:,2)<=quantile_left(bins)));
max(indexes)
pause
quantile_count(indexes,bins)=1;    
end
quantile_count2=sum(quantile_count,2);
%pause;
for bins=1:1:numbins+1
binum=bins-1
ind=find((quantile_count2==binum));
length(ind)
%pause;
mean_left(bins)=mean(balls_left(ind,2));
opt_left(bins)=mean(balls_left(ind,14));
percentcorr_left(bins)=100*(sum(balls_left(ind,8))/length(ind));
trials_left(bins)=(length(ind));
end
                subplot(4,3,2+subnos);title(num2str(subnos));hold on
               plot(mean_left,percentcorr_left,'b');hold on;
                 plot(mean_left,percentcorr_left,'o b')
                 slope(subnos,1)= (percentcorr_left(2)-percentcorr_left(1))/(mean_left(2)-mean_left(1));
                    %% plot(mean_left,trials_left,'b');hold on;
                %%plot(mean_left,trials_left,'o b')
                xlim([0 1.4]);
                %ylim([0 100]);

quantile_count=[];quantile_count2=[];
%_______________________________________________________________
for bins=1:1:(numbins)
indexes=find((balls_right(:,2)<=quantile_right(bins)));
quantile_count(indexes,bins)=1;    
end
quantile_count2=sum(quantile_count,2);
unique(quantile_count2)
%pause;
for bins=1:1:numbins+1
binum=bins-1
ind=find((quantile_count2==binum))
length(ind)
%pause;
mean_right(bins)=mean(balls_right(ind,2));
opt_right(bins)=mean(balls_right(ind,14));
percentcorr_right(bins)=100*(sum(balls_right(ind,8))/length(ind));
trials_right(bins)=(length(ind));
end

        plot(mean_right,percentcorr_right,'o r')
        plot(mean_right,percentcorr_right,'r')
        slope(subnos,2)= (percentcorr_right(2)-percentcorr_right(1))/(mean_right(2)-mean_right(1));
         %%plot(mean_right,trials_right,'r');hold on;
           %%     plot(mean_right,trials_right,'o r')
        xlim([0 1.4]);
        %ylim([0 100]);
        shg
clearvars -except comdata sub subjectnums numbins slope
end
