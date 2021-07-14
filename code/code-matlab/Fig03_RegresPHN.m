Path_Figure  = '../figure/';
Path_LandCover= '../input/';
Path_TAVG12IND = '../output/17_TAVG12IND/'; 

Landcover=double(geotiffread([Path_LandCover,'LCT_Mul_CMG025_USGS.tif']));

YPHNList = {'SPR','WIN'};

for I_YPHN = 1: numel(YPHNList)
    YPHNName = YPHNList{I_YPHN};

 % Figure 1  north hemisphere

Cnn12AVG=geotiffread([Path_TAVG12IND,'Cnn12AVG.',YPHNName,'.2001.2015.tif']);
CClass=Cnn12AVG;
CClass(CClass<0)=NaN;

Obs12AVG=geotiffread([Path_TAVG12IND,'Obs12AVG.',YPHNName,'.2001.2015.tif']);
OClass=Obs12AVG;
OClass(OClass<0)=NaN;

% Northern  Hemisphere
CClass(361:600,:)=NaN;
OClass(361:600,:)=NaN;

% plot figure
Fig=figure;
set(gcf,'position',[100 100 400 600],'defaultAxesFontSize',14);  
set(gca, 'visible', 'off');

subplot(2,1,1);
scatplot(OClass(:),CClass(:),'ci');
set(gca,'xlim',[0 365],'ylim',[0 365],'xtick',0:70:365,'Fontsize',14,'ytick',0:70:365,'FontWeight','bold','Fontname','Times New Roman','Fontsize',18);  
set(gca,'Units','Pixels','Position',[80 350 240 240]);box on;hold on;

Ref1=refline([1 0]);
set(Ref1,'Color',[0.1 0.1 0.1],'LineWidth',2);


R   = rvalue(OClass(:),CClass(:));
RMSE= rmse(OClass,CClass);

text('String',['R= ',num2str(R,'%.2f')],...
    'Units','Normalized','Position',[0.3 0.22],'FontWeight','bold','Fontname','Times New Roman','Fontsize',22);
text('String',['RMSE= ',num2str(RMSE,'%.1f')],...
    'Units','Normalized','Position',[0.3 0.10],'FontWeight','bold','Fontname','Times New Roman','Fontsize',22);

ylabel('1D-CNNR (day)','FontWeight','bold','Fontname','Times New Roman','Fontsize',22,'Color','k');
% xlabel('MODIS (day)','FontWeight','bold','Fontname','Times New Roman','Fontsize',22,'Color','k');
text('String',['e) NH'],...
    'Units','Normalized','Position',[0.04 0.90],'FontWeight','bold','Fontname','Times New Roman','Fontsize',24); 


%% Figure 1  south hemisphere

Cnn12AVG=geotiffread([Path_TAVG12IND,'Cnn12AVG.',YPHNName,'.2001.2015.tif']);
CClass=Cnn12AVG;
CClass(CClass<0)=NaN;

Obs12AVG=geotiffread([Path_TAVG12IND,'Obs12AVG.',YPHNName,'.2001.2015.tif']);
OClass=Obs12AVG;
OClass(OClass<0)=NaN;

% Southern Hemisphere
CClass(1:360,:)=NaN;
OClass(1:360,:)=NaN;


subplot(2,1,2);
scatplot(OClass(:),CClass(:),'ci');
set(gca,'xlim',[0 365],'ylim',[0 365],'xtick',0:70:365,'Fontsize',14,'ytick',0:70:365,'FontWeight','bold','Fontname','Times New Roman','Fontsize',18);  
set(gca,'Units','Pixels','Position',[80 70 240 240]);box on;hold on;

Ref1=refline([1 0]);
set(Ref1,'Color',[0.1 0.1 0.1],'LineWidth',2);


R   = rvalue(OClass(:),CClass(:));
RMSE= rmse(OClass,CClass);

text('String',['R = ',num2str(R,'%.2f')],...
    'Units','Normalized','Position',[0.3 0.22],'FontWeight','bold','Fontname','Times New Roman','Fontsize',22);
text('String',['RMSE = ',num2str(RMSE,'%.1f')],...
    'Units','Normalized','Position',[0.3 0.10],'FontWeight','bold','Fontname','Times New Roman','Fontsize',22);

ylabel('1D-CNNR (day)','FontWeight','bold','Fontname','Times New Roman','Fontsize',22,'Color','k');
xlabel('MODIS (day)','FontWeight','bold','Fontname','Times New Roman','Fontsize',22,'Color','k');
text('String',['f) SH'],...
    'Units','Normalized','Position',[0.04 0.90],'FontWeight','bold','Fontname','Times New Roman','Fontsize',24); 

pause(5); set(gcf,'position',[100 100 400 600],'defaultAxesFontSize',12);  

print(Fig,'-dtiff','-r300',[Path_Figure,'RegresCnn',YPHNName,'.tif']);close(Fig);

end


YPHNList = {'SUM','AUT'};

for I_YPHN = 1: numel(YPHNList)
    YPHNName = YPHNList{I_YPHN};

 % Figure 1  north hemisphere

