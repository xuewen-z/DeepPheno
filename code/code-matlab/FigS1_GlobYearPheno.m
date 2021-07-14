
addpath(genpath('./'));
Path_LandCover = '../input/';
Path_CNN12YPHN = '../output/14_CNN12YPHN/'; 
Path_OBS12YPHN = '../output/15_OBS12YPHN/';
Path_Bio12YPHN = '../output/27_Bio12YPHN/';
Path_Figure    = '../figure/SI/';

% system(['rm -rf '  ,Path_Figure]);
% system(['mkdir -p ',Path_Figure]);

WorldShape=shaperead('../misc/WorldCountry/world_country_boundary.shp','UseGeoCoords', true);
[Landcover,R] = geotiffread([Path_LandCover,'LCT_Mul_CMG025_USGS.tif']);  %Landcover坐标

YPHNList = {'SPR','SUM','AUT','WIN'};
CaptList={'green-up','maturation','senescence','dormancy'};


% YPHNListB = {'SPR','WIN'};
% CaptListB={'green-up','dormancy'};


for SiteYear = 2001 : 2015
    YearName = num2str(SiteYear,'%d');
    
      
     for I_YPHN = 1: numel(YPHNList)

            YPHNName  = YPHNList{I_YPHN};                       
            CaptName  = CaptList{I_YPHN};


            Thres1 = 0;
            Thres2 = 365;

[CNN12YPHN,R]= geotiffread([Path_CNN12YPHN,'CNN12',YPHNName,'.A',YearName,'001.006.tif']); 

            
Class=CNN12YPHN;
Class(Class<0 | Class>365)=nan;

% plot figure
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

set(gca,'visible', 'on','color','none');
set(gca,'Units','Pixels','Position',[25 80 1170 520]);box on;hold on; 
set(gca,'xlim',[-180 180],'ylim',[-65 90]);
set(gca,'xtick',-120:60:120,'ytick',-30:30:60);
set(gca,'xlabel',[],'ylabel',[]);
set(gca,'xticklabel',{''},'FontWeight','bold','FontSize',22);
set(gca,'yticklabel',{''},'FontWeight','bold','FontSize',22);
% set(gca,'xticklabel',{'120W','60W','0','60E','120E'},'FontWeight','bold','FontSize',22);
% set(gca,'yticklabel',{'30S','0','30N','60N'},'FontWeight','bold','FontSize',22);

Color=phenocolor();
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

