
clear;

addpath(genpath('./'));

Path_BiomeLAI  ='../input/';
Path_LAIvsPHN ='../output/28_LAIvsPHN/';
Path_Figure    = '../figure/';

load([Path_LAIvsPHN,'LAIvsPHN.mat']);
AsciiDVn = dlmread([Path_BiomeLAI,'5574DV.dayout.ascii']);
Bio15DVn = AsciiDVn(2556:3285,1);

AsciiDVs = dlmread([Path_BiomeLAI,'4446DV.dayout.ascii']);
Bio15DVs = AsciiDVs(2556:3285,1);

AsciiSDn = dlmread([Path_BiomeLAI,'63370SD.dayout.ascii']);
Bio15SDn = AsciiSDn(2556:3285,1);

AsciiSDs = dlmread([Path_BiomeLAI,'48094SD.dayout.ascii']);
Bio15SDs = AsciiSDs(2556:3285,1);
Date =datenum(2008,1,1:730)';

%% DVn
Fig=figure;
set(gcf,'position',[100 100 800 750],'defaultAxesFontSize',30);
set(gca,'Units','Pixels','Position',[100 120 680 600]);box on;hold on;

% set(gca,'fontsize',32,'FontWeight','bold','FontName','Times');
set(gca,'ylim',[0 5],'ytick',0:1:5,'fontsize',32,'Fontname','Times New Roman'); 
xlim([0 730]);

MOD15 = plot(MOD15DVn,'color',[0.243 0.277 0.592],'LineWidth',8);

hold on; 
Bio15 = plot(Bio15DVn,'color',[0.580 0.784 0.937],'LineWidth',8); 

 Obs =plot([Obs12DVn(1,1),Obs12DVn(1,1)],get(gca,'YLim'),':','color',[0.41961 0.55686 0.13725],'linewidth',8);  
      plot([Obs12DVn(2,1),Obs12DVn(2,1)],get(gca,'YLim'),'--','color',[0.41961 0.55686 0.13725],'LineWidth',8);  

 
 Cnn =plot([Cnn12DVn(1,1),Cnn12DVn(1,1)],get(gca,'YLim'),':','color',[0.93 0.192 0.145],'LineWidth',8);
      plot([Cnn12DVn(2,1),Cnn12DVn(2,1)],get(gca,'YLim'),'--','color',[0.93 0.192 0.145],'LineWidth',8);

 
 Bio =plot([Bio12DVn(1,1),Bio12DVn(1,1)],get(gca,'YLim'),':','color',[1 0.753 0],'LineWidth',8);
      plot([Bio12DVn(2,1),Bio12DVn(2,1)],get(gca,'YLim'),'--','color',[1 0.753 0],'LineWidth',8);

 text('String','a)','Units','Normalized','Position',[0.05 0.9],'FontWeight','bold',...
     'FontName','Times','Color',[0.2, 0.2, 0.2],'fontsize',38,'BackgroundColor','w'); 

 
box on,xlabel('day of year (day)','fontsize',36,'fontweight','bold','Fontname','Times New Roman');
ylabel('leaf area index (m^{2}m^{-2})','fontsize',36,'fontweight','bold','Fontname','Times New Roman');



print(Fig,'-dtiff','-r300',[Path_Figure,'LAIseries1.tif']);close(Fig);



%% DVs
Fig=figure;
set(gcf,'position',[100 100 800 750],'defaultAxesFontSize',30);
set(gca,'Units','Pixels','Position',[100 120 680 600]);box on;hold on;

set(gca,'ylim',[0 5],'ytick',0:1:5,'fontsize',32,'Fontname','Times New Roman'); 
xlim([0 730]);

MOD15 = plot(MOD15DVs,'color',[0.243 0.277 0.592],'LineWidth',8);
hold on; 
Bio15 = plot(Bio15DVs,'color',[0.580 0.784 0.937],'LineWidth',8); 

 Obs =plot([Obs12DVs(1,1),Obs12DVs(1,1)],get(gca,'YLim'),':','color',[0.41961 0.55686 0.13725],'LineWidth',8);  
      plot([Obs12DVs(2,1),Obs12DVs(2,1)],get(gca,'YLim'),'--','color',[0.41961 0.55686 0.13725],'LineWidth',8);  

 
 Cnn =plot([Cnn12DVs(1,1),Cnn12DVs(1,1)],get(gca,'YLim'),':','color',[0.93 0.192 0.145],'LineWidth',8);
      plot([Cnn12DVs(2,1),Cnn12DVs(2,1)],get(gca,'YLim'),'--','color',[0.93 0.192 0.145],'LineWidth',8);

 Bio =plot([Bio12DVs(1,1),Bio12DVs(1,1)],get(gca,'YLim'),':','color',[1 0.753 0],'LineWidth',8);
      plot([Bio12DVs(2,1),Bio12DVs(2,1)],get(gca,'YLim'),'--','color',[1 0.753 0],'LineWidth',8);

 text('String','b)','Units','Normalized','Position',[0.05 0.9],'FontWeight','bold',...
     'FontName','Times','Color',[0.2, 0.2, 0.2],'fontsize',38,'BackgroundColor','w'); 

 
box on,xlabel('day of year (day)','fontsize',36,'fontweight','bold','Fontname','Times New Roman');
ylabel('leaf area index (m^{2}m^{-2})','fontsize',36,'fontweight','bold','Fontname','Times New Roman');


print(Fig,'-dtiff','-r300',[Path_Figure,'LAIseries2.tif']);close(Fig);



%% SDn
Fig=figure;
set(gcf,'position',[100 100 800 750],'defaultAxesFontSize',30);
set(gca,'Units','Pixels','Position',[100 120 680 600]);box on;hold on;

