function [] = bar_data( healthydata,pddata )
%healthy data is a matrix with size parametersXnumberof subjects
%1. calculate mean
hcmean=mean(healthydata,1)
pdmean=mean(pddata,1)
hccount=size(healthydata)
pdcount=size(pddata)
hcerror=std(healthydata)/sqrt(hccount(1,2));
pderror=std(pddata)/sqrt(pdcount(1,2));

bardata=(vertcat(hcmean,pdmean))'
pause
errdata=(vertcat(hcerror,pderror))'
pause
figure;
bar(bardata);
hold on;
numgroups = size(bardata, 1)
numbars = size(bardata, 2)
groupwidth = min(0.8, numbars/(numbars+1.5));
for i = 1:numbars
      % Based on barweb.m by Bolu Ajiboye from MATLAB File Exchange
      x(i,:) = (1:numgroups) - groupwidth/2 + (2*i-1) * groupwidth / (2*numbars);  % Aligning error bar with individual bar
      errorbar(x(i,:), bardata(:,i), errdata(:,i), 'k', 'linestyle', 'none');
      xpd = repmat(x(i,:),[pdcount,1]); %the x axis location
      xhc = repmat(x(i,:),[hccount,1]);
      plot(xhc,healthydata(:,i),'o k','MarkerFaceColor','k');%,'MarkerSize',8,'MarkerFaceColor','k')
      plot(xpd,pddata(:,i),'o k','MarkerFaceColor','k');
end
b(1).Facecolor='k';
b(2).Facecolor=[0.5,0.5,0.5];
legend('Controls','Patients');

hold on;
end

