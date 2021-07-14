
clc;clear;
addpath(genpath('./'));

Path_LandCover = '../input/';
Path_TAVG12IND = '../output/17_TAVG12IND/'; 
Path_TAVG12VAR = '../output/18_TAVG12VAR/'; 

system(['rm -rf   ',Path_TAVG12VAR]);
system(['mkdir -p ',Path_TAVG12VAR]);

% 1) read data for OBS
RefeName=[Path_LandCover,'LCT_Mul_CMG025_USGS.tif']; 
[~,R]= geotiffread(RefeName);
Proj = geotiffinfo(RefeName);

    ObsAVGSPR = geotiffread([Path_TAVG12IND,'Obs12AVG.SPR.2001.2015.tif']);
    
    ObsAVGSUM = geotiffread([Path_TAVG12IND,'Obs12AVG.SUM.2001.2015.tif']);
    
    ObsAVGAUT = geotiffread([Path_TAVG12IND,'Obs12AVG.AUT.2001.2015.tif']);
    
    ObsAVGWIN = geotiffread([Path_TAVG12IND,'Obs12AVG.WIN.2001.2015.tif']);
    
    ObsVARSPR = abs(ObsAVGSUM - ObsAVGSPR); 
    ObsVARAUT = abs(ObsAVGWIN - ObsAVGAUT);


    FileName=['ObsVARSPR.2001.2015.tif'];
    geotiffwrite([Path_TAVG12VAR,FileName],ObsVARSPR,R,'GeoKeyDirectoryTag',...
        Proj.GeoTIFFTags.GeoKeyDirectoryTag,'TiffTags',struct('Compression',Tiff.Compression.Deflate));


    FileName=['ObsVARAUT.2001.2015.tif'];
    geotiffwrite([Path_TAVG12VAR,FileName],ObsVARAUT,R,'GeoKeyDirectoryTag',...
        Proj.GeoTIFFTags.GeoKeyDirectoryTag,'TiffTags',struct('Compression',Tiff.Compression.Deflate));


    CnnAVGSPR = geotiffread([Path_TAVG12IND,'Cnn12AVG.SPR.2001.2015.tif']);
    
    CnnAVGSUM = geotiffread([Path_TAVG12IND,'Cnn12AVG.SUM.2001.2015.tif']);
    
    CnnAVGAUT = geotiffread([Path_TAVG12IND,'Cnn12AVG.AUT.2001.2015.tif']);
    
    CnnAVGWIN = geotiffread([Path_TAVG12IND,'Cnn12AVG.WIN.2001.2015.tif']);
    
    CnnVARSPR = abs(CnnAVGSUM - CnnAVGSPR); 
    CnnVARAUT = abs(CnnAVGWIN - CnnAVGAUT);


%     % write data
    FileName=['CnnVARSPR.2001.2015.tif'];
    geotiffwrite([Path_TAVG12VAR,FileName],CnnVARSPR,R,'GeoKeyDirectoryTag',...
        Proj.GeoTIFFTags.GeoKeyDirectoryTag,'TiffTags',struct('Compression',Tiff.Compression.Deflate));


    FileName=['CnnVARAUT.2001.2015.tif'];
    geotiffwrite([Path_TAVG12VAR,FileName],CnnVARAUT,R,'GeoKeyDirectoryTag',...
        Proj.GeoTIFFTags.GeoKeyDirectoryTag,'TiffTags',struct('Compression',Tiff.Compression.Deflate));
