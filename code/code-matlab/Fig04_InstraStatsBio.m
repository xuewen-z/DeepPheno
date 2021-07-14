clear;

addpath(genpath('./'));

Path_LandCover = '../input/';
Path_TAVG12IND = '../output/17_TAVG12IND/'; 
Path_Figure    = '../figure/';

WorldShape=shaperead('../misc/WorldCountry/world_country_boundary.shp','UseGeoCoords', true);
[Landcover,R] = geotiffread([Path_LandCover,'LCT_Mul_CMG025_USGS.tif']);  % Landcover坐标


YPHNList = {'SPR','WIN'};
CaptList ={'green-up','dormancy'};

for I_YPHN = 1: numel(YPHNList)
    YPHNName = YPHNList{I_YPHN};  
    CaptName = CaptList{I_YPHN};


%% Figure 1 NSE


Thres1 =  0;
Thres2 =  1.0;

[STAT16YPHN,R]=geotiffread(['../output/17_TAVG12IND/Bio12NSE.',YPHNName,'.2001.2015.tif']);
Class=STAT16YPHN;
% Class(Class<0)=0;

% plot
Fig=figure;set(gcf,'position',[100 100 1200 600],'defaultAxesFontSize',12);  
set(gca, 'visible', 'off');

% background
Background=zeros(size(Landcover));
Background(Landcover==12 | Landcover==14 | Landcover==15 | Landcover==16)=2;
ObjImage=grid2image(Background,R);
colormap([1 1 1; 0.3 0.3 0.3]);hold on;
set(ObjImage,'alphadata',0.2);
freezeColors;

% foreground
ObjImage=grid2image(Class,R);

set(gca, 'visible', 'on','color','none'); 
set(gca,'Units','Pixels','Position',[25 80 1170 520]);box on;hold on; 
set(gca,'xlim',[-180 180],'ylim',[-65 90]); 
set(gca,'xtick',-120:60:120,'ytick',-30:30:60); 
set(gca,'xlabel',[],'ylabel',[]); 
set(gca,'xticklabel',{},'FontWeight','bold','FontSize',22); 
set(gca,'yticklabel',{},'FontWeight','bold','FontSize',22); 

Color=green2blue();
colormap(Color);

% color map for significance
caxis([Thres1 Thres2]);

% set nan values to transparent: 
AlphaData=~isnan(Class);
set(ObjImage,'alphadata',AlphaData)
set(gca,'color','white');

geoshow([WorldShape.Lat],[WorldShape.Lon],'Color',[0.709 0.709 0.709],'LineStyle','-','LineWidth',1.0);

