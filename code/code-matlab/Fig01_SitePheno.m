clear;
addpath(genpath('./'));

Path_Figure    = '../figure/';

%% SDtype

SiteYPHN=dlmread('/home/xuewen/Python/predict/Pre_SD_SPR_A2008.csv');

DYPHN=SiteYPHN(:,2);
MYPHN=SiteYPHN(:,1);
MYPHN=round(MYPHN,0);

%% SPR
Fig=figure;set(gcf,'position',[100 100 800 800],'defaultAxesfontsize',32);
set(gca,'Units','Pixels','Position',[125 125 650 660]);box on;hold on;

plot(DYPHN,MYPHN,'o','MarkerSize',20,...
        'MarkerFaceColor',[0.180 0.545 0.341],'MarkerEdgeColor', [0.9098 0.9098 0.9098],'LineWidth',1);

axis([0,365,0,365])
set(gca,'xtick',0:60:365,'fontsize',32,'Fontname','Times New Roman');   
set(gca,'ytick',0:60:365,'fontsize',32,'Fontname','Times New Roman');   
box on,xlabel('MODIS (day)','fontsize',38,'fontweight','bold','Fontname','Times New Roman');
ylabel('1D-CNNR (day)','fontsize',38,'fontweight','bold','Fontname','Times New Roman');

Ref1=refline([1 0]);
set(Ref1,'LineStyle','--','Color','k','LineWidth',2);

backColor = [0.9098 0.9098 0.9098];
set(gca,'color',backColor)

set(gca,'xgrid','on','ygrid','on','LineWidth',3,'GridColor',[1 1 1]);

Stats=regstats(MYPHN(:),DYPHN(:)); %(y,x)
Ref2=refline([Stats.beta(2) Stats.beta(1)]);  %(a,b)
set(Ref2,'LineStyle','-','Color',[0.0 0.0 0.0],'LineWidth',2);

R2  = rsquare(DYPHN(:),MYPHN(:))
R = sqrt(R2)
RMSE= rmse(DYPHN(:).* Stats.beta(2) + Stats.beta(1),MYPHN(:))
Bias=mbe(DYPHN(:),MYPHN(:))
d= dvalue(DYPHN(:),MYPHN(:));

text('String',['y = ',num2str(Stats.beta(2),'%.2f'),'x + ',num2str(Stats.beta(1),'%.2f')],...
    'Units','Normalized','Position',[0.40 0.340],'FontWeight','bold','Fontsize',40,'Fontname','Times New Roman','BackgroundColor',[0.81176 0.81176 0.81176]);
text('String',['R = ',num2str(R,'%.2f')],...
    'Units','Normalized','Position',[0.40 0.240],'FontWeight','bold','Fontsize',40,'Fontname','Times New Roman','BackgroundColor',[0.81176 0.81176 0.81176]);
text('String',['RMSE = ',num2str(RMSE,'%.2f')],...
    'Units','Normalized','Position',[0.40 0.150],'FontWeight','bold','Fontsize',40,'Fontname','Times New Roman','BackgroundColor',[0.81176 0.81176 0.81176]);
text('String',['Bias = ',num2str(Bias,'%.2f')],...
    'Units','Normalized','Position',[0.40 0.065],'FontWeight','bold','Fontsize',40,'Fontname','Times New Roman','BackgroundColor',[0.81176 0.81176 0.81176]);
text('String','a) SDV green-up',...
     'Units','Normalized','Position',[0.05 0.90],'FontWeight','bold','Fontsize',40,'Fontname','Times New Roman');

pause(5); set(gcf,'position',[100 100 800 800],'defaultAxesfontsize',32);  
print(Fig,'-dtiff','-r300',[Path_Figure,'SitePheno1.tif']);close(Fig);

 
%% SUM


SiteYPHN=dlmread('/home/xuewen/Python/predict/Pre_SD_SUM_A2008.csv');

DYPHN=SiteYPHN(:,2);
MYPHN=SiteYPHN(:,1);
MYPHN=round(MYPHN,0);

Fig=figure;set(gcf,'position',[100 100 800 800],'defaultAxesfontsize',32);
set(gca,'Units','Pixels','Position',[125 125 650 660]);box on;hold on;

plot(DYPHN,MYPHN,'o','MarkerSize',20,...
        'MarkerFaceColor',[1 0.796 0.439],'MarkerEdgeColor', [0.9098 0.9098 0.9098],'LineWidth',1);
  
axis([0,365,0,365])
set(gca,'xtick',0:60:365,'fontsize',32,'Fontname','Times New Roman');   
set(gca,'ytick',0:60:365,'fontsize',32,'Fontname','Times New Roman');   
box on,xlabel('MODIS (day)','fontsize',38,'fontweight','bold','Fontname','Times New Roman');
ylabel('1D-CNNR (day)','fontsize',38,'fontweight','bold','Fontname','Times New Roman');

Ref1=refline([1 0]);
set(Ref1,'LineStyle','--','Color','k','LineWidth',2);

backColor = [0.9098 0.9098 0.9098];
set(gca,'color',backColor)

set(gca,'xgrid','on','ygrid','on','LineWidth',3,'GridColor',[1 1 1]);

Stats=regstats(MYPHN(:),DYPHN(:)); %(y,x)
Ref2=refline([Stats.beta(2) Stats.beta(1)]);  %(a,b)
set(Ref2,'LineStyle','-','Color',[0.0 0.0 0.0],'LineWidth',2);

R2  = rsquare(DYPHN(:),MYPHN(:))
R = sqrt(R2)
RMSE= rmse(DYPHN(:).* Stats.beta(2) + Stats.beta(1),MYPHN(:))
Bias=mbe(DYPHN(:),MYPHN(:))
d= dvalue(DYPHN(:),MYPHN(:));

