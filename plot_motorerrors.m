subjectsnum=10;
a=motordata(1).rawdata.peakvel(:);
for i=2:1:subjectsnum
a=horzcat(a,motordata(i).rawdata.peakvel(:));
end

mt=[.45 .65 .800 1 1.2];
timplots=(repmat(mt,1,8))';
figure;
hold on
mean_std=mean(a,2);
mean_std(:,2)=std(a,1,2)/sqrt(subjectsnum);
markersize=vertcat(8*ones(5,1),10*ones(5,1),12*ones(5,1),13*ones(5,1), ...
14*ones(5,1),15*ones(5,1),16*ones(5,1),17*ones(5,1));
figure;
for i=1:1:40
errorbar(timplots(i,1),mean_std(i,1),mean_std(i,2),'Color','k','Marker','>','MarkerSize',markersize(i,1),'MarkerFaceColor','none','MarkerEdgeColor','k');
hold on;shg;pause
end
hold on;set(gca,'FontSize',25);
ax=gca
ax.XTick=mt
ylim([0 4])
xlabel('Movement Time (s)');
ylabel('Motor Uncertainty (cm)');
ax.YTick=[0:1:4]
hold on;set(gca,'FontSize',25);xlim([0 1.1]);
ylim([0 2])
hold on;set(gca,'FontSize',25);xlim([0.4 1.3]);
ax.YTick=[0:.5:2]
saveas(gcf,'motorehc','svg');