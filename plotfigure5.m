for i=1:1:9
all_comdata(i,:,:)=comdata_pd(i).summ_table_com;
end
x=mean(all_comdata,1);
errorbars=std(all_comdata,1);

ampwithst_optileft.model = fitlm(x(1,1:10,4),x(1,1:10,3));
ampwithst_left.model = fitlm(x(1,1:10,4),x(1,1:10,2));
ampwithst_right.model = fitlm(x(1,11:20,4),x(1,11:20,2));
ampwithst_optiright.model = fitlm(x(1,11:20,4),x(1,11:20,3));
figure;
amp=linspace(9.5,30.5,100)
pstol=ampwithst_optileft.model.Coefficients.Estimate(1)+ampwithst_optileft.model.Coefficients.Estimate(2).*amp;
pstl=ampwithst_left.model.Coefficients.Estimate(1)+ampwithst_left.model.Coefficients.Estimate(2).*amp;
pstor=ampwithst_optiright.model.Coefficients.Estimate(1)+ampwithst_optiright.model.Coefficients.Estimate(2).*amp;
pstr=ampwithst_right.model.Coefficients.Estimate(1)+ampwithst_right.model.Coefficients.Estimate(2).*amp;
set(gca,'FontSize',25);xlim([9 30]);ylim([.5,.75]);
ylabel('Switching time (s)');
xlabel('Amplitude (cm)');
figure;
plot(amp,pstol,'LineWidth',4,'Color','k','LineStyle','--');hold on;
plot(amp,pstl,'LineWidth',2,'Color','k','LineStyle','--');hold on;
plot(amp,pstor,'LineWidth',4,'Color','k','LineStyle','-');hold on;
plot(amp,pstr,'LineWidth',2,'Color','k','LineStyle','-');hold on;
errorbar(x(1,1:10,4),x(1,1:10,2),errorbars(1,1:10,2),'s k','MarkerSize',10,'MarkerFaceColor','none','MarkerEdgeColor','k','Linewidth',3);hold on;
errorbar(x(1,11:20,4),x(1,11:20,2),errorbars(1,11:20,2),'s k','MarkerSize',10,'MarkerFaceColor','k','MarkerEdgeColor','k','Linewidth',3);hold on;

%errorbar(x_pd(1,11:20,4),x_pd(1,11:20,2),errorbars_pd(1,11:20,2),'o k','MarkerSize',10,'MarkerFaceColor','k','MarkerEdgeColor','k','Linewidth',3);hold on;
%errorbar(x(1,11:20,4),x(1,11:20,2),errorbars(1,11:20,2),'> b','MarkerSize',10,'MarkerFaceColor','b','MarkerEdgeColor','b','Linewidth',3);hold on;
set(gca,'FontSize',25);xlim([9 30]);ylim([0.4,1.2]);
shg;hold on;
set(gca,'FontSize',25);
ylabel('Switching time (s)');
xlabel('Amplitude (cm)');