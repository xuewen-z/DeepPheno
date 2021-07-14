% Minimum Temperature (K)
% Maximum Temperature (K)
% Average Temperature (K)
% Precipitation (mm/d)
% Surface Pressure (Pa)
% Downward short-wave radiation flux (w/m2)
% Specific humidity (kg/kg)
% Wind speed 10m (m/s)
% vapor pressure deficit (kPa)
% Daily sun hours (hours) 

clear;clc;

Path_ClmatMAX = '../output/07_ClmatMAX/';
Path_SiteYPHN = '../output/09_SiteYPHN/';
Path_GlobaLDAS = '../input/GLDAS_NOAH025_D_V02C/';
Path_SiteGLDAS = '../output/10_SiteGLDAS/';

system(['rm -rf   ', Path_SiteGLDAS]);
system(['mkdir -p ', Path_SiteGLDAS]);

% study year
SiteYear = 2008; 
YearName = num2str(SiteYear,'%d');

% read site information
load([Path_SiteYPHN,'SiteYPHN.A',YearName,'.mat']);
load([Path_ClmatMAX,'ClmatMAX.A',YearName,'.mat']);

% initialize
SiteAtmpre=nan(numel(SiteCode),365);
SitePhotop=nan(numel(SiteCode),365);
SitePrecip=nan(numel(SiteCode),365);
SiteSpehum=nan(numel(SiteCode),365);
SiteShorad=nan(numel(SiteCode),365);
SiteTemavg=nan(numel(SiteCode),365);
SiteTemmax=nan(numel(SiteCode),365);
SiteTemmin=nan(numel(SiteCode),365);
SiteVapdef=nan(numel(SiteCode),365);
SiteWinspd=nan(numel(SiteCode),365);

parfor Date=1:365
    DateName = num2str(Date,'%03d');

    FileName = dir([Path_GlobaLDAS,YearName,'/*Atmpre*',YearName,DateName,'*.tif']);
    GLDAS = geotiffread(fullfile(FileName.folder,FileName.name));
    SiteAtmpre(:,Date) = GLDAS(SiteInd);
   
    FileName = dir([Path_GlobaLDAS,YearName,'/*Photop*',YearName,DateName,'*.tif']);
    GLDAS = geotiffread(fullfile(FileName.folder,FileName.name));
    SitePhotop(:,Date) = GLDAS(SiteInd);

    FileName = dir([Path_GlobaLDAS,YearName,'/*Precip*',YearName,DateName,'*.tif']);
    GLDAS = geotiffread(fullfile(FileName.folder,FileName.name));
    SitePrecip(:,Date) = GLDAS(SiteInd);

    FileName = dir([Path_GlobaLDAS,YearName,'/*Spehum*',YearName,DateName,'*.tif']);
    GLDAS = geotiffread(fullfile(FileName.folder,FileName.name));
    SiteSpehum(:,Date) = GLDAS(SiteInd);

    FileName = dir([Path_GlobaLDAS,YearName,'/*Shorad*',YearName,DateName,'*.tif']);
    GLDAS = geotiffread(fullfile(FileName.folder,FileName.name));
    SiteShorad(:,Date) = GLDAS(SiteInd);

    FileName = dir([Path_GlobaLDAS,YearName,'/*Temavg*',YearName,DateName,'*.tif']);
    GLDAS = geotiffread(fullfile(FileName.folder,FileName.name));
    SiteTemavg(:,Date) = GLDAS(SiteInd);

    FileName = dir([Path_GlobaLDAS,YearName,'/*Temmax*',YearName,DateName,'*.tif']);
    GLDAS = geotiffread(fullfile(FileName.folder,FileName.name));
    SiteTemmax(:,Date) = GLDAS(SiteInd);

    FileName = dir([Path_GlobaLDAS,YearName,'/*Temmin*',YearName,DateName,'*.tif']);
    GLDAS = geotiffread(fullfile(FileName.folder,FileName.name));
    SiteTemmin(:,Date) = GLDAS(SiteInd);

    FileName = dir([Path_GlobaLDAS,YearName,'/*Vapdef*',YearName,DateName,'*.tif']);
    GLDAS = geotiffread(fullfile(FileName.folder,FileName.name));
    SiteVapdef(:,Date) = GLDAS(SiteInd);

    FileName = dir([Path_GlobaLDAS,YearName,'/*Winspd*',YearName,DateName,'*.tif']);
    GLDAS = geotiffread(fullfile(FileName.folder,FileName.name));
    SiteWinspd(:,Date) = GLDAS(SiteInd);

    disp([YearName,'/',DateName]);
end


% normalization
SiteAtmpre= (SiteAtmpre-MinAtmpre)./(MaxAtmpre-MinAtmpre);
SiteAtmpre(SiteAtmpre>1) =1;SiteAtmpre(SiteAtmpre<0) =0;

SitePhotop= (SitePhotop-MinPhotop)./(MaxPhotop-MinPhotop);
SitePhotop(SitePhotop>1) =1;SitePhotop(SitePhotop<0) =0;

SitePrecip= (SitePrecip-MinPrecip)./(MaxPrecip-MinPrecip);
SitePrecip(SitePrecip>1) =1;SitePrecip(SitePrecip<0) =0;

SiteSpehum= (SiteSpehum-MinSpehum)./(MaxSpehum-MinSpehum);
SiteSpehum(SiteSpehum>1) =1;SiteSpehum(SiteSpehum<0) =0;

SiteShorad= (SiteShorad-MinShorad)./(MaxShorad-MinShorad);
SiteShorad(SiteShorad>1) =1;SiteShorad(SiteShorad<0) =0;

SiteTemavg= (SiteTemavg-MinTemavg)./(MaxTemavg-MinTemavg);
SiteTemavg(SiteTemavg>1) =1;SiteTemavg(SiteTemavg<0) =0;

SiteTemmax= (SiteTemmax-MinTemmax)./(MaxTemmax-MinTemmax);
SiteTemmax(SiteTemmax>1) =1;SiteTemmax(SiteTemmax<0) =0;

SiteTemmin= (SiteTemmin-MinTemmin)./(MaxTemmin-MinTemmin);
SiteTemmin(SiteTemmin>1) =1;SiteTemmin(SiteTemmin<0) =0;

SiteVapdef= (SiteVapdef-MinVapdef)./(MaxVapdef-MinVapdef);
SiteVapdef(SiteVapdef>1) =1;SiteVapdef(SiteVapdef<0) =0;

SiteWinspd= (SiteWinspd-MinWinspd)./(MaxWinspd-MinWinspd);
SiteWinspd(SiteWinspd>1) =1;SiteWinspd(SiteWinspd<0) =0;

% write data
save([Path_SiteGLDAS,'SiteGLDAS.A',YearName,'.mat'],'-regexp','^Site*');