text('String',['y = ',num2str(Stats.beta(2),'%.2f'),'x + ',num2str(Stats.beta(1),'%.2f')],...
    'Units','Normalized','Position',[0.40 0.340],'FontWeight','bold','Fontsize',40,'Fontname','Times New Roman','BackgroundColor',[0.81176 0.81176 0.81176]);
text('String',['R = ',num2str(R,'%.2f')],...
    'Units','Normalized','Position',[0.40 0.240],'FontWeight','bold','Fontsize',40,'Fontname','Times New Roman','BackgroundColor',[0.81176 0.81176 0.81176]);
text('String',['RMSE = ',num2str(RMSE,'%.2f')],...
    'Units','Normalized','Position',[0.40 0.150],'FontWeight','bold','Fontsize',40,'Fontname','Times New Roman','BackgroundColor',[0.81176 0.81176 0.81176]);
text('String',['Bias = ',num2str(Bias,'%.2f')],...
    'Units','Normalized','Position',[0.40 0.065],'FontWeight','bold','Fontsize',40,'Fontname','Times New Roman','BackgroundColor',[0.81176 0.81176 0.81176]);
text('String','b) SDV maturation',...
     'Units','Normalized','Position',[0.05 0.90],'FontWeight','bold','Fontsize',40,'Fontname','Times New Roman');

pause(5); set(gcf,'position',[100 100 800 800],'defaultAxesfontsize',32);  
print(Fig,'-dtiff','-r300',[Path_Figure,'SitePheno2.tif']);close(Fig);

%% AUT


SiteYPHN=dlmread('/home/xuewen/Python/predict/Pre_SD_AUT_A2008.csv');

DYPHN=SiteYPHN(:,2);
MYPHN=SiteYPHN(:,1);
MYPHN=round(MYPHN,0);

Fig=figure;set(gcf,'position',[100 100 800 800],'defaultAxesfontsize',32);
set(gca,'Units','Pixels','Position',[125 125 650 660]);box on;hold on;

plot(DYPHN,MYPHN,'o','MarkerSize',20,...
        'MarkerFaceColor',[0.745 0.153 0.208],'MarkerEdgeColor', [0.9098 0.9098 0.9098],'LineWidth',1);

axis([0,365,0,365])
set(gca,'xtick',0:60:365,'fontsize',32,'Fontname','Times New Roman');   
set(gca,'ytick',0:60:365,'fontsize',32,'Fontname','Times New Roman');   
box on,xlabel('MODIS (day)','fontsize',38,'fontweight','bold','Fontname','Times New Roman');
ylabel('1D-CNNR (day)','fontsize',38,'fontweight','bold','Fontname','Times New Roman');

Ref1=refline([1 0]);
set(Ref1,'LineStyle','--','Color','k','LineWidth',2);

backColor = [0.9098 0.9098 0.9098];
set(gca,'color',backColor)

set(gca,'xgrid','on','ygrid','on','LineWidth',3,'GridColor',[1 1 1]);

Stats=regstats(MYPHN(:),DYPHN(:)); %(y,x)
Ref2=refline([Stats.beta(2) Stats.beta(1)]);  %(a,b)
set(Ref2,'LineStyle','-','Color',[0.0 0.0 0.0],'LineWidth',2);

R2  = rsquare(DYPHN(:),MYPHN(:))
R = sqrt(R2)
RMSE= rmse(DYPHN(:).* Stats.beta(2) + Stats.beta(1),MYPHN(:))
Bias=mbe(DYPHN(:),MYPHN(:))
d= dvalue(DYPHN(:),MYPHN(:));

text('String',['y = ',num2str(Stats.beta(2),'%.2f'),'x + ',num2str(Stats.beta(1),'%.2f')],...
    'Units','Normalized','Position',[0.40 0.340],'FontWeight','bold','Fontsize',40,'Fontname','Times New Roman','BackgroundColor',[0.81176 0.81176 0.81176]);
text('String',['R = ',num2str(R,'%.2f')],...
    'Units','Normalized','Position',[0.40 0.240],'FontWeight','bold','Fontsize',40,'Fontname','Times New Roman','BackgroundColor',[0.81176 0.81176 0.81176]);
text('String',['RMSE = ',num2str(RMSE,'%.2f')],...
    'Units','Normalized','Position',[0.40 0.150],'FontWeight','bold','Fontsize',40,'Fontname','Times New Roman','BackgroundColor',[0.81176 0.81176 0.81176]);
text('String',['Bias = ',num2str(Bias,'%.2f')],...
    'Units','Normalized','Position',[0.40 0.065],'FontWeight','bold','Fontsize',40,'Fontname','Times New Roman','BackgroundColor',[0.81176 0.81176 0.81176]);
text('String','c) SDV senescence',...
     'Units','Normalized','Position',[0.05 0.90],'FontWeight','bold','Fontsize',40,'Fontname','Times New Roman');

pause(5); set(gcf,'position',[100 100 800 800],'defaultAxesfontsize',32);  
print(Fig,'-dtiff','-r300',[Path_Figure,'SitePheno3.tif']);close(Fig);

%% WIN


SiteYPHN=dlmread('/home/xuewen/Python/predict/Pre_SD_WIN_A2008.csv');

DYPHN=SiteYPHN(:,2);
MYPHN=SiteYPHN(:,1);
MYPHN=round(MYPHN,0);

Fig=figure;set(gcf,'position',[100 100 800 800],'defaultAxesfontsize',32);
set(gca,'Units','Pixels','Position',[125 125 650 660]);box on;hold on;

