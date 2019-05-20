function [ rsq ] = calculate_goodnessoffit( opt_sv,opt_svl,opt_svr,errorsummary,mod_datable )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
v=unique(abs(mod_datable(:,1)))
t=unique(mod_datable(:,2))
right=errorsummary(1).stderror';
left=errorsummary(2).stderror';
com=errorsummary(3).stderror';
exp_con(:,1)=repmat(v,5,1);
exp_con(:,2)=[t(1).*ones(size(v));t(2).*ones(size(v));t(3).*ones(size(v));t(4).*ones(size(v));t(5).*ones(size(v))];
% disp(exp_con)
% pause;
% size(exp_con)
figure;
plot(exp_con(:,1),left(:),'o b');hold on;
plot(exp_con(:,1),right(:),'o r');hold on;
figure;
plot(exp_con(:,2),left(:),'o b');hold on;
plot(exp_con(:,2),right(:),'o r');hold on;
%pause;
predictedval_l=opt_svl(1).*(exp_con(:,2).^opt_svl(2)).*(exp_con(:,1).^opt_svl(3));
predictedval_r=opt_svr(1).*(exp_con(:,2).^opt_svr(2)).*(exp_con(:,1).^opt_svr(3));
predictedval=opt_sv(1).*(exp_con(:,2).^opt_sv(2)).*(exp_con(:,1).^opt_sv(3));
%obs_com=sqrt(left(:).^2 +right(:).^2)
rsq_l=corrcoef(predictedval_l,left(:))
rsq_r=corrcoef(predictedval_r,right(:))
rsq_com=corrcoef(predictedval,com(:))
figure;
plot(predictedval_l(:),left(:),'o b'); hold on
%pause;
plot(predictedval_r(:),right(:),'o r'); hold on
plot(predictedval(:),com(:),'o k'); hold on
rsq = [rsq_l(1,2).^2,rsq_r(1,2).^2,rsq_com(1,2).^2]
end

