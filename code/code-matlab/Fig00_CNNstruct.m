clear;
addpath(genpath('./'));

Path_StatFeat= '../output/09_StatFeat/';
Path_SiteGLDAS = '../output/10_SiteGLDAS/';
Path_Figure    = '../figure/';

SiteYear = 2008; 
YearName = num2str(SiteYear,'%d');

load([Path_SiteGLDAS,'SiteGLDAS.A',YearName,'.mat']);
load([Path_StatFeat,'SiteStatic.A',YearName,'.mat']);

Fphotop =  SitePhotop(17000,:);
FPrecip = SitePrecip(17000,:);
FShorad =  SiteShorad(17000,:);
FSpehum = SiteSpehum(17000,:);
FTemavg =  SiteTemavg(17000,:);
FTemmax = SiteTemmax(17000,:);
FTemmin =  SiteTemmin(17000,:);
FVapdef = SiteVapdef(17000,:);
FWinspd =  SiteWinspd(17000,:);
FAtmpre = SiteAtmpre(17000,:);
FSILT = SiteSILT(17000,:);
FCLAY = SiteCLAY(17000,:);
FSAND = SiteSAND(17000,:);
FDEM = SiteDEM(17000,:);


CNNvariable = [Fphotop',FPrecip',FShorad',FSpehum',FTemavg',...
 FTemmax',FTemmin',FVapdef',FWinspd',FAtmpre',FSILT',FCLAY',FSAND',FDEM'];

% CNNvariable = [Fphotop',FPrecip',FShorad',FSpehum',FTemavg',...
%  FTemmax',FTemmin',FVapdef',FWinspd',FAtmpre'];

Header = 1:14;

% write data
% writematrix([Header;CNNvariable],[Path_Figure,'CNNstruct.csv']);

%% figure

% ClmaList = {Fphotop,FPrecip,FShorad,FSpehum,FTemavg,...
%     FTemmax,FTemmin,FVapdef',FWinspd,FAtmpre,FSILT,FCLAY,FSAND,FDEM} 

% for I_Clmat= 1: numel(ClmaList)
%     YClmat = ClmaList{I_Clmat};
%     
    
Fig=figure


set(gcf,'position',[100 100 840 220],'defaultAxesFontSize',26);
set(gca,'Units','Pixels','Position',[50 50 750 150]);hold on;

% plot(CNNstruct,'color',[0.28235 0.23922 0.5451],'LineWidth',2);
plot(CNNvariable,'LineWidth',1.8);

set(gca,'xtick',0:365:366,'fontsize',26,'fontweight','bold','Fontname','Times New Roman'); 
set(gca,'ytick',0:1,'fontsize',26,'fontweight','bold','Fontname','Times New Roman'); 
xlim([0 365]);
ylim([0 1]);
box off;
% set(gca,'fontsize',18,'FontWeight','bold','FontName','Times')

% annotation('arrow',[0.1 0.1],[0.8 1],'LineWidth',2);
% annotation('arrow',[0.8 1],[0.11 0.11],'LineWidth',2);

pause(5); set(gcf,'position',[100 100 840 220],'defaultAxesfontsize',32);  
print(Fig,'-dtiff','-r300',[Path_Figure,'CNNinput.tif']);close(Fig);