plot(DYPHN,MYPHN,'o','MarkerSize',20,...
        'MarkerFaceColor',[0.0196 0.0784 0.6784],'MarkerEdgeColor', [0.9098 0.9098 0.9098],'LineWidth',1);

axis([0,365,0,365])
set(gca,'xtick',0:60:365,'fontsize',32,'Fontname','Times New Roman');   
set(gca,'ytick',0:60:365,'fontsize',32,'Fontname','Times New Roman');   
box on,xlabel('MODIS (day)','fontsize',38,'fontweight','bold','Fontname','Times New Roman');
ylabel('1D-CNNR (day)','fontsize',38,'fontweight','bold','Fontname','Times New Roman');

Ref1=refline([1 0]);
set(Ref1,'LineStyle','--','Color','k','LineWidth',2);

backColor = [0.9098 0.9098 0.9098];
set(gca,'color',backColor)

set(gca,'xgrid','on','ygrid','on','LineWidth',3,'GridColor',[1 1 1]);

Stats=regstats(MYPHN(:),DYPHN(:)); %(y,x)
Ref2=refline([Stats.beta(2) Stats.beta(1)]);  %(a,b)
set(Ref2,'LineStyle','-','Color',[0.0 0.0 0.0],'LineWidth',2);

R2  = rsquare(DYPHN(:),MYPHN(:))
R = sqrt(R2)
RMSE= rmse(DYPHN(:).* Stats.beta(2) + Stats.beta(1),MYPHN(:))
Bias=mbe(DYPHN(:),MYPHN(:))
d= dvalue(DYPHN(:),MYPHN(:));

text('String',['y = ',num2str(Stats.beta(2),'%.2f'),'x + ',num2str(Stats.beta(1),'%.2f')],...
    'Units','Normalized','Position',[0.40 0.340],'FontWeight','bold','Fontsize',40,'Fontname','Times New Roman','BackgroundColor',[0.81176 0.81176 0.81176]);
text('String',['R = ',num2str(R,'%.2f')],...
    'Units','Normalized','Position',[0.40 0.240],'FontWeight','bold','Fontsize',40,'Fontname','Times New Roman','BackgroundColor',[0.81176 0.81176 0.81176]);
text('String',['RMSE = ',num2str(RMSE,'%.2f')],...
    'Units','Normalized','Position',[0.40 0.150],'FontWeight','bold','Fontsize',40,'Fontname','Times New Roman','BackgroundColor',[0.81176 0.81176 0.81176]);
text('String',['Bias = ',num2str(Bias,'%.2f')],...
    'Units','Normalized','Position',[0.40 0.065],'FontWeight','bold','Fontsize',40,'Fontname','Times New Roman','BackgroundColor',[0.81176 0.81176 0.81176]);
text('String','d) SDV dormancy',...
     'Units','Normalized','Position',[0.05 0.90],'FontWeight','bold','Fontsize',40,'Fontname','Times New Roman');

pause(5); set(gcf,'position',[100 100 800 800],'defaultAxesfontsize',32);  
print(Fig,'-dtiff','-r300',[Path_Figure,'SitePheno4.tif']);close(Fig);


%% DVtype

SiteYPHN=dlmread('/home/xuewen/Python/predict/Pre_DV_SPR_A2008.csv');

DYPHN=SiteYPHN(:,2);
MYPHN=SiteYPHN(:,1);
MYPHN=round(MYPHN,0);

%% SPR
Fig=figure;set(gcf,'position',[100 100 800 800],'defaultAxesfontsize',32);
set(gca,'Units','Pixels','Position',[125 125 650 660]);box on;hold on;

plot(DYPHN,MYPHN,'d','MarkerSize',20,...
        'MarkerFaceColor',[0.180 0.545 0.341],'MarkerEdgeColor', [0.9098 0.9098 0.9098],'LineWidth',1);

axis([0,365,0,365])
set(gca,'xtick',0:60:365,'fontsize',32,'Fontname','Times New Roman');   
set(gca,'ytick',0:60:365,'fontsize',32,'Fontname','Times New Roman');   
box on,xlabel('MODIS (day)','fontsize',38,'fontweight','bold','Fontname','Times New Roman');
ylabel('1D-CNNR (day)','fontsize',38,'fontweight','bold','Fontname','Times New Roman');

Ref1=refline([1 0]);
set(Ref1,'LineStyle','--','Color','k','LineWidth',2);

backColor = [0.9098 0.9098 0.9098];
set(gca,'color',backColor)

set(gca,'xgrid','on','ygrid','on','LineWidth',3,'GridColor',[1 1 1]);

Stats=regstats(MYPHN(:),DYPHN(:)); %(y,x)
Ref2=refline([Stats.beta(2) Stats.beta(1)]);  %(a,b)
set(Ref2,'LineStyle','-','Color',[0.0 0.0 0.0],'LineWidth',2);

R2  = rsquare(DYPHN(:),MYPHN(:))
R = sqrt(R2)
RMSE= rmse(DYPHN(:).* Stats.beta(2) + Stats.beta(1),MYPHN(:))
Bias=mbe(DYPHN(:),MYPHN(:))
d= dvalue(DYPHN(:),MYPHN(:));

text('String',['y = ',num2str(Stats.beta(2),'%.2f'),'x + ',num2str(Stats.beta(1),'%.2f')],...
    'Units','Normalized','Position',[0.40 0.340],'FontWeight','bold','Fontsize',40,'Fontname','Times New Roman','BackgroundColor',[0.81176 0.81176 0.81176]);
