clear;

addpath(genpath('./'));

Path_LandCover = '../input/';
Path_TAVG12IND = '../output/17_TAVG12IND/'; 
Path_Figure    = '../figure/';

WorldShape=shaperead('../misc/WorldCountry/world_country_boundary.shp','UseGeoCoords', true);
[Landcover,R] = geotiffread([Path_LandCover,'LCT_Mul_CMG025_USGS.tif']);  %Landcover坐标


YPHNList = {'SPR','SUM','AUT','WIN'};
CaptList ={'b)','b)','b)','b)'};
CaptList2={'green-up','maturation','senescence','dormancy'};


for I_YPHN = 1: numel(YPHNList)
    YPHNName = YPHNList{I_YPHN};  
    CaptName = CaptList{I_YPHN};
    CaptName2 = CaptList2{I_YPHN};
    
Thres1 = 0;
Thres2 = 365;

[CPHN12AVG,R]=geotiffread([Path_TAVG12IND,'Cnn12AVG.',YPHNName,'.2001.2015.tif']);

Class=CPHN12AVG;
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

set(Hbar,'Position',Pos,'FontWeight','bold','Fontname','Times New Roman','FontSize',30); 
set(Hbar,'xlim',[Thres1 Thres2]);
set(Hbar,'Xtick',Thres1:50:Thres2);
TickLabel=cellstr(num2str(get(Hbar,'XTick')','%.0f'));
TickLabel{1  }='0';
TickLabel{end}='365';
set(Hbar,'XTickLabel',TickLabel);

pause(5); set(gcf,'position',[100 100 1200 600],'defaultAxesFontSize',12);  

text('String',[CaptName,' 1D-CNNR ',CaptName2],'Units','Normalized','Position',[0.02 0.12],'FontWeight','bold','Fontname','Times New Roman','FontSize',34);
text('String','day','Units','Normalized','Position',[0.85 -0.10],'FontWeight','bold','Fontname','Times New Roman','FontSize',34);

print(Fig,'-dtiff','-r300',[Path_Figure,'ExtentC',YPHNName,'.tif']);close(Fig);

end


%% figure MOD12

CaptList ={'a)','a)','a)','a)'};

for I_YPHN = 1: numel(YPHNList)
    YPHNName = YPHNList{I_YPHN};  
    CaptName = CaptList{I_YPHN};
    CaptName2 = CaptList2{I_YPHN};

Thres1 = 0;
Thres2 = 365;

[OPHN12AVG,R]=geotiffread([Path_TAVG12IND,'Obs12AVG.',YPHNName,'.2001.2015.tif']);

Class1=OPHN12AVG;
Class1(Class1<0 | Class1>365)=nan;


Class1(Landcover==0 | Landcover==15 | Landcover==16 |...
Landcover==11 | Landcover==12 |Landcover==13 | Landcover==14)=nan;


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
ObjImage=grid2image(Class1,R);

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
AlphaData=~isnan(Class1);
set(ObjImage,'alphadata',AlphaData)
set(gca,'color','white');

geoshow([WorldShape.Lat],[WorldShape.Lon],'Color',[0.709 0.709 0.709],'LineStyle','-','LineWidth',1.0);

Hbar=colorbar('Location','SouthoutSide');
Pos=get(Hbar,'Position');
Pos=[Pos(1)+0.16 Pos(2)-0.09 Pos(3)-0.32 Pos(4)];  

set(Hbar,'Position',Pos,'FontWeight','bold','Fontname','Times New Roman','FontSize',30); 
set(Hbar,'xlim',[Thres1 Thres2]);
set(Hbar,'Xtick',Thres1:50:Thres2);
TickLabel=cellstr(num2str(get(Hbar,'XTick')','%.0f'));
TickLabel{1  }='0';
TickLabel{end}='365';
set(Hbar,'XTickLabel',TickLabel);

pause(5); set(gcf,'position',[100 100 1200 600],'defaultAxesFontSize',12);  

text('String',[CaptName,' MODIS ',CaptName2],'Units','Normalized','Position',[0.02 0.12],'FontWeight','bold','Fontname','Times New Roman','FontSize',34);
text('String','day','Units','Normalized','Position',[0.85 -0.10],'FontWeight','bold','Fontname','Times New Roman','FontSize',34);

print(Fig,'-dtiff','-r300',[Path_Figure,'ExtentO',YPHNName,'.tif']);close(Fig);


end 

  

YPHNList = {'SPR','WIN'};

CaptList ={'c)','c)'};
CaptList2 ={'green-up','dormancy'};


for I_YPHN = 1: numel(YPHNList)
    YPHNName = YPHNList{I_YPHN};  
    CaptName = CaptList{I_YPHN};
    CaptName2 = CaptList2{I_YPHN};
    
Thres1 = 0;
Thres2 = 365;

[BPHN12AVG,R]=geotiffread([Path_TAVG12IND,'Bio12AVG.',YPHNName,'.2001.2015.tif']);

Class=BPHN12AVG;
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

set(Hbar,'Position',Pos,'FontWeight','bold','Fontname','Times New Roman','FontSize',30); 
set(Hbar,'xlim',[Thres1 Thres2]);
set(Hbar,'Xtick',Thres1:50:Thres2);
TickLabel=cellstr(num2str(get(Hbar,'XTick')','%.0f'));
TickLabel{1  }='0';
TickLabel{end}='365';
set(Hbar,'XTickLabel',TickLabel);

pause(5); set(gcf,'position',[100 100 1200 600],'defaultAxesFontSize',12);  

text('String',[CaptName,' Biome-BGC ',CaptName2],'Units','Normalized','Position',[0.02 0.12],'FontWeight','bold','Fontname','Times New Roman','FontSize',34);
text('String','day','Units','Normalized','Position',[0.85 -0.10],'FontWeight','bold','Fontname','Times New Roman','FontSize',34);

print(Fig,'-dtiff','-r300',[Path_Figure,'ExtentB',YPHNName,'.tif']);close(Fig);

end


%% Combine
Fig1=imread([Path_Figure,'ExtentCSPR.tif']);
Fig2=imread([Path_Figure,'ExtentCSUM.tif']);
Fig3=imread([Path_Figure,'ExtentCAUT.tif']);
Fig4=imread([Path_Figure,'ExtentCWIN.tif']);

Fig5=imread([Path_Figure,'ExtentOSPR.tif']);
Fig6=imread([Path_Figure,'ExtentOSUM.tif']);
Fig7=imread([Path_Figure,'ExtentOAUT.tif']);
Fig8=imread([Path_Figure,'ExtentOWIN.tif']);

Fig9=imread([Path_Figure,'ExtentBSPR.tif']);
Fig10=imread([Path_Figure,'ExtentBWIN.tif']);


Fig=cat(1,cat(2,Fig5),cat(2,Fig1),cat(2,Fig9));
Fig=imresize(Fig,2244/size(Fig,2));
imwrite(Fig,[Path_Figure,'ExtentSPR.tif'],'Compression','LZW','Resolution',300);

Fig=cat(1,cat(2,Fig6),cat(2,Fig2));
Fig=imresize(Fig,2244/size(Fig,2));
imwrite(Fig,[Path_Figure,'ExtentSUM.tif'],'Compression','LZW','Resolution',300);

Fig=cat(1,cat(2,Fig7),cat(2,Fig3));
Fig=imresize(Fig,2244/size(Fig,2));
imwrite(Fig,[Path_Figure,'ExtentAUT.tif'],'Compression','LZW','Resolution',300);

Fig=cat(1,cat(2,Fig8),cat(2,Fig4),cat(2,Fig10));
Fig=imresize(Fig,2244/size(Fig,2));
imwrite(Fig,[Path_Figure,'ExtentWIN.tif'],'Compression','LZW','Resolution',300);



% 
% delete([Path_Figure,'ExtentCSPR.tif']);
% delete([Path_Figure,'ExtentCSUM.tif']);
% delete([Path_Figure,'ExtentCAUT.tif']);
% delete([Path_Figure,'ExtentCWIN.tif']);
% 
% delete([Path_Figure,'ExtentOSPR.tif']);
% delete([Path_Figure,'ExtentOSUM.tif']);
% delete([Path_Figure,'ExtentOAUT.tif']);
% delete([Path_Figure,'ExtentOWIN.tif']);
% 
% delete([Path_Figure,'ExtentBSPR.tif']);
% % delete([Path_Figure,'ExtentBSUM.tif']);
% % delete([Path_Figure,'ExtentBAUT.tif']);
% delete([Path_Figure,'ExtentBWIN.tif']);