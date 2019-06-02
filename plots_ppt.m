%make figures:
%3d matrix
for i=1:1:10
all_comdata(i,:,:)=comdata_ehc(i).summ_table_com;
end
x=mean(all_comdata,1);
errorbars=std(all_comdata,1);
for i=1:1:10
all_comdatapd(i,:,:)=comdata_pd(i).summ_table_com;
end
x_pd=mean(all_comdatapd,1);
errorbars_pd=std(all_comdatapd,1);
%plot(x,y,errors)
figure;errorbar(x(1,1:10,5),x(1,1:10,1),errorbars(1,1:10,1),'> b','MarkerSize',10,'MarkerFaceColor','b','MarkerEdgeColor','b');hold on;shg;pause;
%errorbar(x(1,11:20,4),x(1,11:20,7),errorbars(1,11:20,7),'. r','MarkerSize',30,'MarkerFaceColor','r','MarkerEdgeColor','r');shg;pause;
hold on;set(gca,'FontSize',25);
hold on;
errorbar(x_pd(1,1:10,5),x_pd(1,1:10,1),errorbars_pd(1,1:10,1),'o k','MarkerSize',10,'MarkerFaceColor','k','MarkerEdgeColor','k');shg;pause;
%errorbar(x_pd(1,11:20,4),x_pd(1,11:20,7),errorbars_pd(1,11:20,7),'< r','MarkerSize',10,'MarkerFaceColor','r','MarkerEdgeColor','r');shg;pause;
hold on;set(gca,'FontSize',25);


figure;errorbar(x(1,1:10,4),x(1,1:10,2),errorbars(1,1:10,2),'. k','MarkerSize',30,'MarkerFaceColor','k','MarkerEdgeColor','k');hold on;
hold on;set(gca,'FontSize',25);xlim([9 30]);ylim([.5,.75]);
ylabel('Variability in switching time (s)');
xlabel('Amplitude (cm)');
shg;pause;
errorbar(x(1,11:20,4),x(1,11:20,2),errorbars(1,11:20,2),'. r','MarkerSize',30,'MarkerFaceColor','r','MarkerEdgeColor','r');shg;pause;
hold on;set(gca,'FontSize',25);
hold on;
%legend('HC/ball starts from the left','HC/ball starts from right')
saveas(gcf,'st11','svg');
errorbar(x_pd(1,1:10,4),x_pd(1,1:10,2),errorbars_pd(1,1:10,2),'< k','MarkerSize',10,'MarkerFaceColor','k','MarkerEdgeColor','k');shg;pause;
errorbar(x_pd(1,11:20,4),x_pd(1,11:20,2),errorbars_pd(1,11:20,2),'< r','MarkerSize',10,'MarkerFaceColor','r','MarkerEdgeColor','r');shg;pause;
hold on;set(gca,'FontSize',25);
%legend('HC/ball starts from the left','HC/ball starts from right','PD/ball starts from the left','PD/ball starts from right')
saveas(gcf,'st22','svg');

figure;
errorbar(x_pd(1,1:10,4),x_pd(1,1:10,2),errorbars(1,1:10,2),'o k','MarkerSize',10,'MarkerFaceColor','k','MarkerEdgeColor','k');hold on;
errorbar(x(1,1:10,4),x(1,1:10,2),errorbars_pd(1,11:20,2),'> b','MarkerSize',10,'MarkerFaceColor','b','MarkerEdgeColor','b');shg;pause;
hold on;set(gca,'FontSize',25);
%legend('HC/ball starts from the left','HC/ball starts from right','PD/ball starts from the left','PD/ball starts from right')
saveas(gcf,'cominset','svg');