text('String',['R = ',num2str(R,'%.2f')],...
    'Units','Normalized','Position',[0.40 0.240],'FontWeight','bold','Fontsize',40,'Fontname','Times New Roman','BackgroundColor',[0.81176 0.81176 0.81176]);
text('String',['RMSE = ',num2str(RMSE,'%.2f')],...
    'Units','Normalized','Position',[0.40 0.150],'FontWeight','bold','Fontsize',40,'Fontname','Times New Roman','BackgroundColor',[0.81176 0.81176 0.81176]);
text('String',['Bias = ',num2str(Bias,'%.2f')],...
    'Units','Normalized','Position',[0.40 0.065],'FontWeight','bold','Fontsize',40,'Fontname','Times New Roman','BackgroundColor',[0.81176 0.81176 0.81176]);
text('String','e) DV green-up',...
     'Units','Normalized','Position',[0.05 0.90],'FontWeight','bold','Fontsize',40,'Fontname','Times New Roman');

pause(5); set(gcf,'position',[100 100 800 800],'defaultAxesfontsize',32);  
print(Fig,'-dtiff','-r300',[Path_Figure,'SitePheno5.tif']);close(Fig);

 
%% SUM


SiteYPHN=dlmread('/home/xuewen/Python/predict/Pre_DV_SUM_A2008.csv');

DYPHN=SiteYPHN(:,2);
MYPHN=SiteYPHN(:,1);
MYPHN=round(MYPHN,0);

Fig=figure;set(gcf,'position',[100 100 800 800],'defaultAxesfontsize',32);
set(gca,'Units','Pixels','Position',[125 125 650 660]);box on;hold on;

plot(DYPHN,MYPHN,'d','MarkerSize',20,...
        'MarkerFaceColor',[1 0.796 0.439],'MarkerEdgeColor', [0.9098 0.9098 0.9098],'LineWidth',1);

axis([0,365,0,365])
set(gca,'xtick',0:60:365,'fontsize',32,'Fontname','Times New Roman');   
set(gca,'ytick',0:60:365,'fontsize',32,'Fontname','Times New Roman');   
box on,xlabel('MODIS (day)','fontsize',38,'fontweight','bold','Fontname','Times New Roman');
ylabel('1D-CNNR (day)','fontsize',38,'fontweight','bold','Fontname','Times New Roman');

Ref1=refline([1 0]);
set(Ref1,'LineStyle','--','Color','k','LineWidth',2);

backColor = [0.9098 0.9098 0.9098];
set(gca,'color',backColor)

set(gca,'xgrid','on','ygrid','on','LineWidth',3,'GridColor',[1 1 1]);

Stats=regstats(MYPHN(:),DYPHN(:)); %(y,x)
Ref2=refline([Stats.beta(2) Stats.beta(1)]);  %(a,b)
set(Ref2,'LineStyle','-','Color',[0.0 0.0 0.0],'LineWidth',2);

R2  = rsquare(DYPHN(:),MYPHN(:))
R = sqrt(R2)
RMSE= rmse(DYPHN(:).* Stats.beta(2) + Stats.beta(1),MYPHN(:))
Bias=mbe(DYPHN(:),MYPHN(:))
d= dvalue(DYPHN(:),MYPHN(:));

text('String',['y = ',num2str(Stats.beta(2),'%.2f'),'x + ',num2str(Stats.beta(1),'%.2f')],...
    'Units','Normalized','Position',[0.40 0.340],'FontWeight','bold','Fontsize',40,'Fontname','Times New Roman','BackgroundColor',[0.81176 0.81176 0.81176]);
text('String',['R = ',num2str(R,'%.2f')],...
    'Units','Normalized','Position',[0.40 0.240],'FontWeight','bold','Fontsize',40,'Fontname','Times New Roman','BackgroundColor',[0.81176 0.81176 0.81176]);
text('String',['RMSE = ',num2str(RMSE,'%.2f')],...
    'Units','Normalized','Position',[0.40 0.150],'FontWeight','bold','Fontsize',40,'Fontname','Times New Roman','BackgroundColor',[0.81176 0.81176 0.81176]);
text('String',['Bias = ',num2str(Bias,'%.2f')],...
    'Units','Normalized','Position',[0.40 0.065],'FontWeight','bold','Fontsize',40,'Fontname','Times New Roman','BackgroundColor',[0.81176 0.81176 0.81176]);
text('String','f) DV maturation',...
     'Units','Normalized','Position',[0.05 0.90],'FontWeight','bold','Fontsize',40,'Fontname','Times New Roman');

pause(5); set(gcf,'position',[100 100 800 800],'defaultAxesfontsize',32);  
print(Fig,'-dtiff','-r300',[Path_Figure,'SitePheno6.tif']);close(Fig);

%% AUT


SiteYPHN=dlmread('/home/xuewen/Python/predict/Pre_DV_AUT_A2008.csv');

DYPHN=SiteYPHN(:,2);
MYPHN=SiteYPHN(:,1);
MYPHN=round(MYPHN,0);

Fig=figure;set(gcf,'position',[100 100 800 800],'defaultAxesfontsize',32);
set(gca,'Units','Pixels','Position',[125 125 650 660]);box on;hold on;

plot(DYPHN,MYPHN,'d','MarkerSize',20,...
        'MarkerFaceColor',[0.745 0.153 0.208],'MarkerEdgeColor', [0.9098 0.9098 0.9098],'LineWidth',1);

