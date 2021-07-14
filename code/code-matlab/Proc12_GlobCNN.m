
clear; clc;

Path_GLDASNOAH = '../input/GLDAS_NOAH025_D_V02C/';
Path_ClmatMAX = '../output/07_ClmatMAX/';
Path_StatFeat= '../output/09_StatFeat/';
% Path_GlobCNN  = '../output/12_GlobCNN/';
Path_GlobCNN  = '/media/xuewen/Datause/12_GlobCNN/';

system(['rm -rf   ', Path_GlobCNN]);
system(['mkdir -p ', Path_GlobCNN]);

load([Path_ClmatMAX,'ClmatMAX.A2008.mat']);
load([Path_StatFeat,'GlobStatic.A2008.mat']);


% geo-information
RefeName='../input/LCT_Mul_CMG025_USGS.tif'; 
 
[~,R] = geotiffread(RefeName);
Proj  = geotiffinfo(RefeName);

PixelNum = prod(R.RasterSize);

% initialize
GlobAtmpre=nan(PixelNum,365);
GlobPhotop=nan(PixelNum,365);
GlobPrecip=nan(PixelNum,365);
GlobSpehum=nan(PixelNum,365);
GlobShorad=nan(PixelNum,365);
GlobTemavg=nan(PixelNum,365);
GlobTemmax=nan(PixelNum,365);
GlobTemmin=nan(PixelNum,365);
GlobVapdef=nan(PixelNum,365);
GlobWinspd=nan(PixelNum,365);

% read data

for Year=2001:2015
    
    YearName = num2str(Year,'%d');

    parfor Date=1:365
        DateName = num2str(Date,'%03d');
        
        FileName = dir([Path_GLDASNOAH,YearName,'/*Atmpre*',YearName,DateName,'*.tif']);
        GLDAS = geotiffread(fullfile(FileName.folder,FileName.name));
        GlobAtmpre(:,Date) = GLDAS(:);

        FileName = dir([Path_GLDASNOAH,YearName,'/*Photop*',YearName,DateName,'*.tif']);
        GLDAS = geotiffread(fullfile(FileName.folder,FileName.name));
        GlobPhotop(:,Date) = GLDAS(:);

        FileName = dir([Path_GLDASNOAH,YearName,'/*Precip*',YearName,DateName,'*.tif']);
        GLDAS = geotiffread(fullfile(FileName.folder,FileName.name));
        GlobPrecip(:,Date) = GLDAS(:);
        
        FileName = dir([Path_GLDASNOAH,YearName,'/*Spehum*',YearName,DateName,'*.tif']);
        GLDAS = geotiffread(fullfile(FileName.folder,FileName.name));
        GlobSpehum(:,Date) = GLDAS(:);

        
        FileName = dir([Path_GLDASNOAH,YearName,'/*Shorad*',YearName,DateName,'*.tif']);
        GLDAS = geotiffread(fullfile(FileName.folder,FileName.name));
        GlobShorad(:,Date) = GLDAS(:);

        FileName = dir([Path_GLDASNOAH,YearName,'/*Temavg*',YearName,DateName,'*.tif']);
        GLDAS = geotiffread(fullfile(FileName.folder,FileName.name));
        GlobTemavg(:,Date) = GLDAS(:);

        FileName = dir([Path_GLDASNOAH,YearName,'/*Temmax*',YearName,DateName,'*.tif']);
        GLDAS = geotiffread(fullfile(FileName.folder,FileName.name));
        GlobTemmax(:,Date) = GLDAS(:);

        
        FileName = dir([Path_GLDASNOAH,YearName,'/*Temmin*',YearName,DateName,'*.tif']);
        GLDAS = geotiffread(fullfile(FileName.folder,FileName.name));
        GlobTemmin(:,Date) = GLDAS(:);

        FileName = dir([Path_GLDASNOAH,YearName,'/*Vapdef*',YearName,DateName,'*.tif']);
        GLDAS = geotiffread(fullfile(FileName.folder,FileName.name));
        GlobVapdef(:,Date) = GLDAS(:);

        FileName = dir([Path_GLDASNOAH,YearName,'/*Winspd*',YearName,DateName,'*.tif']);
        GLDAS = geotiffread(fullfile(FileName.folder,FileName.name));
        GlobWinspd(:,Date) = GLDAS(:);
    
        disp([YearName,'/',DateName]);
    end
    
    GlobYPHN = ones(PixelNum,1);
    
%        normalization
    GlobAtmpre= (GlobAtmpre-MinAtmpre)./(MaxAtmpre-MinAtmpre);
    GlobAtmpre(GlobAtmpre>1) =1;GlobAtmpre(GlobAtmpre<0) =0;

    GlobPhotop= (GlobPhotop-MinPhotop)./(MaxPhotop-MinPhotop);
    GlobPhotop(GlobPhotop>1) =1;GlobPhotop(GlobPhotop<0) =0;

    GlobPrecip= (GlobPrecip-MinPrecip)./(MaxPrecip-MinPrecip);
    GlobPrecip(GlobPrecip>1) =1;GlobPrecip(GlobPrecip<0) =0;

    GlobSpehum= (GlobSpehum-MinSpehum)./(MaxSpehum-MinSpehum);
    GlobSpehum(GlobSpehum>1) =1;GlobSpehum(GlobSpehum<0) =0;

    GlobShorad= (GlobShorad-MinShorad)./(MaxShorad-MinShorad);
    GlobShorad(GlobShorad>1) =1;GlobShorad(GlobShorad<0) =0;

    GlobTemavg= (GlobTemavg-MinTemavg)./(MaxTemavg-MinTemavg);
    GlobTemavg(GlobTemavg>1) =1;GlobTemavg(GlobTemavg<0) =0;

    GlobTemmax= (GlobTemmax-MinTemmax)./(MaxTemmax-MinTemmax);
    GlobTemmax(GlobTemmax>1) =1;GlobTemmax(GlobTemmax<0) =0;

    GlobTemmin= (GlobTemmin-MinTemmin)./(MaxTemmin-MinTemmin);
    GlobTemmin(GlobTemmin>1) =1;GlobTemmin(GlobTemmin<0) =0;

    GlobVapdef= (GlobVapdef-MinVapdef)./(MaxVapdef-MinVapdef);
    GlobVapdef(GlobVapdef>1) =1;GlobVapdef(GlobVapdef<0) =0;

    GlobWinspd= (GlobWinspd-MinWinspd)./(MaxWinspd-MinWinspd);
    GlobWinspd(GlobWinspd>1) =1;GlobWinspd(GlobWinspd<0) =0;


    
%     global meteorology data
    GlobCNN=[GlobYPHN,GlobAtmpre,GlobPhotop,GlobPrecip,GlobSpehum,...
        GlobShorad,GlobTemavg,GlobTemmax,GlobTemmin,GlobVapdef,GlobWinspd,GlobDEM,GlobSAND,GlobCLAY,GlobSILT];

%     save subset CNN data
    for Index = 1:50000:size(GlobCNN,1)
        
        SubsCNN=GlobCNN(Index:min(50000+Index-1,size(GlobCNN,1)),:);
        Header = 0:5110;
        
        % write data
        writematrix([Header;SubsCNN],[Path_GlobCNN,'GlobCNN_A',YearName,'_I',num2str(Index,'%08d'),'.csv']);
%         save([Path_GlobeCNN,'GloMetCNN_A',YearName,'_I',num2str(Index,'%08d'),'.mat'],'SubMetCNN');
    end
end