Hbar=colorbar('Location','SouthoutSide');
Pos=get(Hbar,'Position');
Pos=[Pos(1)+0.16 Pos(2)-0.09 Pos(3)-0.32 Pos(4)];     
set(Hbar,'Position',Pos,'FontWeight','bold','Fontname','Times New Roman','FontSize',30);
set(Hbar,'xlim',[Thres1 Thres2]);
set(Hbar,'Xtick',Thres1:0.2:Thres2);
TickLabel=cellstr(num2str(get(Hbar,'XTick')','%.1f'));
% TickLabel{1  }='<-1';
set(Hbar,'XTickLabel',TickLabel);

text('String',['d)',' NSE (',CaptName,')'],'Units','Normalized','Position',[0.02 0.20],'FontWeight','bold','Fontname','Times New Roman','Fontsize',34);
text('String','Biome-BGC vs. MODIS','Units','Normalized','Position',[0.02 0.10],'FontWeight','bold','Fontname','Times New Roman','Fontsize',34);

pause(5); set(gcf,'position',[100 100 1200 600],'defaultAxesFontSize',12);  

print(Fig,'-dtiff','-r300',[Path_Figure,'IntraStatsP1.tif']);close(Fig);

%% Figure 2 RMSE

Thres1 = 0;
Thres2 = 40;   

[STAT16YPHN,R]=geotiffread(['../output/17_TAVG12IND/Bio12RMSE.',YPHNName,'.2001.2015.tif']);
Class=STAT16YPHN;

% plot
Fig=figure;set(gcf,'position',[100 100 1200 600],'defaultAxesFontSize',12);  
set(gca, 'visible', 'off');

% background
Background=zeros(size(Landcover));
Background(Landcover==12 | Landcover==14 | Landcover==15 | Landcover==16)=2;
ObjImage=grid2image(Background,R);
colormap([1 1 1; 0.3 0.3 0.3]);hold on;
set(ObjImage,'alphadata',0.2);
freezeColors;

% foreground
ObjImage=grid2image(Class,R);

set(gca, 'visible', 'on','color','none'); 
set(gca,'Units','Pixels','Position',[25 80 1170 520]);box on;hold on; 
set(gca,'xlim',[-180 180],'ylim',[-65 90]); 
set(gca,'xtick',-120:60:120,'ytick',-30:30:60); 
set(gca,'xlabel',[],'ylabel',[]); 
set(gca,'xticklabel',{},'FontWeight','bold','FontSize',22); 
set(gca,'yticklabel',{},'FontWeight','bold','FontSize',22); 

Color=yellow2red();
colormap(Color);
set(gca, 'clim', [Thres1 Thres2]);

% set nan values to transparent: 
AlphaData=~isnan(Class);
set(ObjImage,'alphadata',AlphaData)
set(gca,'color','white');

geoshow([WorldShape.Lat],[WorldShape.Lon],'Color',[0.709 0.709 0.709],'LineStyle','-','LineWidth',1.0);

Hbar=colorbar('Location','SouthoutSide');
Pos=get(Hbar,'Position');
Pos=[Pos(1)+0.16 Pos(2)-0.09 Pos(3)-0.32 Pos(4)];     
set(Hbar,'Position',Pos,'FontWeight','bold','Fontname','Times New Roman','FontSize',30);
set(Hbar,'xlim',[Thres1 Thres2]);
set(Hbar,'Xtick',Thres1:10:Thres2);
TickLabel=cellstr(num2str(get(Hbar,'XTick')'));
% TickLabel{1  }='<1.5';
TickLabel{end}='>40';
set(Hbar,'XTickLabel',TickLabel);

text('String',['e)',' RMSE (',CaptName,')'],'Units','Normalized','Position',[0.02 0.20],'FontWeight','bold','Fontname','Times New Roman','Fontsize',34);
text('String','Biome-BGC vs. MODIS','Units','Normalized','Position',[0.02 0.10],'FontWeight','bold','Fontname','Times New Roman','Fontsize',34);
text('String','day','Units','Normalized','Position',[0.89 -0.10],'FontWeight','bold','Fontname','Times New Roman','Fontsize',34);

pause(5); set(gcf,'position',[100 100 1200 600],'defaultAxesFontSize',12);  

print(Fig,'-dtiff','-r300',[Path_Figure,'IntraStatsP2.tif']);close(Fig);

%% Figure 3 BIAS 

Thres1 = -40;    
Thres2 =  40;    

[STAT16YPHN,R]=geotiffread(['../output/17_TAVG12IND/Bio12BIAS.',YPHNName,'.2001.2015.tif']);
Class=STAT16YPHN;

% plot
Fig=figure;set(gcf,'position',[100 100 1200 600],'defaultAxesFontSize',12);  
set(gca, 'visible', 'off');

% background
Background=zeros(size(Landcover));
Background(Landcover==12 | Landcover==14 | Landcover==15 | Landcover==16)=2;
ObjImage=grid2image(Background,R);
colormap([1 1 1; 0.3 0.3 0.3]);hold on;
set(ObjImage,'alphadata',0.2);
freezeColors;

% foreground
ObjImage=grid2image(Class,R);

set(gca, 'visible', 'on','color','none'); 
set(gca,'Units','Pixels','Position',[25 80 1170 520]);box on;hold on; 
set(gca,'xlim',[-180 180],'ylim',[-65 90]); 
set(gca,'xtick',-120:60:120,'ytick',-30:30:60); 
set(gca,'xlabel',[],'ylabel',[]); 
set(gca,'xticklabel',{},'FontWeight','bold','FontSize',22); 
set(gca,'yticklabel',{},'FontWeight','bold','FontSize',22); 

Color=blue2gray2red();
colormap(Color);
set(gca, 'clim', [Thres1 Thres2]);

% set nan values to transparent: 
AlphaData=~isnan(Class);
set(ObjImage,'alphadata',AlphaData)
set(gca,'color','white');

geoshow([WorldShape.Lat],[WorldShape.Lon],'Color',[0.709 0.709 0.709],'LineStyle','-','LineWidth',1.0);

Hbar=colorbar('Location','SouthoutSide');
Pos=get(Hbar,'Position');
Pos=[Pos(1)+0.16 Pos(2)-0.09 Pos(3)-0.32 Pos(4)];     
set(Hbar,'Position',Pos,'FontWeight','bold','Fontname','Times New Roman','FontSize',30);
set(Hbar,'xlim',[Thres1 Thres2]);
set(Hbar,'Xtick',Thres1:20:Thres2);
TickLabel=cellstr(num2str(get(Hbar,'XTick')'));
TickLabel{1  }='<-40';
TickLabel{end}='>40';
set(Hbar,'XTickLabel',TickLabel);

pause(5); set(gcf,'position',[100 100 1200 600],'defaultAxesFontSize',12);  

text('String',['f )',' Bias (',CaptName,')'],'Units','Normalized','Position',[0.02 0.20],'FontWeight','bold','Fontname','Times New Roman','Fontsize',34);
text('String','Biome-BGC vs. MODIS','Units','Normalized','Position',[0.02 0.10],'FontWeight','bold','Fontname','Times New Roman','Fontsize',34);

text('String','day','Units','Normalized','Position',[0.89 -0.10],'FontWeight','bold','Fontname','Times New Roman','Fontsize',34);

print(Fig,'-dtiff','-r300',[Path_Figure,'IntraStatsP3.tif']);close(Fig);


% Combine

Fig1=imread([Path_Figure,'IntraStatsP1.tif']);
Fig2=imread([Path_Figure,'IntraStatsP2.tif']);
Fig3=imread([Path_Figure,'IntraStatsP3.tif']);

Fig=cat(1,cat(2,Fig1),cat(2,Fig2),cat(2,Fig3));

Fig=imresize(Fig,2244/size(Fig,2));

imwrite(Fig,[Path_Figure,'IntraStatsBio.',YPHNName,'.tif'],'Compression','LZW','Resolution',300);

delete([Path_Figure,'IntraStatsP1.tif']);
delete([Path_Figure,'IntraStatsP2.tif']);
delete([Path_Figure,'IntraStatsP3.tif']);
end