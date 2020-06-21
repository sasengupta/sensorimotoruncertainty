function [ fitval,summ_table_com] = com_fits(tablecom,filename)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
%datatable=horzcat(ballspeed,st,error, ...
%                   paddlefinish,indicatedposition,correctposition,ballfinishposition,hitrate,dir, ...
%                   peak_vel,vel_at_end,deliberationtime, optempvar',predicted_st',valleyangle'                                                                              );
error=tablecom(:,3);
vel=abs(tablecom(:,1));
st=tablecom(:,2);
opt_st=tablecom(:,14);
dir=tablecom(:,9);
dir_change=find(tablecom(:,9)==-1,1);
correctposition=tablecom(:,6);
uncertainty=tablecom(:,13);
valleyangle=tablecom(:,15);

[ar, br]=hist(vel,10);
%v=linspace(1,15,10);
for bins=1:1:10
ind=find((vel>=br(bins)-.75) & (vel<br(bins)+.75)&(dir==-1) & (st<=1.4));
std_right(bins,1)=std(st(ind,1));
mean_right(bins,1)=mean(st(ind,1));
spread_endpoint_r(bins,1)=std(error(ind,1));
mean_ampr(bins,1)=mean(correctposition(ind,1));
mean_velr(bins,1)=mean(vel(ind,1));
peak_velr(bins,1)=mean(tablecom(ind,10));
peak_velatendr(bins,1)=mean(tablecom(ind,11));
std_velr(bins,1)=std(tablecom(ind,10));
std_velatendr(bins,1)=std(tablecom(ind,11));
optimal_std_right(bins,1)=std(opt_st(ind,1));
optimal_mean_right(bins,1)=mean(opt_st(ind,1));
uncertaintyr(bins,1)=mean(uncertainty(ind,1));
valley_angle_right(bins,1)=(pi+atan(mean(valleyangle(ind,1))))*180/pi;
totaltrial_right(bins,1)=length(ind);
size(ind)

ind=find((vel>=br(bins)-.75) & (vel<br(bins)+.75)&(dir==1) & (st<=1.4));
std_left(bins,1)=std(st(ind,1));
mean_left(bins,1)=mean(st(ind,1));
spread_endpoint_l(bins,1)=std(error(ind,1));
mean_ampl(bins,1)=mean(correctposition(ind,1));
mean_vell(bins,1)=mean(vel(ind,1));
peak_vell(bins,1)=mean(tablecom(ind,10));
peak_velatendl(bins,1)=mean(tablecom(ind,11));
std_vell(bins,1)=std(tablecom(ind,10));
std_velatendl(bins,1)=std(tablecom(ind,11));
optimal_std_left(bins,1)=std(opt_st(ind,1));
optimal_mean_left(bins,1)=mean(opt_st(ind,1));
uncertaintyl(bins,1)=mean(uncertainty(ind,1));
valley_angle_left(bins,1)=(pi+atan(mean(valleyangle(ind,1))))*180/pi;
totaltrial_left(bins,1)=length(ind);
size(ind)
summ_table_com=vertcat(horzcat(std_left,mean_left,optimal_mean_left,mean_ampl,mean_vell,peak_vell,peak_velatendl,std_vell,std_velatendl,totaltrial_left), ...
                       horzcat(std_right,mean_right,optimal_mean_right,mean_ampr,mean_velr,peak_velr,peak_velatendr,std_velr,std_velatendr,totaltrial_right));
end
fitval.ampwithst_right.model = fitlm(correctposition(1:dir_change-1,1),st(1:dir_change-1,1));
fitval.ampwithst_left.model = fitlm(correctposition(dir_change:end,1),st(dir_change:end,1));
fitval.ampwithst_optiright.model = fitlm(correctposition(1:dir_change-1,1),opt_st(1:dir_change-1,1));
fitval.ampwithst_optileft.model = fitlm(correctposition(dir_change:end,1),opt_st(dir_change:end,1));


fitval.corr_uncertaintyleft=corrcoef(uncertaintyl,std_left);
fitval.corr_uncertaintyright=corrcoef(uncertaintyr,std_right);
fitval.corr_uncertaintycom=corrcoef(vertcat(uncertaintyl',uncertaintyr'),vertcat(std_left',std_right'));

fitval.corr_endpoint_uncertaintyleft=corrcoef(uncertaintyl,spread_endpoint_l);
fitval.corr_endpoint_uncertaintyright=corrcoef(uncertaintyr,spread_endpoint_l);
fitval.corr_endpoint_uncertaintycom=corrcoef(vertcat(uncertaintyl',uncertaintyr'),vertcat(spread_endpoint_l',spread_endpoint_l'));

fitval.corr_valleyleft=corrcoef(valley_angle_left,std_left);
fitval.corr_valleyright=corrcoef(valley_angle_right,std_right);
fitval.corr_valleycombined=corrcoef(vertcat(valley_angle_left',valley_angle_right'),vertcat(std_left',std_right'));
size(horzcat(vertcat(uncertaintyl',uncertaintyr'),vertcat(valley_angle_left',valley_angle_right')))
size(horzcat(std_left',std_right'))
%pause;
fitval.com=fitlm((horzcat(vertcat(uncertaintyl',uncertaintyr'),vertcat(valley_angle_left',valley_angle_right')))',(horzcat(std_left',std_right'))');
fitval.com_uncertainty=fitlm((vertcat(uncertaintyl,uncertaintyr)),(vertcat(std_left,std_right)));
fitval.com_valleyangle=fitlm((vertcat(valley_angle_left,valley_angle_right)),(vertcat(std_left,std_right))');
% extract data
csvdata=horzcat(vertcat(uncertaintyl,uncertaintyr),vertcat(valley_angle_left,valley_angle_right),vertcat(std_left,std_right));
%csvdata=vertcat({'uncertainty','valleyangle','std'},csvdata);
csvwrite(filename,csvdata)
end