axis([0,365,0,365])
set(gca,'xtick',0:60:365,'fontsize',32,'Fontname','Times New Roman');   
set(gca,'ytick',0:60:365,'fontsize',32,'Fontname','Times New Roman');   
box on,xlabel('MODIS (day)','fontsize',38,'fontweight','bold','Fontname','Times New Roman');
ylabel('1D-CNNR (day)','fontsize',38,'fontweight','bold','Fontname','Times New Roman');

Ref1=refline([1 0]);
set(Ref1,'LineStyle','--','Color','k','LineWidth',2);

backColor = [0.9098 0.9098 0.9098];
set(gca,'color',backColor)

set(gca,'xgrid','on','ygrid','on','LineWidth',3,'GridColor',[1 1 1]);

Stats=regstats(MYPHN(:),DYPHN(:)); %(y,x)
Ref2=refline([Stats.beta(2) Stats.beta(1)]);  %(a,b)
set(Ref2,'LineStyle','-','Color',[0.0 0.0 0.0],'LineWidth',2);

R2  = rsquare(DYPHN(:),MYPHN(:));
R = sqrt(R2);
RMSE= rmse(DYPHN(:).* Stats.beta(2) + Stats.beta(1),MYPHN(:));
Bias=mbe(DYPHN(:),MYPHN(:));
d= dvalue(DYPHN(:),MYPHN(:));

text('String',['y = ',num2str(Stats.beta(2),'%.2f'),'x + ',num2str(Stats.beta(1),'%.2f')],...
    'Units','Normalized','Position',[0.40 0.340],'FontWeight','bold','Fontsize',40,'Fontname','Times New Roman','BackgroundColor',[0.81176 0.81176 0.81176]);
text('String',['R = ',num2str(R,'%.2f')],...
    'Units','Normalized','Position',[0.40 0.240],'FontWeight','bold','Fontsize',40,'Fontname','Times New Roman','BackgroundColor',[0.81176 0.81176 0.81176]);
text('String',['RMSE = ',num2str(RMSE,'%.2f')],...
    'Units','Normalized','Position',[0.40 0.150],'FontWeight','bold','Fontsize',40,'Fontname','Times New Roman','BackgroundColor',[0.81176 0.81176 0.81176]);
text('String',['Bias = ',num2str(Bias,'%.2f')],...
    'Units','Normalized','Position',[0.40 0.065],'FontWeight','bold','Fontsize',40,'Fontname','Times New Roman','BackgroundColor',[0.81176 0.81176 0.81176]);
text('String','g) DV senescence',...
     'Units','Normalized','Position',[0.05 0.90],'FontWeight','bold','Fontsize',40,'Fontname','Times New Roman');

pause(5); set(gcf,'position',[100 100 800 800],'defaultAxesfontsize',32);  
print(Fig,'-dtiff','-r300',[Path_Figure,'SitePheno7.tif']);close(Fig);

%% WIN


SiteYPHN=dlmread('/home/xuewen/Python/predict/Pre_DV_WIN_A2008.csv');

DYPHN=SiteYPHN(:,2);
MYPHN=SiteYPHN(:,1);
MYPHN=round(MYPHN,0);

Fig=figure;set(gcf,'position',[100 100 800 800],'defaultAxesfontsize',32);
set(gca,'Units','Pixels','Position',[125 125 650 660]);box on;hold on;

plot(DYPHN,MYPHN,'d','MarkerSize',20,...
        'MarkerFaceColor',[0.0196 0.0784 0.6784],'MarkerEdgeColor', [0.9098 0.9098 0.9098],'LineWidth',1);

axis([0,365,0,365])
set(gca,'xtick',0:60:365,'fontsize',32,'Fontname','Times New Roman');   
set(gca,'ytick',0:60:365,'fontsize',32,'Fontname','Times New Roman');   
box on,xlabel('MODIS (day)','fontsize',38,'fontweight','bold','Fontname','Times New Roman');
ylabel('1D-CNNR (day)','fontsize',38,'fontweight','bold','Fontname','Times New Roman');

Ref1=refline([1 0]);
set(Ref1,'LineStyle','--','Color','k','LineWidth',2);

backColor = [0.9098 0.9098 0.9098];
set(gca,'color',backColor)

set(gca,'xgrid','on','ygrid','on','LineWidth',3,'GridColor',[1 1 1]);

Stats=regstats(MYPHN(:),DYPHN(:)); %(y,x)
Ref2=refline([Stats.beta(2) Stats.beta(1)]);  %(a,b)
set(Ref2,'LineStyle','-','Color',[0.0 0.0 0.0],'LineWidth',2);

R2  = rsquare(DYPHN(:),MYPHN(:))
R = sqrt(R2)
RMSE= rmse(DYPHN(:).* Stats.beta(2) + Stats.beta(1),MYPHN(:))
Bias=mbe(DYPHN(:),MYPHN(:))
d= dvalue(DYPHN(:),MYPHN(:));

text('String',['y = ',num2str(Stats.beta(2),'%.2f'),'x + ',num2str(Stats.beta(1),'%.2f')],...
    'Units','Normalized','Position',[0.40 0.340],'FontWeight','bold','Fontsize',40,'Fontname','Times New Roman','BackgroundColor',[0.81176 0.81176 0.81176]);
text('String',['R = ',num2str(R,'%.2f')],...
    'Units','Normalized','Position',[0.40 0.240],'FontWeight','bold','Fontsize',40,'Fontname','Times New Roman','BackgroundColor',[0.81176 0.81176 0.81176]);
text('String',['RMSE = ',num2str(RMSE,'%.2f')],...
    'Units','Normalized','Position',[0.40 0.150],'FontWeight','bold','Fontsize',40,'Fontname','Times New Roman','BackgroundColor',[0.81176 0.81176 0.81176]);
