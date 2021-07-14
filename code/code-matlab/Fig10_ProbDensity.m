
clc; clear;

Path_LandCover = '../input/';
Path_TAVG12IND = '../output/17_TAVG12IND/';
Path_Figure  = '../figure/';

    CrseSPR = geotiffread([Path_TAVG12IND,'Cnn12RMSE.SPR.2001.2015.tif']);
    CrseSUM = geotiffread([Path_TAVG12IND,'Cnn12RMSE.SUM.2001.2015.tif']);
    CrseAUT = geotiffread([Path_TAVG12IND,'Cnn12RMSE.AUT.2001.2015.tif']);
    CrseWIN = geotiffread([Path_TAVG12IND,'Cnn12RMSE.WIN.2001.2015.tif']);
    
    BrseSPR = geotiffread([Path_TAVG12IND,'Bio12RMSE.SPR.2001.2015.tif']);
    BrseWIN = geotiffread([Path_TAVG12IND,'Bio12RMSE.WIN.2001.2015.tif']);
  

Temp = reshape(CrseSPR,[],1); Nonan = ~isnan(Temp); 
SPRC=Temp(Nonan);
Temp = reshape(CrseSUM,[],1); Nonan = ~isnan(Temp); 
SUMC=Temp(Nonan);
Temp = reshape(CrseAUT,[],1); Nonan = ~isnan(Temp); 
AUTC=Temp(Nonan);
Temp = reshape(CrseWIN,[],1); Nonan = ~isnan(Temp); 
WINC=Temp(Nonan);

Temp = reshape(BrseSPR,[],1); Nonan = ~isnan(Temp); 
SPRB=Temp(Nonan);
Temp = reshape(BrseWIN,[],1); Nonan = ~isnan(Temp); 
WINB=Temp(Nonan);


   %% Probability figure
Fig=figure;
set(gcf,'position',[100 100 1000 600],'defaultAxesFontSize',24);  
set(gca,'visible', 'off');

set(gca,'xtick',0:10:50,'fontsize',32,'FontWeight','bold','Fontname','Times New Roman');   
set(gca,'ylim',[0 0.15],'ytick',0:0.05:0.15,'fontsize',32,'FontWeight','bold','Fontname','Times New Roman');   

pdCSPR= fitdist(SPRC,'poisson');
pdCSUM= fitdist(SUMC,'poisson');
pdCAUT= fitdist(AUTC,'poisson');
pdCWIN= fitdist(WINC,'poisson');

x = 1:1:40;
yC1 =pdf(pdCSPR,x);
yC2 =pdf(pdCSUM,x);
yC3 =pdf(pdCAUT,x);
yC4 =pdf(pdCWIN,x);

a=plot(x,yC1,'color',[0.180 0.545 0.341],'Linewidth',4); hold on;
b=plot(x,yC2,'color',[1 0.796 0.439],'Linewidth',4);
c=plot(x,yC3,'color',[0.745 0.153 0.208],'Linewidth',4);
d=plot(x,yC4,'color',[0.0196 0.0784 0.6784],'Linewidth',4);

xlabel('RMSE (days)','FontWeight','bold','Fontname','Times New Roman','Fontsize',32,'Color','k');
ylabel('Probability density','FontWeight','bold','Fontname','Times New Roman','Fontsize',32,'Color','k');
text('String',['a) 1D-CNNR'],...
    'Units','Normalized','Position',[0.04 0.90],'FontWeight','bold','Fontname','Times New Roman','Fontsize',32); 

HLegend=legend([a,b,c,d],{'green-up','maturation','senescence','dormancy'});
set(HLegend,'Units','Pixels','Position',[200 350 1100 200],'FontWeight','bold','Fontname','Times New Roman','Box','off','EdgeColor','w','fontsize',26);


pause(5); set(gcf,'position',[100 100 1000 600],'defaultAxesFontSize',12);  

print(Fig,'-dtiff','-r300',[Path_Figure,'CNNRpd','.tif']);close(Fig);


   %% Probability figure
Fig=figure;
set(gcf,'position',[100 100 1000 600],'defaultAxesFontSize',24);  
set(gca, 'visible', 'off');

set(gca,'xtick',0:10:80,'fontsize',32,'FontWeight','bold','Fontname','Times New Roman');   
set(gca,'ylim',[0 0.10],'ytick',0:0.02:0.10,'fontsize',32,'FontWeight','bold','Fontname','Times New Roman');   

pdBSPR= fitdist(SPRB,'poisson');
pdBWIN= fitdist(WINB,'poisson');

x = 1:1:80;
yB1 =pdf(pdBSPR,x);
yB2 =pdf(pdBWIN,x);

a=plot(x,yB1,'color',[0.180 0.545 0.341],'Linewidth',4); hold on;
b=plot(x,yB2,'color',[0.0196 0.0784 0.6784],'Linewidth',4);

xlabel('RMSE (days)','FontWeight','bold','Fontname','Times New Roman','Fontsize',32,'Color','k');
ylabel('Probability density','FontWeight','bold','Fontname','Times New Roman','Fontsize',32,'Color','k');
text('String',['b) Biome-BGC'],...
    'Units','Normalized','Position',[0.04 0.90],'FontWeight','bold','Fontname','Times New Roman','Fontsize',32); 

pause(5); set(gcf,'position',[100 100 1000 600],'defaultAxesFontSize',12);  

print(Fig,'-dtiff','-r300',[Path_Figure,'BBGCpd','.tif']);close(Fig);

%% Combine

Fig1=imread([Path_Figure,'CNNRpd.tif']);
Fig2=imread([Path_Figure,'BBGCpd.tif']);

Fig=cat(1,cat(2,Fig1),cat(2,Fig2));
Fig=imresize(Fig,2244/size(Fig,2));

imwrite(Fig,[Path_Figure,'ProbDensity.tif'],'Compression','LZW','Resolution',300);

delete([Path_Figure,'*pd','.tif']);

