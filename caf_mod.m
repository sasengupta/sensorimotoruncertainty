%code modified on 27th December 2018 to have equal number of trial sin eah
%bin. Do we split into quantiles separately for left and right startting
%balls? As of now 
subsetrun=[1,2,3,4,5,6,7,8,9,10]
numbins=4;
for subco=1:1:10
    subnos=subsetrun(subco)
indexes=find(comdata(subnos).mod_table(:,2)>1.4);
%clearup
comdata(subnos).mod_table(indexes,:)=[]
leftfirst=find(comdata(subnos).mod_table(:,9)==-1,1)
binlims=hist(comdata(subnos).mod_table(leftfirst:end,2),numbins)
%st4(length(comdata(subnos).mod_table(leftfirst:end,2)),numbins+1)=0;
for bins=1:1:(numbins)
indexes=find(comdata(subnos).mod_table(leftfirst:end,2)<=binlims(bins));
st4(indexes,bins)=1;    
end
st3=sum(st4,2);
for bins=1:1:numbins+1
%ind=I((bins-1)*39+1:(bins*39)-1)
binum=bins-1
ind=find((st3==binum)&(comdata(subnos).mod_table(leftfirst:end,9)==-1))
pause;
ind=ind+leftfirst-1;
%pause;
mean_st(bins)=mean(comdata(subnos).mod_table(ind,2));
opt_st(bins)=mean(comdata(subnos).mod_table(ind,14));
percentcorr(bins)=100*(sum(comdata(subnos).mod_table(ind,8))/length(ind));
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
clear st3 st4
binlims=quantile(comdata(subnos).mod_table(1:leftfirst-1,2),numbins);
st4(length(comdata(subnos).mod_table(1:leftfirst-1,2)),numbins+1)=0;
for bins=1:1:(numbins)
indexes=find(comdata(subnos).mod_table(1:leftfirst-1,2)<=binlims(bins));
st4(indexes,bins)=1;    
end
st3=sum(st4,2);

for bins=1:1:numbins+1
binum=bins-1;
ind=find((st3==binum)&(comdata(subnos).mod_table(1:leftfirst-1,9)==1))
pause;
%ind=I((bins-1)*39+1:(bins*39)-1)
mean_st2(bins)=mean(comdata(subnos).mod_table(ind,2));
percentcorr2(bins)=100*(sum(comdata(subnos).mod_table(ind,8))/length(ind));
opt_st2(bins)=mean(comdata(subnos).mod_table(ind,14));
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