text('String',['Bias = ',num2str(Bias,'%.2f')],...
    'Units','Normalized','Position',[0.40 0.065],'FontWeight','bold','Fontsize',40,'Fontname','Times New Roman','BackgroundColor',[0.81176 0.81176 0.81176]);
text('String','h) DV dormancy',...
     'Units','Normalized','Position',[0.05 0.90],'FontWeight','bold','Fontsize',40,'Fontname','Times New Roman');

pause(5); set(gcf,'position',[100 100 800 800],'defaultAxesfontsize',32);  
print(Fig,'-dtiff','-r300',[Path_Figure,'SitePheno8.tif']);close(Fig);

  
%%  EV type

SiteYPHN=dlmread('/home/xuewen/Python/predict/Pre_EV_SPR_A2008.csv');

DYPHN=SiteYPHN(:,2);
MYPHN=SiteYPHN(:,1);
MYPHN=round(MYPHN,0);

%% SPR
Fig=figure;set(gcf,'position',[100 100 800 800],'defaultAxesfontsize',32);
set(gca,'Units','Pixels','Position',[125 125 650 660]);box on;hold on;

plot(DYPHN,MYPHN,'s','MarkerSize',20,...
        'MarkerFaceColor',[0.180 0.545 0.341],'MarkerEdgeColor', [0.9098 0.9098 0.9098],'LineWidth',1);

axis([0,365,0,365])
set(gca,'xtick',0:60:365,'fontsize',32,'Fontname','Times New Roman');   
set(gca,'ytick',0:60:365,'fontsize',32,'Fontname','Times New Roman');   
box on,xlabel('MODIS (day)','fontsize',38,'fontweight','bold','Fontname','Times New Roman');
ylabel('1D-CNNR (day)','fontsize',38,'fontweight','bold','Fontname','Times New Roman');

Ref1=refline([1 0]);
set(Ref1,'LineStyle','--','Color','k','LineWidth',2);

backColor = [0.9098 0.9098 0.9098];
set(gca,'color',backColor)

set(gca,'xgrid','on','ygrid','on','LineWidth',3,'GridColor',[1 1 1]);

Stats=regstats(MYPHN(:),DYPHN(:)); %(y,x)
Ref2=refline([Stats.beta(2) Stats.beta(1)]);  %(a,b)
set(Ref2,'LineStyle','-','Color',[0.0 0.0 0.0],'LineWidth',2);

R2  = rsquare(DYPHN(:),MYPHN(:))
R = sqrt(R2)
RMSE= rmse(DYPHN(:).* Stats.beta(2) + Stats.beta(1),MYPHN(:))
Bias=mbe(DYPHN(:),MYPHN(:))
d= dvalue(DYPHN(:),MYPHN(:));

text('String',['y = ',num2str(Stats.beta(2),'%.2f'),'x + ',num2str(Stats.beta(1),'%.2f')],...
    'Units','Normalized','Position',[0.40 0.340],'FontWeight','bold','Fontsize',40,'Fontname','Times New Roman','BackgroundColor',[0.81176 0.81176 0.81176]);
text('String',['R = ',num2str(R,'%.2f')],...
    'Units','Normalized','Position',[0.40 0.240],'FontWeight','bold','Fontsize',40,'Fontname','Times New Roman','BackgroundColor',[0.81176 0.81176 0.81176]);
text('String',['RMSE = ',num2str(RMSE,'%.2f')],...
    'Units','Normalized','Position',[0.40 0.150],'FontWeight','bold','Fontsize',40,'Fontname','Times New Roman','BackgroundColor',[0.81176 0.81176 0.81176]);
text('String',['Bias = ',num2str(Bias,'%.2f')],...
    'Units','Normalized','Position',[0.40 0.065],'FontWeight','bold','Fontsize',40,'Fontname','Times New Roman','BackgroundColor',[0.81176 0.81176 0.81176]);
text('String','i) EV green-up',...
     'Units','Normalized','Position',[0.05 0.90],'FontWeight','bold','Fontsize',40,'Fontname','Times New Roman');

pause(5); set(gcf,'position',[100 100 800 800],'defaultAxesfontsize',32);  
print(Fig,'-dtiff','-r300',[Path_Figure,'SitePheno9.tif']);close(Fig);

 
%% SUM


SiteYPHN=dlmread('/home/xuewen/Python/predict/Pre_EV_SUM_A2008.csv');

DYPHN=SiteYPHN(:,2);
MYPHN=SiteYPHN(:,1);
MYPHN=round(MYPHN,0);

Fig=figure;set(gcf,'position',[100 100 800 800],'defaultAxesfontsize',32);
set(gca,'Units','Pixels','Position',[125 125 650 660]);box on;hold on;

plot(DYPHN,MYPHN,'s','MarkerSize',20,...
        'MarkerFaceColor',[1 0.796 0.439],'MarkerEdgeColor', [0.9098 0.9098 0.9098],'LineWidth',1);

axis([0,365,0,365])
set(gca,'xtick',0:60:365,'fontsize',32,'Fontname','Times New Roman');   
set(gca,'ytick',0:60:365,'fontsize',32,'Fontname','Times New Roman');   
box on,xlabel('MODIS (day)','fontsize',38,'fontweight','bold','Fontname','Times New Roman');
ylabel('1D-CNNR (day)','fontsize',38,'fontweight','bold','Fontname','Times New Roman');

Ref1=refline([1 0]);
set(Ref1,'LineStyle','--','Color','k','LineWidth',2);

backColor = [0.9098 0.9098 0.9098];
set(gca,'color',backColor)

set(gca,'xgrid','on','ygrid','on','LineWidth',3,'GridColor',[1 1 1]);