set(gca,'ylim',[0 5],'ytick',0:1:5,'fontsize',32,'Fontname','Times New Roman'); 
xlim([0 730]);

MOD15 = plot(MOD15SDn,'color',[0.243 0.277 0.592],'LineWidth',8);
hold on; 
Bio15 = plot(Bio15SDn,'color',[0.580 0.784 0.937],'LineWidth',8); 

 Obs =plot([Obs12SDn(1,1),Obs12SDn(1,1)],get(gca,'YLim'),':','color',[0.41961 0.55686 0.13725],'LineWidth',8);  
 Obs1 =plot([Obs12SDn(2,1),Obs12SDn(2,1)],get(gca,'YLim'),'--','color',[0.41961 0.55686 0.13725],'LineWidth',8);  

 
 Cnn =plot([Cnn12SDn(1,1),Cnn12SDn(1,1)],get(gca,'YLim'),':','color',[0.93 0.192 0.145],'LineWidth',8);
 Cnn1 =plot([Cnn12SDn(2,1),Cnn12SDn(2,1)],get(gca,'YLim'),'--','color',[0.93 0.192 0.145],'LineWidth',8);

 Bio =plot([Bio12SDn(1,1),Bio12SDn(1,1)],get(gca,'YLim'),':','color',[1 0.753 0],'LineWidth',8);
 Bio1 =plot([Bio12SDn(2,1),Bio12SDn(2,1)],get(gca,'YLim'),'--','color',[1 0.753 0],'LineWidth',8);

text('String','c)','Units','Normalized','Position',[0.05 0.9],'FontWeight','bold',...
     'FontName','Times','Color',[0.2, 0.2, 0.2],'fontsize',38,'BackgroundColor','w'); 
 
box on,xlabel('day of year (day)','fontsize',36,'fontweight','bold','Fontname','Times New Roman');
ylabel('leaf area index (m^{2}m^{-2})','fontsize',36,'fontweight','bold','Fontname','Times New Roman');

HLegend=legend([MOD15,Bio15,Obs(1),Cnn(1),Bio(1),Obs1(1),Cnn1(1),Bio1(1)],...
    {'MOD15A2H LAI','Biome-BGC LAI','MCD12Q2 green-up','1D-CNNR green-up','Biome-BGC green-up',...
    'MCD12Q2 dormancy','1D-CNNR dormancy','Biome-BGC dormancy'});
set(HLegend,'Units','Pixels','Position',[200 450 780 150],'Box','off','EdgeColor','w','FontWeight','bold','fontsize',24);

print(Fig,'-dtiff','-r300',[Path_Figure,'LAIseries3.tif']);close(Fig);


%% SDn
Fig=figure;
set(gcf,'position',[100 100 800 750],'defaultAxesFontSize',28);
set(gca,'Units','Pixels','Position',[100 120 680 600]);box on;hold on;

set(gca,'ylim',[0 5],'ytick',0:1:5,'fontsize',32,'Fontname','Times New Roman'); 
xlim([0 730]);

MOD15 = plot(MOD15SDs,'color',[0.243 0.277 0.592],'LineWidth',8);
hold on; 
Bio15 = plot(Bio15SDs,'color',[0.580 0.784 0.937],'LineWidth',8); 

 Obs =plot([Obs12SDs(1,1),Obs12SDs(1,1)],get(gca,'YLim'),':','color',[0.41961 0.55686 0.13725],'LineWidth',8);  
      plot([Obs12SDs(2,1),Obs12SDs(2,1)],get(gca,'YLim'),'--','color',[0.41961 0.55686 0.13725],'LineWidth',8);  

 
 Cnn =plot([Cnn12SDs(1,1),Cnn12SDs(1,1)],get(gca,'YLim'),':','color',[0.93 0.192 0.145],'LineWidth',8);
      plot([Cnn12SDs(2,1),Cnn12SDs(2,1)],get(gca,'YLim'),'--','color',[0.93 0.192 0.145],'LineWidth',8);

 Bio =plot([Bio12SDs(1,1),Bio12SDs(1,1)],get(gca,'YLim'),':','color',[1 0.753 0],'LineWidth',8);
      plot([Bio12SDs(2,1),Bio12SDs(2,1)],get(gca,'YLim'),'--','color',[1 0.753 0],'LineWidth',8);

text('String','d)','Units','Normalized','Position',[0.05 0.9],'FontWeight','bold',...
     'FontName','Times','Color',[0.2, 0.2, 0.2],'fontsize',38,'BackgroundColor','w'); 
 
box on,xlabel('day of year (day)','fontsize',36,'fontweight','bold','Fontname','Times New Roman');
ylabel('leaf area index (m^{2}m^{-2})','fontsize',36,'fontweight','bold','Fontname','Times New Roman');


print(Fig,'-dtiff','-r300',[Path_Figure,'LAIseries4.tif']);close(Fig);



%%combine
Fig1=imread([Path_Figure,'LAIseries1.tif']);
Fig2=imread([Path_Figure,'LAIseries2.tif']);
Fig3=imread([Path_Figure,'LAIseries3.tif']);
Fig4=imread([Path_Figure,'LAIseries4.tif']);
Fig = cat(1,cat(2,Fig1,Fig2),cat(2,Fig3,Fig4));

Fig=imresize(Fig,2244/size(Fig,2));
imwrite(Fig,[Path_Figure,'LAIseries.tif'],'Compression','LZW','Resolution',300);

delete([Path_Figure,'LAIseries1.tif']);
delete([Path_Figure,'LAIseries2.tif']);
delete([Path_Figure,'LAIseries3.tif']);
delete([Path_Figure,'LAIseries4.tif']);