hold on;set(gca,'FontSize',25);xlim([9 30]);ylim([.53,.72]);
ylabel('Switching time (s)');
xlabel('Amplitude (cm)');
shg;pause;
errorbar(x(1,11:20,4),x(1,11:20,2),errorbars(1,11:20,2),'. r','MarkerSize',30,'MarkerFaceColor','r','MarkerEdgeColor','r');shg;pause;
hold on;set(gca,'FontSize',25);
hold on;
errorbar(x(1,1:10,4),x(1,1:10,3),errorbars(1,1:10,3),'.','MarkerSize',30,'MarkerFaceColor',[0.5 0.5 0.5],'MarkerEdgeColor',[0.5 0.5 0.5]);hold on;
hold on;set(gca,'FontSize',25);xlim([9 30]);ylim([.5,.75]);
ylabel('Switching time (s)');
xlabel('Amplitude (cm)');
shg;pause;
errorbar(x(1,11:20,4),x(1,11:20,3),errorbars(1,11:20,3),'. r','MarkerSize',30,'MarkerFaceColor','m','MarkerEdgeColor','m');shg;pause;
hold on;set(gca,'FontSize',25);
hold on;
%legend('HC/ball starts from the left','HC/ball starts from right')
saveas(gcf,'pt11','svg');
errorbar(x_pd(1,1:10,4),x_pd(1,1:10,3),errorbars_pd(1,1:10,3),'< k','MarkerSize',10,'MarkerFaceColor',[0.5 0.5 0.5],'MarkerEdgeColor',[0.5 0.5 0.5]);shg;pause;
errorbar(x_pd(1,11:20,4),x_pd(1,11:20,3),errorbars_pd(1,11:20,3),'< ','MarkerSize',10,'MarkerFaceColor','m','MarkerEdgeColor','m');shg;pause;
hold on;set(gca,'FontSize',25);
%legend('HC/ball starts from the left','HC/ball starts from right','PD/ball starts from the left','PD/ball starts from right')
saveas(gcf,'pt22','svg');




ampwithst_optileftpd.model = fitlm(x_pd(1,1:10,4),x_pd(1,1:10,3));
ampwithst_leftpd.model = fitlm(x_pd(1,1:10,4),x_pd(1,1:10,2));
ampwithst_left.model = fitlm(x(1,1:10,4),x(1,1:10,2));
ampwithst_optileft.model = fitlm(x(1,1:10,4),x(1,1:10,3));
figure;
amp=linspace(9.5,30.5,100)
pstol=ampwithst_optileft.model.Coefficients.Estimate(1)+ampwithst_optileft.model.Coefficients.Estimate(2).*amp;
pstolpd=ampwithst_optileftpd.model.Coefficients.Estimate(1)+ampwithst_optileftpd.model.Coefficients.Estimate(2).*amp;
pstl=ampwithst_left.model.Coefficients.Estimate(1)+ampwithst_left.model.Coefficients.Estimate(2).*amp;
pstlpd=ampwithst_leftpd.model.Coefficients.Estimate(1)+ampwithst_leftpd.model.Coefficients.Estimate(2).*amp;
set(gca,'FontSize',25);xlim([9 30]);ylim([.5,.75]);
ylabel('Switching time (s)');
xlabel('Amplitude (cm)');
figure;
plot(amp,pstlpd,'LineWidth',2,'Color','k','LineStyle','-.');hold on;
plot(amp,pstl,'LineWidth',2,'Color','b','LineStyle','-.');hold on;
plot(amp,pstolpd,'LineWidth',3,'Color','k');hold on;
plot(amp,pstol,'LineWidth',3,'Color','b');hold on;
errorbar(x_pd(1,1:10,4),x_pd(1,1:10,2),errorbars_pd(1,1:10,2),'o k','MarkerSize',10,'MarkerFaceColor','k','MarkerEdgeColor','k','Linewidth',3);hold on;
errorbar(x(1,1:10,4),x(1,1:10,2),errorbars(1,1:10,2),'> b','MarkerSize',10,'MarkerFaceColor','b','MarkerEdgeColor','b','Linewidth',3);hold on;

errorbar(x_pd(1,11:20,4),x_pd(1,11:20,2),errorbars_pd(1,11:20,2),'o k','MarkerSize',10,'MarkerFaceColor','k','MarkerEdgeColor','k','Linewidth',3);hold on;
errorbar(x(1,11:20,4),x(1,11:20,2),errorbars(1,11:20,2),'> b','MarkerSize',10,'MarkerFaceColor','b','MarkerEdgeColor','b','Linewidth',3);hold on;

shg;hold on;
set(gca,'FontSize',25);
ylabel('Switching time (s)');
xlabel('Amplitude (cm)');























