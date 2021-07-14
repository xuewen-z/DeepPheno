
clear;

addpath(genpath('./'));

Path_LandCover = '../input/';
Path_TAVG12VAR = '../output/18_TAVG12VAR/'; 
Path_Figure    = '../figure/';

WorldShape=shaperead('../misc/WorldCountry/world_country_boundary.shp','UseGeoCoords', true);
[Landcover,R] = geotiffread([Path_LandCover,'LCT_Mul_CMG025_USGS.tif']);  %Landcover坐标


YPHNList = {'SPR','AUT'};
CaptList ={'a)','b)'};
YPHNList2 = {'onset counter','offset counter'};

for I_YPHN = 1: numel(YPHNList)
    YPHNName = YPHNList{I_YPHN};  
    CaptName = CaptList{I_YPHN};
    YPHNName2 = YPHNList2{I_YPHN};  

Thres1 = 0;
Thres2 = 365;

[ObsVARPHN,R]=geotiffread([Path_TAVG12VAR,'ObsVAR',YPHNName,'.2001.2015.tif']);


Class=ObsVARPHN;
Hist=reshape(ObsVARPHN,[],1);
Hist(Hist<0 | Hist>365)=nan;

% plot figure
Fig=figure;set(gcf,'position',[100 100 1200 600],'defaultAxesFontSize',12);  
set(gca, 'visible', 'off');

% background
Background=zeros(size(Landcover));
Background(Landcover==12 | Landcover==14 |Landcover==15 | Landcover==16)=2;
ObjImage=grid2image(Background,R);
colormap([1 1 1; 0.3 0.3 0.3]);hold on;
set(ObjImage,'alphadata',0.2);
freezeColors;

% foreground
ObjImage=grid2image(Class,R);

set(gca,'visible', 'on','color','none');
set(gca,'Units','Pixels','Position',[25 80 1170 520]);box on;hold on; 
set(gca,'xlim',[-180 180],'ylim',[-65 90]);
set(gca,'xtick',-120:60:120,'ytick',-30:30:60);
set(gca,'xlabel',[],'ylabel',[]);
set(gca,'xticklabel',{''},'FontWeight','bold','FontSize',22);
set(gca,'yticklabel',{''},'FontWeight','bold','FontSize',22);
% set(gca,'xticklabel',{'120W','60W','0','60E','120E'},'FontWeight','bold','FontSize',22);
% set(gca,'yticklabel',{'30S','0','30N','60N'},'FontWeight','bold','FontSize',22);

Color=blue2yellow2red();
colormap(Color);
caxis([Thres1 Thres2]);

% set nan values to transparent
AlphaData=~isnan(Class);
set(ObjImage,'alphadata',AlphaData)
set(gca,'color','white');

geoshow([WorldShape.Lat],[WorldShape.Lon],'Color',[0.709 0.709 0.709],'LineStyle','-','LineWidth',1.0);

Hbar=colorbar('Location','SouthoutSide');
Pos=get(Hbar,'Position');
Pos=[Pos(1)+0.16 Pos(2)-0.09 Pos(3)-0.32 Pos(4)]; 

