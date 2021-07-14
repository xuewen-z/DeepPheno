
   clear ; clc;
   addpath(genpath('./'));
   Path_Figure  = '../figure/';
   Path_GlobAnoma = '../output/19_GlobAnoma/'; 
   load ([Path_GlobAnoma, 'GlobAnomaly.mat']);
   
%%  plot
Fig=figure;set(gcf,'position',[150 150 830 500],'defaultAxesFontSize',20);
set(gca,'Units','Pixels','Position',[100 60 700 420]);box on;hold on;
x=(2001:2015);

H1=shadedErrorBar( x,OSPRmean,OSPRstd,'lineprops',{'-r','Color',[0.133 0.133 0.133],'LineWidth',4},'transparent',1);
H2=shadedErrorBar( x,CSPRmean,CSPRstd,'lineprops',{'-r','Color',[0.2  0.2  0.976],'LineWidth',4},'transparent',1);
H3=shadedErrorBar( x,BSPRmean, BSPRstd,'lineprops',{'-r','Color',[0.11 0.52 0.11],'LineWidth',4},'transparent',1);

set(gca,'xlim',[2001 2015],'ylim',[-40 40],'xtick',2001:4:2015,'Fontsize',22,'ytick',-30:10:40,'FontWeight','bold','Fontname','Times New Roman','Fontsize',22); 

text('String',['a) green-up'],'Units','Normalized','Position',[0.04 0.90],'FontWeight','bold','Fontname','Times New Roman','Fontsize',32); 
ylabel('anomaly (days)','FontWeight','bold','Fontname','Times New Roman','FontSize',32);
 

Hlegend=legend([H1.mainLine,H2.mainLine,H3.mainLine],{'MODIS','1D-CNNR','Biome-BGC'}); legend boxoff;
set(Hlegend,'Units','Pixels','Position',[200 350 930 120],'FontWeight','bold','Fontname','Times New Roman','Box','off','EdgeColor','w','fontsize',22);

Rm1   = rmse(OSPRmean,CSPRmean);
text('String',['RMSE = ',num2str(Rm1,'%.2f')],'Color',[0.2  0.2  0.976],...
    'Units','Normalized','Position',[0.60 0.17],'FontWeight','bold','Fontname','Times New Roman','Fontsize',30);
Rm2   = rmse(OSPRmean,BSPRmean);
text('String',['RMSE = ',num2str(Rm2,'%.2f')],'Color',[0.11 0.52 0.11],...
    'Units','Normalized','Position',[0.60 0.07],'FontWeight','bold','Fontname','Times New Roman','Fontsize',30);


pause(5); set(gcf,'position',[150 150 830 500],'defaultAxesFontSize',12);  

print(Fig,'-dtiff','-r300',[Path_Figure,'ShdeSPRUn.tif']);close(Fig);


%%
Fig=figure;set(gcf,'position',[150 150 830 500],'defaultAxesFontSize',20);
set(gca,'Units','Pixels','Position',[100 60 700 420]);box on;hold on;
x=(2001:2015);

H1=shadedErrorBar( x,OWINmean,OWINstd,'lineprops',{'-r','Color',[0.133 0.133 0.133],'LineWidth',4},'transparent',1);
H2=shadedErrorBar( x,CWINmean,CWINstd,'lineprops',{'-r','Color',[0.2  0.2  0.976],'LineWidth',4},'transparent',1);
H3=shadedErrorBar( x,BWINmean,BWINstd,'lineprops',{'-r','Color',[0.11 0.52 0.11],'LineWidth',4},'transparent',1);

% set(gca,'xaxislocation','top');
set(gca,'xlim',[2001 2015],'ylim',[-40 40],'xtick',2001:4:2015,'Fontsize',22,'ytick',-30:10:40,'FontWeight','bold','Fontname','Times New Roman','Fontsize',22); 
text('String',['b) dormancy'],'Units','Normalized','Position',[0.04 0.90],'FontWeight','bold','Fontname','Times New Roman','Fontsize',32); 
ylabel('anomaly (days)','FontWeight','bold','Fontname','Times New Roman','FontSize',32);

Rm1   = rmse(OWINmean,CWINmean);
text('String',['RMSE = ',num2str(Rm1,'%.2f')],'Color',[0.2  0.2  0.976],...
    'Units','Normalized','Position',[0.60 0.17],'FontWeight','bold','Fontname','Times New Roman','Fontsize',30);
