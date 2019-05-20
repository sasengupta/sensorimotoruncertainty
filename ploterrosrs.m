
a=sensorydata(1).rawdata(1).peakvel(:);
for i=2:1:9
a=horzcat(a,sensorydata(i).rawdata(1).peakvel(:));
end
b=sensorydata(1).rawdata(2).peakvel(:);
for i=2:1:9
b=horzcat(b,sensorydata(i).rawdata(2).peakvel(:));
end
st=[0.200, 0.400, 0.600, 0.750, 0.950];
timplots=(repmat(st,1,8))';
figure;
hold on
mean_std=mean(a,2);
mean_std(:,2)=std(a,1,2)/sqrt(9);
mean_std(:,3)=mean(b,2);
mean_std(:,4)=std(b,1,2)/sqrt(9);
markersize=vertcat(8*ones(5,1),10*ones(5,1),12*ones(5,1),13*ones(5,1), ...
14*ones(5,1),15*ones(5,1),16*ones(5,1),17*ones(5,1));
figure;
for i=1:1:40
errorbar(timplots(i,1)+0.04,mean_std(i,1),mean_std(i,2),'Color','k','Marker','square', ...
    'MarkerSize',markersize(i,1),'MarkerFaceColor','k','MarkerEdgeColor','k');
hold on;shg;pause
end
%figure;
for i=1:1:40
errorbar(timplots(i,1),mean_std(i,3),mean_std(i,4),'Color','k','Marker','square', ...
    'MarkerSize',markersize(i,1),'MarkerFaceColor','none','MarkerEdgeColor','k');
hold on;shg;pause
end
hold on;set(gca,'FontSize',25);
ax=gca
ax.XTick=st
%ylim([0 4])
xlabel('Sensing Time (s)');
ylabel('Sensory Uncertainty (cm)');
ax.YTick=[0:1:4]
hold on;set(gca,'FontSize',25);xlim([0 1.1]);
%saveas(gcf,'velocity_ehc','svg');

saveas(gcf,'velocity_ehc','svg');