set(Hbar,'Position',Pos,'FontWeight','bold','Fontname','Times New Roman','Fontsize',32);  
set(Hbar,'xlim',[Thres1 Thres2]);
set(Hbar,'Xtick',Thres1:50:Thres2);
TickLabel=cellstr(num2str(get(Hbar,'XTick')','%.0f'));
TickLabel{1  }='0';
TickLabel{end}='365';
set(Hbar,'XTickLabel',TickLabel);

pause(5); set(gcf,'position',[100 100 1200 600],'defaultAxesFontSize',12);  

text('String',[CaptName,' MODIS ',YPHNName2],'Units','Normalized','Position',[0.02 0.12],'FontWeight','bold','Fontname','Times New Roman','FontSize',34);
text('String','day','Units','Normalized','Position',[0.85 -0.10],'FontWeight','bold','Fontname','Times New Roman','Fontsize',38); 

print(Fig,'-dtiff','-r300',[Path_Figure,'VariationMOD',YPHNName,'.tif']);close(Fig);


%% histfit figure

Fig=figure;set(gcf,'position',[100 100 900 300],'defaultAxesFontSize',12);  
set(gca, 'visible', 'off');

h= histogram(Hist,80);

set(gca,'ylim',[0 23000],'fontsize',36,'FontWeight','bold','Fontname','Times New Roman');   
set(gca,'xlim',[0 150],'xtick',0:50:150,'fontsize',36,'FontWeight','bold','Fontname','Times New Roman');   
TickLabel=cellstr(num2str(get(gca,'XTick')','%.0f'));
TickLabel{end}='150 day';
set(gca,'XTickLabel',TickLabel);


box on;
ylabel('pixel number','fontsize',38,'fontweight','bold','Fontname','Times New Roman');

pause(5); set(gcf,'position',[100 100 900 300],'defaultAxesFontSize',12);  


print(Fig,'-dtiff','-r300',[Path_Figure,'HistMOD',YPHNName,'.tif']);close(Fig);


end

%% Combine
% Fig1=imread([Path_Figure,'VariationSPR.tif']);
% Fig2=imread([Path_Figure,'VariationAUT.tif']);
% Fig3=imread([Path_Figure,'HistSPR.tif']);
% Fig4=imread([Path_Figure,'HistAUT.tif']);
% 
% 
% Fig5=cat(1,cat(2,Fig3),cat(2,Fig1));
% Fig6=cat(1,cat(2,Fig4),cat(2,Fig2));
% Fig =cat(1,cat(2,Fig5,Fig6));
% 
% Fig=imresize(Fig,2244/size(Fig,2));
% imwrite(Fig,[Path_Figure,'VariHist.tif'],'Compression','LZW','Resolution',300);

CaptList ={'c)','d)'};


for I_YPHN = 1: numel(YPHNList)
    YPHNName = YPHNList{I_YPHN};  
    CaptName = CaptList{I_YPHN};
    YPHNName2 = YPHNList2{I_YPHN};  

Thres1 = 0;
Thres2 = 365;

[CnnVARPHN,R]=geotiffread([Path_TAVG12VAR,'CnnVAR',YPHNName,'.2001.2015.tif']);


Class=CnnVARPHN;
Hist=reshape(CnnVARPHN,[],1);
Hist(Hist<0 | Hist>365)=nan;

% plot figure
Fig=figure;set(gcf,'position',[100 100 1200 600],'defaultAxesFontSize',12);  
set(gca, 'visible', 'off');

% background
Background=zeros(size(Landcover));
Background(Landcover==12 | Landcover==14 |Landcover==15 | Landcover==16)=2;
ObjImage=grid2image(Background,R);
colormap([1 1 1; 0.3 0.3 0.3]);hold on;
set(ObjImage,'alphadata',0.2);
freezeColors;

% foreground
ObjImage=grid2image(Class,R);

set(gca,'visible', 'on','color','none');
set(gca,'Units','Pixels','Position',[25 80 1170 520]);box on;hold on; 
set(gca,'xlim',[-180 180],'ylim',[-65 90]);
set(gca,'xtick',-120:60:120,'ytick',-30:30:60);
set(gca,'xlabel',[],'ylabel',[]);
set(gca,'xticklabel',{''},'FontWeight','bold','FontSize',22);
set(gca,'yticklabel',{''},'FontWeight','bold','FontSize',22);
% set(gca,'xticklabel',{'120W','60W','0','60E','120E'},'FontWeight','bold','FontSize',22);
% set(gca,'yticklabel',{'30S','0','30N','60N'},'FontWeight','bold','FontSize',22);

Color=blue2yellow2red();
colormap(Color);
caxis([Thres1 Thres2]);

% set nan values to transparent
AlphaData=~isnan(Class);
set(ObjImage,'alphadata',AlphaData)
set(gca,'color','white');

geoshow([WorldShape.Lat],[WorldShape.Lon],'Color',[0.709 0.709 0.709],'LineStyle','-','LineWidth',1.0);

Hbar=colorbar('Location','SouthoutSide');
Pos=get(Hbar,'Position');
Pos=[Pos(1)+0.16 Pos(2)-0.09 Pos(3)-0.32 Pos(4)]; 

set(Hbar,'Position',Pos,'FontWeight','bold','Fontname','Times New Roman','Fontsize',32);  
set(Hbar,'xlim',[Thres1 Thres2]);
set(Hbar,'Xtick',Thres1:50:Thres2);
TickLabel=cellstr(num2str(get(Hbar,'XTick')','%.0f'));
TickLabel{1  }='0';
TickLabel{end}='365';
set(Hbar,'XTickLabel',TickLabel);

pause(5); set(gcf,'position',[100 100 1200 600],'defaultAxesFontSize',12);  

text('String',[CaptName,' 1D-CNNR ',YPHNName2],'Units','Normalized','Position',[0.02 0.12],'FontWeight','bold','Fontname','Times New Roman','FontSize',34);
text('String','day','Units','Normalized','Position',[0.85 -0.10],'FontWeight','bold','Fontname','Times New Roman','Fontsize',38); 

print(Fig,'-dtiff','-r300',[Path_Figure,'VariationCNN',YPHNName,'.tif']);close(Fig);


%% histfit figure

Fig=figure;set(gcf,'position',[100 100 800 300],'defaultAxesFontSize',12);  
set(gca, 'visible', 'off');

h= histogram(Hist,80);

set(gca,'ylim',[0 23000],'fontsize',36,'FontWeight','bold','Fontname','Times New Roman');   
set(gca,'xlim',[0 150],'xtick',0:50:150,'fontsize',36,'FontWeight','bold','Fontname','Times New Roman');   
TickLabel=cellstr(num2str(get(gca,'XTick')','%.0f'));
TickLabel{end}='150 day';
set(gca,'XTickLabel',TickLabel);


box on;
ylabel('pixel number','fontsize',38,'fontweight','bold','Fontname','Times New Roman');


pause(5); set(gcf,'position',[100 100 800 300],'defaultAxesFontSize',12);  


print(Fig,'-dtiff','-r300',[Path_Figure,'HistCNN',YPHNName,'.tif']);close(Fig);


end

%% Combine
% Fig1=imread([Path_Figure,'VariationSPR.tif']);
% Fig2=imread([Path_Figure,'VariationAUT.tif']);
% Fig3=imread([Path_Figure,'HistSPR.tif']);
% Fig4=imread([Path_Figure,'HistAUT.tif']);
% 
% 
% Fig5=cat(1,cat(2,Fig3),cat(2,Fig1));
% Fig6=cat(1,cat(2,Fig4),cat(2,Fig2));
% Fig =cat(1,cat(2,Fig5,Fig6));
% 
% Fig=imresize(Fig,2244/size(Fig,2));
% imwrite(Fig,[Path_Figure,'VariHistCNN.tif'],'Compression','LZW','Resolution',300);

