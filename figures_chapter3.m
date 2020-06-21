%makes figures for chapter 3
% needs comdata_pd and comdata_ehc and fitvalues for the regression between
% amp and st and optimal st
load('comdata_pd.mat')
comdata_pd=comdata;
load('comdata_ehc.mat')
comdata_ehc=comdata;
% comdata has both optimal and empircal st
%process ehc data
for i=1:1:10
all_comdata(i,:,:)=comdata_ehc(i).summ_table_com;
end
x_hc=mean(all_comdata,1);
errorbars_hc=(1/sqrt(10))*std(all_comdata,1);


%process pd data
comdata_pd(7)=[];  % remove subject 7 from analysis
for i=1:1:9
all_comdatapd(i,:,:)=comdata_pd(i).summ_table_com;
end
x_pd=mean(all_comdatapd,1);
errorbars_pd=(1/3)*std(all_comdatapd,1);


amp=linspace(9.5,30.5,100);
% regenerate fit values for binwise average st values for left
ampwithst_optileftpd.model = fitlm(x_pd(1,1:10,4),x_pd(1,1:10,3));
ampwithst_leftpd.model = fitlm(x_pd(1,1:10,4),x_pd(1,1:10,2));
ampwithst_left.model = fitlm(x_hc(1,1:10,4),x_hc(1,1:10,2));
ampwithst_optileft.model = fitlm(x_hc(1,1:10,4),x_hc(1,1:10,3));
% regenerate fit values for binwise average st values for right
ampwithst_optirightpd.model = fitlm(x_pd(1,11:20,4),x_pd(1,11:20,3));
ampwithst_rightpd.model = fitlm(x_pd(1,11:20,4),x_pd(1,11:20,2));
ampwithst_right.model = fitlm(x_hc(1,11:20,4),x_hc(1,11:20,2));
ampwithst_optiright.model = fitlm(x_hc(1,11:20,4),x_hc(1,11:20,3));

figure;
make_regressionlines(ampwithst_optileftpd,ampwithst_leftpd,ampwithst_optileft,ampwithst_left, ...
                     x_pd(1,1:10,:),errorbars_pd(1,1:10,:),x_hc(1,1:10,:),errorbars_hc(1,1:10,:),'panela');
figure;
make_regressionlines(ampwithst_optirightpd,ampwithst_rightpd,ampwithst_optiright,ampwithst_right, ...
                      x_pd(1,11:20,:),errorbars_pd(1,11:20,:),x_hc(1,11:20,:),errorbars_hc(1,11:20,:),'paneld')



