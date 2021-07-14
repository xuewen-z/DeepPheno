
addpath(genpath('./'));
clear; clc; 

Path_SoilNC = '../input/SoilTexture/';
Path_Soil2TIF = '../output/20_Soil2TIF/';

system(['rm -rf ',Path_Soil2TIF]);
system(['mkdir -p ',Path_Soil2TIF]);

SoilList ={'SAND1','CLAY1','SILT1'};

for  I_Soil= 1: numel(SoilList)
     SoilType = SoilList{I_Soil};
    
     FileName = [Path_SoilNC,SoilType,'.nc'];
     ncinf = ncinfo(FileName);
     Tempor = ncread(FileName,ncinf.Variables(4).Name);

     SoilName=rot90(Tempor(:,:,4)); 
     SoilName=flipud(SoilName);
     SoilName(SoilName < 0)=nan;
     
     SizeInfo = size(SoilName);
     
     lon = double(ncread(FileName,ncinf.Variables(1).Name));
     lat = double(ncread(FileName,ncinf.Variables(2).Name));

%      geotiff write

    R = georasterref('RasterSize',SizeInfo,'Latlim',[min(lat),max(lat)],...
        'Lonlim',[min(lon),max(lon)]);
    R.ColumnsStartFrom = 'north';
    FileName =[Path_Soil2TIF,'Global.',SoilType,'.CMG1KM.tif'];
    geotiffwrite(FileName,SoilName,R,'TiffTags',struct('Compression',Tiff.Compression.Deflate));

end


