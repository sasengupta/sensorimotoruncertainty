function [] = make_figure(subno, mod_table,opt_sv,opt_mv)
%draws the figures with the uncertainty color map with the empirical
%switching times, called from runal
st=linspace(0,1.4,1000);
amp=linspace(9.6,30.5,1000);
tix=[0.0 0.5 1.0 1.4];
dir_change=find(mod_table(:,9)==-1,1);
for i_amp=1:1:length(amp)
        modelvar_left(i_amp,:)=(opt_sv(1)*((st.^(opt_sv(2)))).*((30.5-amp(i_amp))./1.4).^(opt_sv(3))).^2 + ...
                                 (amp(i_amp).*2.^(1-(((1.4-st)-opt_mv(1))/opt_mv(2)))).^2; 
        err_modelvar_left(i_amp,:)=sqrt(modelvar_left(i_amp,:));
        optmodelvar(i_amp)=min(sqrt(modelvar_left(i_amp,:)));
        [modelmin_t(i_amp),modelind(i_amp)]=min(sqrt(modelvar_left(i_amp,:)));
end
fit_parameters=fitline(mod_table(1:dir_change-1,6),mod_table(1:dir_change-1,2))
%[fit_parameters(1,1)+fit_parameters(2,1)*mod_table(1:dir_change-1,6),mod_table(1:dir_change-1,6)]
%pause;
        figure;
        contourf(st,amp,log10(err_modelvar_left),'LineStyle','none');
        hold on;colorbar;cbh = colorbar;cbh.Ticks=round((10.^(-1:.5:1)),2);
        correct=find(mod_table(1:dir_change-1,8)==1);wrong=find(mod_table(1:dir_change-1,8)==0);
        plot(mod_table(correct,2),mod_table(correct,6),'. k','MarkerSize',20);%,'MarkerFaceColor','none');
        plot(mod_table(wrong,2),mod_table(wrong,6),'LineStyle','none','Marker','.','MarkerFaceColor','r','MarkerEdgeColor','r','MarkerSize',20)%[0.5 0.5 0.5]
%'LineStyle','none','Marker','square','MarkerEdgeColor','k','MarkerFaceColor','none','MarkerSize',8);
        plot(st(modelind),amp,'.w','MarkerSize',20); shg;set(gca,'FontSize',25);
        caxis([-1 1.5]);%vline(.15,'k');vline(1.2,'k')
        axis([0,1.4,9.6,30.5]);ax=gca;ax.XTick =[0.0 0.5 1.0 1.4];
        tix=get(gca,'xtick')';
        set(gca,'xticklabel',num2str(tix,'%.1f'))
        %xlabel('Switching Time (s)');ylabel('Amplitude (cm)');
        set(gca,'FontSize',30);%title(num2str(sub));
        plot(fit_parameters(1,1)+fit_parameters(2,1)*mod_table(1:dir_change-1,6),mod_table(1:dir_change-1,6), ...
               'LineStyle','--','Color','k','Linewidth',4);
        saveas(gcf,strcat('sub ',num2str(subno),'left',num2str(1)),'png');
        shg;
        %%pause;
for i_amp=1:1:length(amp)
        modelvar_right(i_amp,:)=(opt_sv(1)*((st.^(opt_sv(2)))).*((amp(i_amp)-9.5)./1.4).^(opt_sv(3))).^2 + (amp(i_amp).*2.^(1-(((1.4-st)-opt_mv(1))/opt_mv(2)))).^2; 
        err_modelvar_right(i_amp,:)=sqrt(modelvar_right(i_amp,:));
        optmodelvar(i_amp)=min(sqrt(modelvar_right(i_amp,:)));
        [modelmin_t(i_amp),modelind(i_amp)]=min(sqrt(modelvar_right(i_amp,:)));
end
 fit_parameters=fitline(mod_table(dir_change:end,6),mod_table(dir_change:end,2));
 %pause
        figure;
        contourf(st,amp,log10(err_modelvar_right),'LineStyle','none');
        hold on;colorbar;cbh = colorbar;cbh.Ticks=round((10.^(-1:.5:1)),2);
        correct=find(mod_table(dir_change:end,8)==1);wrong=find(mod_table(dir_change:end,8)==0);
        plot(mod_table(dir_change+correct-1,2),mod_table(dir_change+correct-1,6),'. k','MarkerSize',20);%,'MarkerFaceColor','none');
        plot(mod_table(dir_change+wrong-1,2),mod_table(dir_change+wrong-1,6),'LineStyle','none','Marker','.','MarkerFaceColor', 'r','MarkerEdgeColor','r','MarkerSize',20)
%'LineStyle','none','Marker','square','MarkerEdgeColor','k','MarkerFaceColor','none','MarkerSize',8);
        plot(st(modelind),amp,'.w','MarkerSize',20); shg;set(gca,'FontSize',25);
        %plot(mod_table(401:800,2),mod_table(401:800,6),'. k','MarkerSize',30);hold on;
        plot(fit_parameters(1,1)+fit_parameters(2,1)*mod_table(dir_change:end,6), mod_table(dir_change:end,6), ...
               'LineStyle','--','Color','k','Linewidth',4);
        axis([0,1.4,9.6,30.5]);ax=gca;ax.XTick =[0.0 0.5 1.0 1.4];
        caxis([-1 1.5]);%vline(.15,'k');vline(1.2,'k')
        hold on;
        tix=get(gca,'xtick')';
        set(gca,'xticklabel',num2str(tix,'%.1f'))
        set(gca,'FontSize',30);
        saveas(gcf,strcat('sub ',num2str(subno),'right',num2str(1)),'png');
end