Stats=regstats(MYPHN(:),DYPHN(:)); %(y,x)
Ref2=refline([Stats.beta(2) Stats.beta(1)]);  %(a,b)
set(Ref2,'LineStyle','-','Color',[0.0 0.0 0.0],'LineWidth',2);

R2  = rsquare(DYPHN(:),MYPHN(:))
R = sqrt(R2)
RMSE= rmse(DYPHN(:).* Stats.beta(2) + Stats.beta(1),MYPHN(:))
Bias=mbe(DYPHN(:),MYPHN(:))
d= dvalue(DYPHN(:),MYPHN(:));

text('String',['y = ',num2str(Stats.beta(2),'%.2f'),'x + ',num2str(Stats.beta(1),'%.2f')],...
    'Units','Normalized','Position',[0.40 0.340],'FontWeight','bold','Fontsize',40,'Fontname','Times New Roman','BackgroundColor',[0.81176 0.81176 0.81176]);
text('String',['R = ',num2str(R,'%.2f')],...
    'Units','Normalized','Position',[0.40 0.240],'FontWeight','bold','Fontsize',40,'Fontname','Times New Roman','BackgroundColor',[0.81176 0.81176 0.81176]);
text('String',['RMSE = ',num2str(RMSE,'%.2f')],...
    'Units','Normalized','Position',[0.40 0.150],'FontWeight','bold','Fontsize',40,'Fontname','Times New Roman','BackgroundColor',[0.81176 0.81176 0.81176]);
text('String',['Bias = ',num2str(Bias,'%.2f')],...
    'Units','Normalized','Position',[0.40 0.065],'FontWeight','bold','Fontsize',40,'Fontname','Times New Roman','BackgroundColor',[0.81176 0.81176 0.81176]);
text('String','j) EV maturation',...
     'Units','Normalized','Position',[0.05 0.90],'FontWeight','bold','Fontsize',40,'Fontname','Times New Roman');

pause(5); set(gcf,'position',[100 100 800 800],'defaultAxesfontsize',32);  
print(Fig,'-dtiff','-r300',[Path_Figure,'SitePheno10.tif']);close(Fig);

%% AUT


SiteYPHN=dlmread('/home/xuewen/Python/predict/Pre_EV_AUT_A2008.csv');

DYPHN=SiteYPHN(:,2);
MYPHN=SiteYPHN(:,1);
MYPHN=round(MYPHN,0);

Fig=figure;set(gcf,'position',[100 100 800 800],'defaultAxesfontsize',32);
set(gca,'Units','Pixels','Position',[125 125 650 660]);box on;hold on;

plot(DYPHN,MYPHN,'s','MarkerSize',20,...
        'MarkerFaceColor',[0.745 0.153 0.208],'MarkerEdgeColor', [0.9098 0.9098 0.9098],'LineWidth',1);

axis([0,365,0,365])
set(gca,'xtick',0:60:365,'fontsize',32,'Fontname','Times New Roman');   
set(gca,'ytick',0:60:365,'fontsize',32,'Fontname','Times New Roman');   
box on,xlabel('MODIS (day)','fontsize',38,'fontweight','bold','Fontname','Times New Roman');
ylabel('1D-CNNR (day)','fontsize',38,'fontweight','bold','Fontname','Times New Roman');

Ref1=refline([1 0]);
set(Ref1,'LineStyle','--','Color','k','LineWidth',2);

backColor = [0.9098 0.9098 0.9098];
set(gca,'color',backColor)

set(gca,'xgrid','on','ygrid','on','LineWidth',3,'GridColor',[1 1 1]);

Stats=regstats(MYPHN(:),DYPHN(:)); %(y,x)
Ref2=refline([Stats.beta(2) Stats.beta(1)]);  %(a,b)
set(Ref2,'LineStyle','-','Color',[0.0 0.0 0.0],'LineWidth',2);

R2  = rsquare(DYPHN(:),MYPHN(:))
R = sqrt(R2)
RMSE= rmse(DYPHN(:).* Stats.beta(2) + Stats.beta(1),MYPHN(:))
Bias=mbe(DYPHN(:),MYPHN(:))
d= dvalue(DYPHN(:),MYPHN(:));

text('String',['y = ',num2str(Stats.beta(2),'%.2f'),'x + ',num2str(Stats.beta(1),'%.2f')],...
    'Units','Normalized','Position',[0.40 0.340],'FontWeight','bold','Fontsize',40,'Fontname','Times New Roman','BackgroundColor',[0.81176 0.81176 0.81176]);
text('String',['R = ',num2str(R,'%.2f')],...
    'Units','Normalized','Position',[0.40 0.240],'FontWeight','bold','Fontsize',40,'Fontname','Times New Roman','BackgroundColor',[0.81176 0.81176 0.81176]);
text('String',['RMSE = ',num2str(RMSE,'%.2f')],...
    'Units','Normalized','Position',[0.40 0.150],'FontWeight','bold','Fontsize',40,'Fontname','Times New Roman','BackgroundColor',[0.81176 0.81176 0.81176]);
text('String',['Bias = ',num2str(Bias,'%.2f')],...
    'Units','Normalized','Position',[0.40 0.065],'FontWeight','bold','Fontsize',40,'Fontname','Times New Roman','BackgroundColor',[0.81176 0.81176 0.81176]);
text('String','k) EV senescence',...
     'Units','Normalized','Position',[0.05 0.90],'FontWeight','bold','Fontsize',40,'Fontname','Times New Roman');

