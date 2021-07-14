
clear ;clc;
addpath(genpath('./'));

Path_GLDASNOAH = '../input/GLDAS_NOAH025_D_V02C/';
Path_BiomeINI = '../output/22_BiomeINI/';
Path_BiomeMET = '../output/23_BiomeMET/';

% system(['rm -rf ',Path_BiomeMET]);
% system(['mkdir -p ',Path_BiomeMET]);

load([Path_BiomeINI,'BiomeINI_SD.mat']);

VegeName = 'SD';
VegeIndx = IndexSD;
DayList = repmat([1:365]',1,1);

for Year = 2001:2015
    YearName = num2str(Year,'%d');
      
    PixelNum = 1:365;
    YearList(PixelNum,1) =Year; 
    
    parfor Date =1:365
        DateName = num2str(Date,'%03d');
        
        FileName =dir([Path_GLDASNOAH,YearName,'/*Temmax*',YearName,DateName,'*.tif']);
        GLDAS = geotiffread(fullfile(FileName.folder,FileName.name));
        GlobTemmax(:,Date) = GLDAS(VegeIndx);
                
        FileName =dir([Path_GLDASNOAH,YearName,'/*Temmin*',YearName,DateName,'*.tif']);
        GLDAS = geotiffread(fullfile(FileName.folder,FileName.name));
        GlobTemmin(:,Date) = GLDAS(VegeIndx);
        
        FileName =dir([Path_GLDASNOAH,YearName,'/*Temavg*',YearName,DateName,'*.tif']);
        GLDAS = geotiffread(fullfile(FileName.folder,FileName.name));
        GlobTemavg(:,Date) = GLDAS(VegeIndx);
        
        FileName =dir([Path_GLDASNOAH,YearName,'/*Precip*',YearName,DateName,'*.tif']);
        GLDAS = geotiffread(fullfile(FileName.folder,FileName.name));
        GlobPrecip(:,Date) = GLDAS(VegeIndx);
        
        FileName =dir([Path_GLDASNOAH,YearName,'/*Vapdef*',YearName,DateName,'*.tif']);
        GLDAS = geotiffread(fullfile(FileName.folder,FileName.name));
        GlobVapdef(:,Date) = GLDAS(VegeIndx);
        
        FileName =dir([Path_GLDASNOAH,YearName,'/*Shorad*',YearName,DateName,'*.tif']);
        GLDAS = geotiffread(fullfile(FileName.folder,FileName.name));
        GlobShorad(:,Date) = GLDAS(VegeIndx);
        
        FileName =dir([Path_GLDASNOAH,YearName,'/*Photop*',YearName,DateName,'*.tif']);
        GLDAS = geotiffread(fullfile(FileName.folder,FileName.name));
        GlobPhotop(:,Date) = GLDAS(VegeIndx);
        
        disp([YearName,'/',DateName]);
    end
      
        GlobPhotop = round((GlobPhotop .* 3600),0); % hours to seconds
        GlobVapdef = GlobVapdef .* 1000; % KPa to Pa
        GlobPrecip = GlobPrecip .* 0.1; % mm to cm
        GlobShorad = GlobShorad .* 86400./3600; % Daylight shortwave
   
  
     for pixel = 1: numel(GlobPhotop(:,1))      
        
         SubMET(:,:,pixel) =[YearList,DayList,GlobTemmax(pixel,:)',GlobTemmin(pixel,:)',GlobTemavg(pixel,:)',GlobPrecip(pixel,:)',...
         GlobVapdef(pixel,:)',GlobShorad(pixel,:)',GlobPhotop(pixel,:)'];
   
     end
          save([Path_BiomeMET,VegeName,'SubMET.',YearName,'.mat'],'-regexp','SubMET','^Ind*');

 
end


  

