addpath(genpath('./'));

Path_Figure  = '../figure/';
Path_LandCover = '../input/';
Path_TAVG12IND = '../output/17_TAVG12IND/'; 

% read data
[Landcover,R] = geotiffread([Path_LandCover,'LCT_Mul_CMG025_USGS.tif']);  %Landcover坐标
Landcover=double(Landcover);

YPHNList = {'WIN'};  
CaptList ={'dormancy'}; 
% YPHNList = {'SPR'};  
% CaptList ={'green-up'}; 

for I_YPHN = 1: numel(YPHNList)
    YPHNName = YPHNList{I_YPHN};  
    CaptName = CaptList{I_YPHN};

CPHN12AVG=geotiffread([Path_TAVG12IND,'Cnn12AVG.',YPHNName,'.2001.2015.tif']);
OPHN12AVG=geotiffread([Path_TAVG12IND,'Obs12AVG.',YPHNName,'.2001.2015.tif']);
BPHN12AVG=geotiffread([Path_TAVG12IND,'Bio12AVG.',YPHNName,'.2001.2015.tif']);

% processing
CPHN12AVG(CPHN12AVG<0)=nan;
OPHN12AVG(OPHN12AVG<0)=nan;
BPHN12AVG(BPHN12AVG<0)=nan;

Invalid= (Landcover==12 | Landcover==14 | Landcover==0 | Landcover==15 | Landcover==16);
CPHN12AVG(Invalid)=nan;
OPHN12AVG(Invalid)=nan;
BPHN12AVG(Invalid)=nan;

% initialization
Lower=(min(R.LatitudeLimits)+R.CellExtentInLatitude/2);
Upper=(max(R.LatitudeLimits)-R.CellExtentInLatitude/2);
MatrixLat=(Upper: -R.CellExtentInLatitude: Lower)';

Left =(min(R.LongitudeLimits)+R.CellExtentInLongitude/2);
Right=(max(R.LongitudeLimits)-R.CellExtentInLongitude/2);
MatrixLon=(Left: R.CellExtentInLongitude: Right)';

% data processing
STEP=1;
Lat=(-65:STEP:90)';

CPHN12Lat=nan(size(Lat));
OPHN12Lat=nan(size(Lat));
BPHN12Lat=nan(size(Lat));

CSTD12Lat=nan(size(Lat));
OSTD12Lat=nan(size(Lat));
BSTD12Lat=nan(size(Lat));

for I_Lat=1:numel(Lat)
    PixelLat = MatrixLat > Lat(I_Lat)-STEP/2 & MatrixLat < Lat(I_Lat)+STEP/2 ;
    
    Data=CPHN12AVG(PixelLat,:);
    CPHN12Lat(I_Lat)=nanmean(Data(:));
    CSTD12Lat(I_Lat)=nanstd(Data(:));
    
    Data=OPHN12AVG(PixelLat,:);
    OPHN12Lat(I_Lat)=nanmean(Data(:));  
    OSTD12Lat(I_Lat)=nanstd(Data(:));
    
    Data=BPHN12AVG(PixelLat,:);
    BPHN12Lat(I_Lat)=nanmean(Data(:));  
    BSTD12Lat(I_Lat)=nanstd(Data(:));
    
end

% plot
Fig=figure;set(gcf,'position',[100 100 400 600],'defaultAxesFontSize',20);
set(gca,'Units','Pixels','Position',[60 85 300 510]);box on;hold on;

Color=[colormap(winter(20));colormap(summer(20));flipud(colormap(autumn(20)))];Color=Color(5:10:end,:);

H1=shadedErrorBar(Lat,OPHN12Lat,OSTD12Lat,'lineprops',{'-r','Color',[0.4509,0.6941,0.8823],'LineWidth',4},'transparent',1);
H2=shadedErrorBar(Lat,CPHN12Lat,CSTD12Lat,'lineprops',{'-r','Color',[0.9333,0.1843,0.2078],'LineWidth',4},'transparent',1);
H3=shadedErrorBar(Lat,BPHN12Lat,BSTD12Lat,'lineprops',{'-r','Color',[1,0.647,0.478],'LineWidth',4},'transparent',1);

set(gca,'xaxislocation','top');
set(gca,'xlim',[-65 90],'ylim',[0 365],'xtick',-30:30:60,'ytick',0:80:365);
set(gca,'xticklabel',{'30S','0','30N','60N'},'FontWeight','bold','Fontname','Times New Roman','FontSize',20);
ylabel([CaptName,' (day)'],'FontWeight','bold','Fontname','Times New Roman','Fontsize',26);

view([90 -90]);
xtickangle(90);  

Hlegend=legend([H1.mainLine,H2.mainLine,H3.mainLine],{'MODIS','1D-CNNR','Biome-BGC'}); legend boxoff;
set(Hlegend,'Units','Pixels','Position',[150 450 30 90],'FontWeight','bold','Fontname','Times New Roman','FontSize',20);
% winter [150 450 30 90]  SPR [150 450 235 90]

R1   = rvalue(CPHN12AVG,OPHN12AVG);
text('String',['r = ',num2str(R1,'%.2f')],'Color',[0.9333,0.1843,0.2078],...
    'Units','Normalized','Position',[0.5 0.12],'FontWeight','bold','Fontname','Times New Roman','Fontsize',28);
%winter [0.5 0.12]
%spr [0.1 0.12]
R2   = rvalue(BPHN12AVG,OPHN12AVG);
text('String',['r = ',num2str(R2,'%.2f')],'Color',[1,0.647,0.478],...
    'Units','Normalized','Position',[0.5 0.05],'FontWeight','bold','Fontname','Times New Roman','Fontsize',28);


text('String','d) ',...
    'Units','Normalized','Position',[0.08 0.93],'FontWeight','bold','Fontname','Times New Roman','Fontsize',28);

pause(5); set(gcf,'position',[100 100 400 600],'defaultAxesFontSize',14);  

print(Fig,'-dtiff','-r300',[Path_Figure,'Shaded',YPHNName,'.tif']);close(Fig);

end