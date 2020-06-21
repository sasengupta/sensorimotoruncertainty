function [ ] = make_regressionlines( pd_optimal,pd_empirical,hc_optimal,hc_empirical,st_pd,pd_errorbars,st_hc,hc_errorbars,figname)
%takes fit values from figure_chapter 3 and produces panels A and B

amp=linspace(9.5,30.5,100);
st_hc_opt=hc_optimal.model.Coefficients.Estimate(1)+hc_optimal.model.Coefficients.Estimate(2).*amp;
st_hc_emp=hc_empirical.model.Coefficients.Estimate(1)+hc_empirical.model.Coefficients.Estimate(2).*amp;

st_pd_opt=pd_optimal.model.Coefficients.Estimate(1)+pd_optimal.model.Coefficients.Estimate(2).*amp;
st_pd_emp=pd_empirical.model.Coefficients.Estimate(1)+pd_empirical.model.Coefficients.Estimate(2).*amp;
%figureA

plot(amp,st_pd_opt,'LineWidth',4,'Color','k');hold on;
plot(amp,st_hc_opt,'LineWidth',4,'Color',[0.7, 0.7, 0.7]);hold on;

plot(amp,st_pd_emp,'LineWidth',2,'Color','k','LineStyle','-.');hold on;
errorbar(st_pd(1,:,4),st_pd(1,:,2),pd_errorbars(1,:,2),'s k', ...
         'MarkerSize',10,'MarkerFaceColor','k','MarkerEdgeColor','k','Linewidth',3);hold on;

plot(amp,st_hc_emp,'LineWidth',2,'Color',[0.7, 0.7, 0.7],'LineStyle','-.');hold on;     
errorbar(st_hc(1,:,4),st_hc(1,:,2),hc_errorbars(1,:,2),'Marker','>','Color', [0.7,0.7,0.7],'linestyle','none', ...
        'MarkerSize',10,'MarkerFaceColor',[0.7, 0.7, 0.7],'MarkerEdgeColor',[0.7, 0.7, 0.7],'Linewidth',3);hold on;



shg;hold on;
xlim([9,31])
ylim([0.4,1.2])
set(gca,'FontSize',25);
ylabel('Switching time (s)');
xlabel('Amplitude (cm)');
saveas(gca,strcat(figname,'.svg'));
end

