subsetrun=[1,2,3,4,5,6,7,8,9,10]
numbins=5;
for subco=1:1:10
    subnos=subsetrun(subco)
indexes=find(comdata(subnos).mod_table(:,2)>1.4);
%clearup
comdata(subnos).mod_table(indexes,:)=[];
leftfirst=find(comdata(subnos).mod_table(:,9)==-1,1)
balls_left=comdata(subnos).mod_table(leftfirst:end,:);
balls_right=comdata(subnos).mod_table(1:leftfirst-1,:);
%[Y,I] = sort(comdata(subnos).mod_table(leftfirst:end,2),1);
% bins based on range
[st1, st2,st3]=histcounts((balls_left(:,2)),5);%leftfirst:end
%bins of equal number of trials
%binlims=quantile(comdata(1).mod_table(:,2),numbins);
for bins=1:1:5
%ind=I((bins-1)*39+1:(bins*39)-1)
ind=find((st3==bins)&(balls_left(:,9)==-1));
mean_st(bins)=mean(balls_left(ind,2));
opt_st(bins)=mean(balls_left(ind,14));
percentcorr(bins)=100*(sum(balls_left(ind,8))/length(ind));
trials(bins)=(length(ind));
end
tabs(subnos).tab=horzcat(mean_st',percentcorr',trials');
subplot(4,3,2+subnos);title(num2str(subnos));hold on;
% % plot(mean_st,trials,'* r');hold on;
% % plot(mean_st,trials,'r');
plot(mean_st,percentcorr);hold on;
plot(mean_st,percentcorr,'o r')
plot(mean_st,percentcorr,'r')
xlim([0 1.4]);
%ylim([0 100]);
shg
clear st1 st2 st3
[st1, st2,st3]=histcounts(balls_right(:,2),5);
%clear Y I
%[Y,I] = sort(comdata(subnos).mod_table(1:(leftfirst-1),2),1);
for bins=1:1:5
ind=find((st3==bins)&(balls_right(:,9)==1));
%ind=I((bins-1)*39+1:(bins*39)-1)
mean_st2(bins)=mean(balls_right(ind,2));
percentcorr2(bins)=100*(sum(balls_right(ind,8))/length(ind));
opt_st2(bins)=mean(balls_right(ind,14));
trials2(bins)=length(ind);
end
tabs(subnos).tab2=horzcat(mean_st2',percentcorr2',trials2');
hold on
%plot(mean_st2,trials2,'* k');
%plot(mean_st2,trials2,'k');
%plot(mean_st2,opt_st2);
plot(mean_st2,percentcorr2,'o k')
plot(mean_st2,percentcorr2,'k')
xlim([0 1.4]);
%ylim([0 100]);
shg
end