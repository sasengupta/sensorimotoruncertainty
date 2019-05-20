function [ rsq ] = calculate_goodnessoffit_mv( opt_mv,errorsummary,mod_datable )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
v=unique(abs(mod_datable(:,6)))
t=unique(mod_datable(:,2))
raw_std=errorsummary(1).stderror';

exp_con(:,1)=repmat(v,5,1);
exp_con(:,2)=[t(1).*ones(size(v));t(2).*ones(size(v));t(3).*ones(size(v));t(4).*ones(size(v));t(5).*ones(size(v))];
% disp(exp_con)
% pause;
size(exp_con)
size(raw_std)
tabulardat=horzcat(exp_con,raw_std(:));
tabulardat(any(isnan(tabulardat),2),:)=[];
figure;
plot(exp_con(:,1),raw_std(:),'o r');hold on;
figure;
plot(exp_con(:,2),raw_std(:),'o r');hold on;
%pause;
predictedval_r=2*tabulardat(:,1)./2.^((tabulardat(:,2)-opt_mv(1))/opt_mv(2));
rsq_mv=corrcoef(predictedval_r,tabulardat(:,3));
size(tabulardat)
%pause;
figure;

plot(predictedval_r(:),tabulardat(:,3),'o r'); hold on

rsq = [rsq_mv(1,2)]
end