Cnn12AVG=geotiffread([Path_TAVG12IND,'Cnn12AVG.',YPHNName,'.2001.2015.tif']);
CClass=Cnn12AVG;
CClass(CClass<0)=NaN;

Obs12AVG=geotiffread([Path_TAVG12IND,'Obs12AVG.',YPHNName,'.2001.2015.tif']);
OClass=Obs12AVG;
OClass(OClass<0)=NaN;

% Northern  Hemisphere
CClass(361:600,:)=NaN;
OClass(361:600,:)=NaN;

% plot figure
Fig=figure;
set(gcf,'position',[100 100 400 600],'defaultAxesFontSize',14);  
set(gca, 'visible', 'off');

subplot(2,1,1);

scatplot(OClass(:),CClass(:),'ci');
set(gca,'xlim',[0 365],'ylim',[0 365],'xtick',0:70:365,'Fontsize',14,'ytick',0:70:365,'FontWeight','bold','Fontname','Times New Roman','Fontsize',18);  
set(gca,'Units','Pixels','Position',[80 350 240 240]);box on;hold on;

Ref1=refline([1 0]);
set(Ref1,'Color',[0.1 0.1 0.1],'LineWidth',2);


R   = rvalue(OClass(:),CClass(:));
RMSE= rmse(OClass,CClass);

text('String',['R= ',num2str(R,'%.2f')],...
    'Units','Normalized','Position',[0.3 0.22],'FontWeight','bold','Fontname','Times New Roman','Fontsize',22);
text('String',['RMSE= ',num2str(RMSE,'%.1f')],...
    'Units','Normalized','Position',[0.3 0.10],'FontWeight','bold','Fontname','Times New Roman','Fontsize',22);

ylabel('1D-CNNR (day)','FontWeight','bold','Fontname','Times New Roman','Fontsize',22,'Color','k');
xlabel('MODIS (day)','FontWeight','bold','Fontname','Times New Roman','Fontsize',22,'Color','k');
text('String',['d) NH'],...
    'Units','Normalized','Position',[0.04 0.90],'FontWeight','bold','Fontname','Times New Roman','Fontsize',24); 


%% Figure 1  south hemisphere

Cnn12AVG=geotiffread([Path_TAVG12IND,'Cnn12AVG.',YPHNName,'.2001.2015.tif']);
CClass=Cnn12AVG;
CClass(CClass<0)=NaN;

Obs12AVG=geotiffread([Path_TAVG12IND,'Obs12AVG.',YPHNName,'.2001.2015.tif']);
OClass=Obs12AVG;
OClass(OClass<0)=NaN;

% Southern Hemisphere
CClass(1:360,:)=NaN;
OClass(1:360,:)=NaN;


subplot(2,1,2);
scatplot(OClass(:),CClass(:),'ci');
set(gca,'xlim',[0 365],'ylim',[0 365],'xtick',0:70:365,'Fontsize',14,'ytick',0:70:365,'FontWeight','bold','Fontname','Times New Roman','Fontsize',18);  
set(gca,'Units','Pixels','Position',[80 70 240 240]);box on;hold on;

Ref1=refline([1 0]);
set(Ref1,'Color',[0.1 0.1 0.1],'LineWidth',2);


R   = rvalue(OClass(:),CClass(:));
RMSE= rmse(OClass,CClass);

text('String',['R = ',num2str(R,'%.2f')],...
    'Units','Normalized','Position',[0.3 0.22],'FontWeight','bold','Fontname','Times New Roman','Fontsize',22);
text('String',['RMSE = ',num2str(RMSE,'%.1f')],...
    'Units','Normalized','Position',[0.3 0.10],'FontWeight','bold','Fontname','Times New Roman','Fontsize',22);

ylabel('1D-CNNR (day)','FontWeight','bold','Fontname','Times New Roman','Fontsize',22,'Color','k');
xlabel('MODIS (day)','FontWeight','bold','Fontname','Times New Roman','Fontsize',22,'Color','k');
text('String',['e) SH'],...
    'Units','Normalized','Position',[0.04 0.90],'FontWeight','bold','Fontname','Times New Roman','Fontsize',24); 

pause(5); set(gcf,'position',[100 100 400 600],'defaultAxesFontSize',12);  

print(Fig,'-dtiff','-r300',[Path_Figure,'RegresCnn',YPHNName,'.tif']);close(Fig);

end



%%BiomeBGCs

YPHNList = {'SPR','WIN'};


for I_YPHN = 1: numel(YPHNList)
    YPHNName = YPHNList{I_YPHN};
    
 % Figure 1  north hemisphere

Bio12AVG=geotiffread([Path_TAVG12IND,'Bio12AVG.',YPHNName,'.2001.2015.tif']);
BClass=Bio12AVG;
BClass(BClass<0)=NaN;

Obs12AVG=geotiffread([Path_TAVG12IND,'Obs12AVG.',YPHNName,'.2001.2015.tif']);
OClass=Obs12AVG;
OClass(OClass<0)=NaN;

% Northern  Hemisphere
BClass(361:600,:)=NaN;
OClass(361:600,:)=NaN;

