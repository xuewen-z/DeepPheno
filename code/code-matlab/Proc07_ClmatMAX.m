clear;
Path_GLDASNOAH = '../input/GLDAS_NOAH025_D_V02C/';
Path_ClmatMAX = '../output/07_ClmatMAX/';

system(['rm -rf   ', Path_ClmatMAX]);
system(['mkdir -p ', Path_ClmatMAX]);

% geo-information
RefeName='../input/LCT_Mul_CMG025_USGS.tif'; 
 
[~,R] = geotiffread(RefeName);
Proj  = geotiffinfo(RefeName);

PixelNum = prod(R.RasterSize);

% initialize
SiteAtmpre=nan(PixelNum,365);
SitePhotop=nan(PixelNum,365);
SitePrecip=nan(PixelNum,365);
SiteSpehum=nan(PixelNum,365);
SiteShorad=nan(PixelNum,365);
SiteTemavg=nan(PixelNum,365);
SiteTemmax=nan(PixelNum,365);
SiteTemmin=nan(PixelNum,365);
SiteVapdef=nan(PixelNum,365);
SiteWinspd=nan(PixelNum,365);

% read data
% for Year = 2001:2015
    Year = 2008
    YearName = num2str(Year,'%d');
      
    for Date=1:365
        DateName = num2str(Date,'%03d');
        
        FileName = dir([Path_GLDASNOAH,YearName,'/*Atmpre*',YearName,DateName,'*.tif']);
        GLDAS = geotiffread(fullfile(FileName.folder,FileName.name));
        SiteAtmpre(:,Date) = GLDAS(:);


        FileName = dir([Path_GLDASNOAH,YearName,'/*Photop*',YearName,DateName,'*.tif']);
        GLDAS = geotiffread(fullfile(FileName.folder,FileName.name));
        SitePhotop(:,Date) = GLDAS(:);

        FileName = dir([Path_GLDASNOAH,YearName,'/*Precip*',YearName,DateName,'*.tif']);
        GLDAS = geotiffread(fullfile(FileName.folder,FileName.name));
        SitePrecip(:,Date) = GLDAS(:);
        
        FileName = dir([Path_GLDASNOAH,YearName,'/*Spehum*',YearName,DateName,'*.tif']);
        GLDAS = geotiffread(fullfile(FileName.folder,FileName.name));
        SiteSpehum(:,Date) = GLDAS(:);
        
        FileName = dir([Path_GLDASNOAH,YearName,'/*Shorad*',YearName,DateName,'*.tif']);
        GLDAS = geotiffread(fullfile(FileName.folder,FileName.name));
        SiteShorad(:,Date) = GLDAS(:);

        FileName = dir([Path_GLDASNOAH,YearName,'/*Temavg*',YearName,DateName,'*.tif']);
        GLDAS = geotiffread(fullfile(FileName.folder,FileName.name));
        SiteTemavg(:,Date) = GLDAS(:);

        FileName = dir([Path_GLDASNOAH,YearName,'/*Temmax*',YearName,DateName,'*.tif']);
        GLDAS = geotiffread(fullfile(FileName.folder,FileName.name));
        SiteTemmax(:,Date) = GLDAS(:);

        
        FileName = dir([Path_GLDASNOAH,YearName,'/*Temmin*',YearName,DateName,'*.tif']);
        GLDAS = geotiffread(fullfile(FileName.folder,FileName.name));
        SiteTemmin(:,Date) = GLDAS(:);

        FileName = dir([Path_GLDASNOAH,YearName,'/*Vapdef*',YearName,DateName,'*.tif']);
        GLDAS = geotiffread(fullfile(FileName.folder,FileName.name));
        SiteVapdef(:,Date) = GLDAS(:);

        FileName = dir([Path_GLDASNOAH,YearName,'/*Winspd*',YearName,DateName,'*.tif']);
        GLDAS = geotiffread(fullfile(FileName.folder,FileName.name));
        SiteWinspd(:,Date) = GLDAS(:);
    
        disp([YearName,'/',DateName]);
    end
    
    MaxAtmpre = nanmax(SiteAtmpre(:));
    MinAtmpre = nanmin(SiteAtmpre(:));
           
    MaxPhotop = nanmax(SitePhotop(:));
    MinPhotop = nanmin(SitePhotop(:));   
    
    MaxPrecip = nanmax(SitePrecip(:));
    MinPrecip = nanmin(SitePrecip(:)); 
    
    MaxSpehum = nanmax(SiteSpehum(:));
    MinSpehum = nanmin(SiteSpehum(:));   
    
    MaxShorad = nanmax(SiteShorad(:));
    MinShorad = nanmin(SiteShorad(:));   
    
    MaxTemavg = nanmax(SiteTemavg(:));
    MinTemavg = nanmin(SiteTemavg(:)); 
    
    MaxTemmax = nanmax(SiteTemmax(:));
    MinTemmax = nanmin(SiteTemmax(:)); 
    
    MaxTemmin = nanmax(SiteTemmin(:));
    MinTemmin = nanmin(SiteTemmin(:));
    
    MaxVapdef = nanmax(SiteVapdef(:));
    MinVapdef = nanmin(SiteVapdef(:)); 
    
    MaxWinspd = nanmax(SiteWinspd(:));
    MinWinspd = nanmin(SiteWinspd(:)); 
 
      
 %     write data
    save([Path_ClmatMAX,'ClmatMAX.A',YearName,'.mat'],'-regexp','^Max*','^Min*');

   
  