set(Hbar,'Position',Pos,'FontWeight','bold','Fontname','Times New Roman','FontSize',32); 
set(Hbar,'xlim',[Thres1 Thres2]);
set(Hbar,'Xtick',Thres1:50:Thres2);
TickLabel=cellstr(num2str(get(Hbar,'XTick')','%.0f'));
TickLabel{1  }='0';
TickLabel{end}='365';
set(Hbar,'XTickLabel',TickLabel);

pause(5); set(gcf,'position',[100 100 1200 600],'defaultAxesFontSize',12);  

text('String',[' 1D-CNNR ','(',CaptName,')'],'Units','Normalized','Position',[0.02 0.24],'FontWeight','bold','Fontname','Times New Roman','Fontsize',40);
text('String',[' Year ', YearName],'Units','Normalized','Position',[0.02 0.12],'FontWeight','bold','Fontname','Times New Roman','Fontsize',40);
text('String','day','Units','Normalized','Position',[0.85 -0.09],'FontWeight','bold','Fontname','Times New Roman','Fontsize',38);

print(Fig,'-dtiff','-r300',[Path_Figure,'CNN',YPHNName,YearName,'.tif']);close(Fig);
                   
%      
% % OBS 
% [OBS12YPHN,R]= geotiffread([Path_OBS12YPHN,'OBS12',YPHNName,'.A',YearName,'001.006.tif']); 
% 
%             
% Class=OBS12YPHN;
% Class(Class<0 | Class>365)=nan;
% 
% % plot figure
% Fig=figure;set(gcf,'position',[100 100 1200 600],'defaultAxesFontSize',12);  
% set(gca, 'visible', 'off');
% 
% % background
% Background=zeros(size(Landcover));
% Background(Landcover==12 | Landcover==14 | Landcover==15 | Landcover==16)=2; 
% ObjImage=grid2image(Background,R);
% colormap([1 1 1; 0.3 0.3 0.3]);hold on;
% set(ObjImage,'alphadata',0.2);
% freezeColors;
% 
% % foreground
% ObjImage=grid2image(Class,R);
% 
% set(gca,'visible', 'on','color','none');
% set(gca,'Units','Pixels','Position',[25 80 1170 520]);box on;hold on; 
% set(gca,'xlim',[-180 180],'ylim',[-65 90]);
% set(gca,'xtick',-120:60:120,'ytick',-30:30:60);
% set(gca,'xlabel',[],'ylabel',[]);
% set(gca,'xticklabel',{''},'FontWeight','bold','FontSize',22);
% set(gca,'yticklabel',{''},'FontWeight','bold','FontSize',22);
% % set(gca,'xticklabel',{'120W','60W','0','60E','120E'},'FontWeight','bold','FontSize',22);
% % set(gca,'yticklabel',{'30S','0','30N','60N'},'FontWeight','bold','FontSize',22);
% 
% Color=phenocolor();
% colormap(Color);
% caxis([Thres1 Thres2]);
% 
% % set nan values to transparent
% AlphaData=~isnan(Class);
% set(ObjImage,'alphadata',AlphaData)
% set(gca,'color','white');
% 
% geoshow([WorldShape.Lat],[WorldShape.Lon],'Color',[0.709 0.709 0.709],'LineStyle','-','LineWidth',1.0);
% 
% Hbar=colorbar('Location','SouthoutSide');
% Pos=get(Hbar,'Position');
% Pos=[Pos(1)+0.16 Pos(2)-0.09 Pos(3)-0.32 Pos(4)]; 
% 
% set(Hbar,'Position',Pos,'FontWeight','bold','Fontname','Times New Roman','FontSize',32); 
% set(Hbar,'xlim',[Thres1 Thres2]);
% set(Hbar,'Xtick',Thres1:50:Thres2);
% TickLabel=cellstr(num2str(get(Hbar,'XTick')','%.0f'));
% TickLabel{1  }='0';
% TickLabel{end}='365';
% set(Hbar,'XTickLabel',TickLabel);
% 
% pause(5); set(gcf,'position',[100 100 1200 600],'defaultAxesFontSize',12);  
% 
% 
% text('String',[' MODIS ','(',CaptName,')'],'Units','Normalized','Position',[0.02 0.24],'FontWeight','bold','Fontname','Times New Roman','Fontsize',40);
% text('String',[' Year ', YearName],'Units','Normalized','Position',[0.02 0.12],'FontWeight','bold','Fontname','Times New Roman','Fontsize',40);
% text('String','day','Units','Normalized','Position',[0.85 -0.09],'FontWeight','bold','Fontname','Times New Roman','Fontsize',38);
% 
% print(Fig,'-dtiff','-r300',[Path_Figure,'OBS',YPHNName,YearName,'.tif']);close(Fig);
% 
     end
%      
%      
%         for I_YPHNB = 1: numel(YPHNListB)
% 
%             YPHNNameB  = YPHNListB{I_YPHNB};                       
%             CaptNameB  = CaptListB{I_YPHNB};
%  
%             
%             [Bio12YPHN,R]= geotiffread([Path_Bio12YPHN,'Bio12',YPHNNameB,'.A',YearName,'001.006.tif']); 
% 
%             Thres1 = 0;
%             Thres2 = 365;
%             
%             Class=Bio12YPHN;
%             Class(Class<0 | Class>365)=nan;
% 
%             % plot figure
%             Fig=figure;set(gcf,'position',[100 100 1200 600],'defaultAxesFontSize',12);  
%             set(gca, 'visible', 'off');
% 
%             % background
%             Background=zeros(size(Landcover));
%             Background(Landcover==12 | Landcover==14 | Landcover==15 | Landcover==16)=2; 
%             ObjImage=grid2image(Background,R);
%             colormap([1 1 1; 0.3 0.3 0.3]);hold on;
%             set(ObjImage,'alphadata',0.2);
%             freezeColors;
% 
%             % foreground
%             ObjImage=grid2image(Class,R);
% 
%             set(gca,'visible', 'on','color','none');
%             set(gca,'Units','Pixels','Position',[25 80 1170 520]);box on;hold on; 
%             set(gca,'xlim',[-180 180],'ylim',[-65 90]);
%             set(gca,'xtick',-120:60:120,'ytick',-30:30:60);
%             set(gca,'xlabel',[],'ylabel',[]);
%             set(gca,'xticklabel',{''},'FontWeight','bold','FontSize',22);
%             set(gca,'yticklabel',{''},'FontWeight','bold','FontSize',22);
%  
%             Color=phenocolor();
%             colormap(Color);
%             caxis([Thres1 Thres2]);
% 
%             % set nan values to transparent
%             AlphaData=~isnan(Class);
%             set(ObjImage,'alphadata',AlphaData)
%             set(gca,'color','white');
% 
%             geoshow([WorldShape.Lat],[WorldShape.Lon],'Color',[0.709 0.709 0.709],'LineStyle','-','LineWidth',1.0);
% 
%             Hbar=colorbar('Location','SouthoutSide');
%             Pos=get(Hbar,'Position');
%             Pos=[Pos(1)+0.16 Pos(2)-0.09 Pos(3)-0.32 Pos(4)]; 
% 
%             set(Hbar,'Position',Pos,'FontWeight','bold','Fontname','Times New Roman','FontSize',32); 
%             set(Hbar,'xlim',[Thres1 Thres2]);
%             set(Hbar,'Xtick',Thres1:50:Thres2);
%             TickLabel=cellstr(num2str(get(Hbar,'XTick')','%.0f'));
%             TickLabel{1  }='0';
%             TickLabel{end}='365';
%             set(Hbar,'XTickLabel',TickLabel);
% 
%             pause(5); set(gcf,'position',[100 100 1200 600],'defaultAxesFontSize',12);  
% 
%             text('String',[' Biome-BGC ','(',CaptNameB,')'],'Units','Normalized','Position',[0.02 0.24],'FontWeight','bold','Fontname','Times New Roman','Fontsize',40);
%             text('String',[' Year ', YearName],'Units','Normalized','Position',[0.02 0.12],'FontWeight','bold','Fontname','Times New Roman','Fontsize',40);
%             text('String','day','Units','Normalized','Position',[0.85 -0.09],'FontWeight','bold','Fontname','Times New Roman','Fontsize',38);
% 
%             print(Fig,'-dtiff','-r300',[Path_Figure,'Bio',YPHNNameB,YearName,'.tif']);close(Fig);
% 
%       end
     
     
     
     disp(['Done',YearName]);

end