Rm2   = rmse(OWINmean,BWINmean);
text('String',['RMSE = ',num2str(Rm2,'%.2f')],'Color',[0.11 0.52 0.11],...
    'Units','Normalized','Position',[0.60 0.07],'FontWeight','bold','Fontname','Times New Roman','Fontsize',30);


pause(5); set(gcf,'position',[150 150 830 500],'defaultAxesFontSize',12);  

print(Fig,'-dtiff','-r300',[Path_Figure,'ShdeWINUn.tif']);close(Fig);


%%
Fig=figure;set(gcf,'position',[150 150 830 500],'defaultAxesFontSize',20);
set(gca,'Units','Pixels','Position',[100 60 700 420]);box on;hold on;
x=(2001:2015);

H1=shadedErrorBar( x,OSUMmean,OSUMstd,'lineprops',{'-r','Color',[0.133 0.133 0.133],'LineWidth',4},'transparent',1);
H2=shadedErrorBar( x,CSUMmean,CSUMstd,'lineprops',{'-r','Color',[0.2  0.2  0.976],'LineWidth',4},'transparent',1);

% set(gca,'xaxislocation','top');
set(gca,'xlim',[2001 2015],'ylim',[-40 40],'xtick',2001:4:2015,'Fontsize',22,'ytick',-30:10:40,'FontWeight','bold','Fontname','Times New Roman','Fontsize',22); 
text('String',['c) maturation'],'Units','Normalized','Position',[0.04 0.90],'FontWeight','bold','Fontname','Times New Roman','Fontsize',32); 
ylabel('anomaly (days)','FontWeight','bold','Fontname','Times New Roman','FontSize',32);

Rm1   = rmse(OSUMmean,CSUMmean);
text('String',['RMSE = ',num2str(Rm1,'%.2f')],'Color',[0.2  0.2  0.976],...
    'Units','Normalized','Position',[0.60 0.17],'FontWeight','bold','Fontname','Times New Roman','Fontsize',30);

pause(5); set(gcf,'position',[150 150 830 500],'defaultAxesFontSize',12);  

print(Fig,'-dtiff','-r300',[Path_Figure,'ShdeSUMUn.tif']);close(Fig);


%%
Fig=figure;set(gcf,'position',[150 150 830 500],'defaultAxesFontSize',20);
set(gca,'Units','Pixels','Position',[100 60 700 420]);box on;hold on;
x=(2001:2015);

H1=shadedErrorBar( x,OAUTmean,OAUTstd,'lineprops',{'-r','Color',[0.133 0.133 0.133],'LineWidth',4},'transparent',1);
H2=shadedErrorBar( x,CAUTmean,CAUTstd,'lineprops',{'-r','Color',[0.2  0.2  0.976],'LineWidth',4},'transparent',1);

% set(gca,'xaxislocation','top');
set(gca,'xlim',[2001 2015],'ylim',[-40 40],'xtick',2001:4:2015,'Fontsize',22,'ytick',-30:10:40,'FontWeight','bold','Fontname','Times New Roman','Fontsize',22); 
text('String',['d) senescence'],'Units','Normalized','Position',[0.04 0.90],'FontWeight','bold','Fontname','Times New Roman','Fontsize',32); 

% R = sqrt(rsquare(OAUTmean,CAUTmean));
Rm1   = rmse(OAUTmean,CAUTmean);
text('String',['RMSE = ',num2str(Rm1,'%.2f')],'Color',[0.2  0.2  0.976],...
    'Units','Normalized','Position',[0.60 0.17],'FontWeight','bold','Fontname','Times New Roman','Fontsize',30);
ylabel('anomaly (days)','FontWeight','bold','Fontname','Times New Roman','FontSize',32);

pause(5); set(gcf,'position',[150 150 830 500],'defaultAxesFontSize',12);  

print(Fig,'-dtiff','-r300',[Path_Figure,'ShdeAUTUn.tif']);close(Fig);



%% Combine

Fig1=imread([Path_Figure,'ShdeSPRUn.tif']);
Fig2=imread([Path_Figure,'ShdeWINUn.tif']);
Fig3=imread([Path_Figure,'ShdeSUMUn.tif']);
Fig4=imread([Path_Figure,'ShdeAUTUn.tif']);

Fig=cat(1,cat(2,Fig1,Fig2),cat(2,Fig3,Fig4));

Fig=imresize(Fig,2244/size(Fig,2));

imwrite(Fig,[Path_Figure,'Anomaly.tif'],'Compression','LZW','Resolution',300);

delete([Path_Figure,'Shde*','.tif']);