% plot figure
Fig=figure;
set(gcf,'position',[100 100 400 600],'defaultAxesFontSize',14);  
set(gca, 'visible', 'off');

subplot(2,1,1);

scatplot(OClass(:),BClass(:),'ci');
set(gca,'xlim',[0 365],'ylim',[0 365],'xtick',0:70:365,'Fontsize',14,'ytick',0:70:365,'FontWeight','bold','Fontname','Times New Roman','Fontsize',18);  
set(gca,'Units','Pixels','Position',[80 350 240 240]);box on;hold on;

Ref1=refline([1 0]);
set(Ref1,'Color',[0.1 0.1 0.1],'LineWidth',2);


R   = rvalue(OClass(:),BClass(:));
RMSE= rmse(OClass,BClass);

text('String',['R = ',num2str(R,'%.2f')],...
    'Units','Normalized','Position',[0.3 0.22],'FontWeight','bold','Fontname','Times New Roman','Fontsize',22);
text('String',['RMSE = ',num2str(RMSE,'%.1f')],...
    'Units','Normalized','Position',[0.3 0.10],'FontWeight','bold','Fontname','Times New Roman','Fontsize',22);

ylabel('Biome-BGC (day)','FontWeight','bold','Fontname','Times New Roman','Fontsize',22,'Color','k');
xlabel('MODIS (day)','FontWeight','bold','Fontname','Times New Roman','Fontsize',22,'Color','k');
text('String',['g) NH'],...
    'Units','Normalized','Position',[0.04 0.90],'FontWeight','bold','Fontname','Times New Roman','Fontsize',24); 

%% Figure 1  south hemisphere

Bio12AVG=geotiffread([Path_TAVG12IND,'Bio12AVG.',YPHNName,'.2001.2015.tif']);
BClass=Bio12AVG;
BClass(BClass<0)=NaN;

Obs12AVG=geotiffread([Path_TAVG12IND,'Obs12AVG.',YPHNName,'.2001.2015.tif']);
OClass=Obs12AVG;
OClass(OClass<0)=NaN;

% Southern Hemisphere
BClass(1:360,:)=NaN;
OClass(1:360,:)=NaN;


subplot(2,1,2);
scatplot(OClass(:),BClass(:),'ci');

set(gca,'xlim',[0 365],'ylim',[0 365],'xtick',0:70:365,'Fontsize',14,'ytick',0:70:365,'FontWeight','bold','Fontname','Times New Roman','Fontsize',18);  
set(gca,'Units','Pixels','Position',[80 70 240 240]);box on;hold on;

Ref1=refline([1 0]);
set(Ref1,'Color',[0.1 0.1 0.1],'LineWidth',2);


R   = rvalue(OClass(:),BClass(:));
RMSE= rmse(OClass,BClass);

text('String',['R = ',num2str(R,'%.2f')],...
    'Units','Normalized','Position',[0.3 0.22],'FontWeight','bold','Fontname','Times New Roman','Fontsize',22);
text('String',['RMSE = ',num2str(RMSE,'%.1f')],...
    'Units','Normalized','Position',[0.3 0.10],'FontWeight','bold','Fontname','Times New Roman','Fontsize',22);

ylabel('Biome-BGC (day)','FontWeight','bold','Fontname','Times New Roman','Fontsize',22,'Color','k');
xlabel('MODIS (day)','FontWeight','bold','Fontname','Times New Roman','Fontsize',22,'Color','k');
text('String',['h) SH'],...
    'Units','Normalized','Position',[0.04 0.90],'FontWeight','bold','Fontname','Times New Roman','Fontsize',24); 

pause(5); set(gcf,'position',[100 100 400 600],'defaultAxesFontSize',12);  

print(Fig,'-dtiff','-r300',[Path_Figure,'RegresBio',YPHNName,'.tif']);close(Fig);

end

%% Combine
% Fig1=imread([Path_Figure,'ExtentLAI1.tif']);
% Fig2=imread([Path_Figure,'ShadedLAI.tif']);
% Fig3=imread([Path_Figure,'ExtentLAI2.tif']);
% Fig4=imread([Path_Figure,'RegresLAI1.tif']);
% Fig5=imread([Path_Figure,'ExtentLAI3.tif']);
% Fig6=imread([Path_Figure,'RegresLAI2.tif']);
% 
% Fig=cat(1,cat(2,Fig1,Fig2),cat(2,Fig3,Fig4),cat(2,Fig5,Fig6));
% Fig=imresize(Fig,2244/size(Fig,2));
% imwrite(Fig,[Path_Figure,'ExtentLAI.tif'],'Compression','LZW','Resolution',300);
% s
% delete([Path_Figure,'ExtentLAI1.tif']);
% delete([Path_Figure,'ExtentLAI2.tif']);
% delete([Path_Figure,'ExtentLAI3.tif']);
% delete([Path_Figure,'RegresLAI1.tif']);
% delete([Path_Figure,'RegresLAI2.tif']);
% delete([Path_Figure,'ShadedLAI.tif']);
