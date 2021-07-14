addpath(genpath('./'));

Path_Figure   = '../figure/';
Path_LandCover = '../input/';
WorldShape=shaperead('../misc/WorldCountry/world_country_boundary.shp','UseGeoCoords', true);

[Landcover,R]=geotiffread([Path_LandCover,'LCT_Mul_CMG025_USGS.tif']);

Landcover=double(Landcover);

Class=Landcover;

% water
Class(Landcover==0)=4; 

%EV 
Class(Landcover == 1 | Landcover == 2 )= 1; % belong to EV

%DV
Class(Landcover == 3 | Landcover == 4 | Landcover == 5) = 2; % belong to DBF  

%SD
Class(Landcover == 6 | Landcover == 7 | Landcover == 8 | Landcover == 9 | Landcover == 10) = 3; % belong to SDV  


% other vegetation
Class(Landcover==11| Landcover==12 | Landcover==14) = 5;

% none vegetation
Class(Landcover==13| Landcover==15)=6;

% plot figure
Thres1=0;
Thres2=6;

Fig=figure;set(gcf,'position',[100 100 1200 600],'defaultAxesFontSize',12);  
set(gca, 'visible', 'off');

grid2image(Class,R);

set(gca,'visible', 'on','color','none');
set(gca,'Units','Pixels','Position',[25 70 1170 520]);box on;hold on; 
set(gca,'xlim',[-180 180],'ylim',[-60 90]);
set(gca,'xtick',-120:60:120,'ytick',-30:30:60);
set(gca,'xlabel',[],'ylabel',[]);
set(gca,'xticklabel',{''},'FontWeight','bold','FontSize',22);
set(gca,'yticklabel',{''},'FontWeight','bold','FontSize',22);

Color=land3type();
colormap(Color);
set(gca, 'clim', [Thres1+0.05 Thres2]);

Hbar=colorbar('Location','SouthoutSide');
Pos=get(Hbar,'Position');
Pos=[Pos(1)+0.10 Pos(2)-0.21+ 0.10 Pos(3)-0.20 Pos(4)];

set(Hbar,'Position',Pos,'FontWeight','bold','FontSize',16,'Fontname','Times New Roman'); 
set(Hbar,'xlim',[Thres1 Thres2]);
set(Hbar,'Xtick',Thres1+0.5:1:Thres2);
set(Hbar,'TickLabels',{'1','2','3','4','5','6'});

geoshow([WorldShape.Lat],[WorldShape.Lon],'Color',[0.3 0.3 0.3],'LineStyle','-','LineWidth',1.0);

% text('String','a) BULAI4g','Units','Normalized','Position',[0.02 0.12],'FontWeight','bold','FontSize',24);

pause(5); set(gcf,'position',[100 100 1200 600],'defaultAxesFontSize',12);  

print(Fig,'-dtiff','-r300',[Path_Figure,'Landcover.tif']);close(Fig);