pause(5); set(gcf,'position',[100 100 800 800],'defaultAxesfontsize',32);  
print(Fig,'-dtiff','-r300',[Path_Figure,'SitePheno11.tif']);close(Fig);

%% WIN


SiteYPHN=dlmread('/home/xuewen/Python/predict/Pre_EV_WIN_A2008.csv');

DYPHN=SiteYPHN(:,2);
MYPHN=SiteYPHN(:,1);
MYPHN=round(MYPHN,0);

Fig=figure;set(gcf,'position',[100 100 800 800],'defaultAxesfontsize',32);
set(gca,'Units','Pixels','Position',[125 125 650 660]);box on;hold on;

plot(DYPHN,MYPHN,'s','MarkerSize',20,...
        'MarkerFaceColor',[0.0196 0.0784 0.6784],'MarkerEdgeColor', [0.9098 0.9098 0.9098],'LineWidth',1);

axis([0,365,0,365])
set(gca,'xtick',0:60:365,'fontsize',32,'Fontname','Times New Roman');   
set(gca,'ytick',0:60:365,'fontsize',32,'Fontname','Times New Roman');   
box on,xlabel('MODIS (day)','fontsize',38,'fontweight','bold','Fontname','Times New Roman');
ylabel('1D-CNNR (day)','fontsize',38,'fontweight','bold','Fontname','Times New Roman');

Ref1=refline([1 0]);
set(Ref1,'LineStyle','--','Color','k','LineWidth',2);

backColor = [0.9098 0.9098 0.9098];
set(gca,'color',backColor)

set(gca,'xgrid','on','ygrid','on','LineWidth',3,'GridColor',[1 1 1]);

Stats=regstats(MYPHN(:),DYPHN(:)); %(y,x)
Ref2=refline([Stats.beta(2) Stats.beta(1)]);  %(a,b)
set(Ref2,'LineStyle','-','Color',[0.0 0.0 0.0],'LineWidth',2);

R2  = rsquare(DYPHN(:),MYPHN(:))
R = sqrt(R2)
RMSE= rmse(DYPHN(:).* Stats.beta(2) + Stats.beta(1),MYPHN(:))
Bias=mbe(DYPHN(:),MYPHN(:))
d= dvalue(DYPHN(:),MYPHN(:));

text('String',['y = ',num2str(Stats.beta(2),'%.2f'),'x + ',num2str(Stats.beta(1),'%.2f')],...
    'Units','Normalized','Position',[0.40 0.340],'FontWeight','bold','Fontsize',40,'Fontname','Times New Roman','BackgroundColor',[0.81176 0.81176 0.81176]);
text('String',['R = ',num2str(R,'%.2f')],...
    'Units','Normalized','Position',[0.40 0.240],'FontWeight','bold','Fontsize',40,'Fontname','Times New Roman','BackgroundColor',[0.81176 0.81176 0.81176]);
text('String',['RMSE = ',num2str(RMSE,'%.2f')],...
    'Units','Normalized','Position',[0.40 0.150],'FontWeight','bold','Fontsize',40,'Fontname','Times New Roman','BackgroundColor',[0.81176 0.81176 0.81176]);
text('String',['Bias = ',num2str(Bias,'%.2f')],...
    'Units','Normalized','Position',[0.40 0.065],'FontWeight','bold','Fontsize',40,'Fontname','Times New Roman','BackgroundColor',[0.81176 0.81176 0.81176]);
text('String','l) EV dormancy',...
     'Units','Normalized','Position',[0.05 0.90],'FontWeight','bold','Fontsize',40,'Fontname','Times New Roman');

pause(5); set(gcf,'position',[100 100 800 800],'defaultAxesfontsize',32);  
print(Fig,'-dtiff','-r300',[Path_Figure,'SitePheno12.tif']);close(Fig);


%% Combine

Fig1=imread([Path_Figure,'SitePheno1.tif']);
Fig2=imread([Path_Figure,'SitePheno2.tif']);
Fig3=imread([Path_Figure,'SitePheno3.tif']);
Fig4=imread([Path_Figure,'SitePheno4.tif']);
Fig5=imread([Path_Figure,'SitePheno5.tif']);
Fig6=imread([Path_Figure,'SitePheno6.tif']);
Fig7=imread([Path_Figure,'SitePheno7.tif']);
Fig8=imread([Path_Figure,'SitePheno8.tif']);
Fig9=imread([Path_Figure,'SitePheno9.tif']);
Fig10=imread([Path_Figure,'SitePheno10.tif']);
Fig11=imread([Path_Figure,'SitePheno11.tif']);
Fig12=imread([Path_Figure,'SitePheno12.tif']);

Fig=cat(1,cat(2,Fig1,Fig2,Fig3,Fig4),cat(2,Fig5,Fig6,Fig7,Fig8),cat(2,Fig9,Fig10,Fig11,Fig12));

Fig=imresize(Fig,2244/size(Fig,2));
imwrite(Fig,[Path_Figure,'SitePheno.tif'],'Compression','LZW','Resolution',300);

delete([Path_Figure,'SitePheno1.tif']);
delete([Path_Figure,'SitePheno2.tif']);
delete([Path_Figure,'SitePheno3.tif']);
delete([Path_Figure,'SitePheno4.tif']);
delete([Path_Figure,'SitePheno5.tif']);
delete([Path_Figure,'SitePheno6.tif']);
delete([Path_Figure,'SitePheno7.tif']);
delete([Path_Figure,'SitePheno8.tif']);
delete([Path_Figure,'SitePheno9.tif']);
delete([Path_Figure,'SitePheno10.tif']);
delete([Path_Figure,'SitePheno11.tif']);
delete([Path_Figure,'SitePheno12.tif']);

