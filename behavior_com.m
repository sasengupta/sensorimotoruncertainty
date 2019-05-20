function [ output_args ] = behavior_com( table_com )

%undotable
%---------------------------------------------------------

%---------------------------------------------------------
%make bins
[ar, br]=hist(abs(datar.Sensingvelamp(:,1)),10);
for bins=1:1:10
%find trials in bins
ind=find((abs(datar.Sensingvelamp(:,1))>=br(bins)-.75)&((abs(datar.Sensingvelamp(:,1))<br(bins)+.75))&datar.SensingDuration<=1.4);
%calc std on st in bin
std_right(bins)=std(datar.SensingDuration(ind));
%calc mean st
mean_right(bins)=mean(datar.SensingDuration(ind));
mean_ampr(bins)=mean(datar.CorrectPosition(ind));
mean_velr(bins)=mean(datar.Sensingvelamp(ind));
optimal_std_right(bins)=std(datar.optimal_SensingDuration(ind));
optimal_mean_right(bins)=mean(datar.optimal_SensingDuration(ind));
pcatchr(bins)=mean(datar.Maxtcatchprob(ind));
totaltrial_right(bins)=length(ind);
size(ind);
end



%mean error
%std on position
%correct hit


end

