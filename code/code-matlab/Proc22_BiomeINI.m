
clc; clear;

Path_GlobDEM = '../input/';
Path_Soil2TIF = '../output/20_Soil2TIF/';
Path_BiomeINI = '../output/22_BiomeINI/';

% system(['rm -rf ',Path_BiomeINI]);
% system(['mkdir -p ',Path_BiomeINI]);

% geoinformation
RefeName='../input/LCT_Mul_CMG025_USGS.tif';
[Landcover,R]= geotiffread(RefeName);
Proj = geotiffinfo(RefeName);

[GridLon,GridLat]=pixcenters(Proj);
[LonMesh,LatMesh]=meshgrid(GridLon,GridLat);

Landcover = double(Landcover);

% input variable  
% GlobSAND = round(geotiffread([Path_Soil2TIF,'Global.SAND1.CMG25KM.tif']),0);
GlobSILT = round(geotiffread([Path_Soil2TIF,'Global.SILT1.CMG25KM.tif']),0);
GlobCLAY =round(geotiffread([Path_Soil2TIF,'Global.CLAY1.CMG25KM.tif']),0);
GlobSAND = 100 - GlobCLAY - GlobSILT;
GlobDEM = double(geotiffread([Path_GlobDEM,'Global.DEM.CMG25KM.tif']));

%% DV TYPE
% LogicDV =(Landcover ==3 | Landcover ==4| Landcover ==5);
% IndDV = find(LogicDV);
% 
% DVSAND = GlobSAND(IndDV);
% DVSILT = GlobSILT(IndDV);
% DVCLAY = GlobCLAY(IndDV);
% DVDEM = GlobDEM(IndDV);
% DVLat= LatMesh(IndDV);
% 
% %DV  ini input variables 
% BiomeINI=[DVSAND,DVSILT,DVCLAY,DVDEM,DVLat];
% 
% 
% [m,n] = find(isnan(BiomeINI));
% m = unique(m);
% BiomeINI(m,:)=[];
% 
% Indnan = IndDV(m);
% IndexDV = setdiff(IndDV,Indnan);  
% 
% save([Path_BiomeINI,'BiomeINI_DV.mat'],'-regexp','^Biome*','^Index*');

%% SD TYPE
LogicSD =(Landcover ==6| Landcover == 7 |Landcover == 8 | Landcover == 9 | Landcover == 10 );
IndSD = find(LogicSD);

SDSAND = GlobSAND(IndSD);
SDSILT = GlobSILT(IndSD);
SDCLAY = GlobCLAY(IndSD);
SDDEM = GlobDEM(IndSD);
SDLat= LatMesh(IndSD);

BiomeINI=[SDSAND,SDSILT,SDCLAY,SDDEM,SDLat];

[m,n] = find(isnan(BiomeINI));
m = unique(m);
BiomeINI(m,:)=[];

Indnan = IndSD(m);
IndexSD = setdiff(IndSD,Indnan);  

save([Path_BiomeINI,'BiomeINI_SD.mat'],'-regexp','^Biome*','^Index*');





