
addpath(genpath('./'));

Path_LandCover = '../input/';
Path_AnualYPHN = '../output/16_AnualYPHN/';
Path_TAVG12IND = '../output/17_TAVG12IND/'; 

% system(['rm -rf   ',Path_TAVG12IND]);
% system(['mkdir -p ',Path_TAVG12IND]);


% 1) read data for CNNPHN
RefeName=[Path_LandCover,'LCT_Mul_CMG025_USGS.tif']; 
[~,R]= geotiffread(RefeName);
Proj = geotiffinfo(RefeName);

% YPHNList = {'SPR','SUM','AUT','WIN'};
YPHNList = {'SPR','WIN'};
for I_YPHN = 1: numel(YPHNList)

    YPHNName  = YPHNList{I_YPHN};

    OYPHNDOY = geotiffread([Path_AnualYPHN,'OYPHNDOY.',YPHNName,'.2001.2015.tif']);
%     CYPHNDOY = geotiffread([Path_AnualYPHN,'CYPHNDOY.',YPHNName,'.2001.2015.tif']);
    BYPHNDOY = geotiffread([Path_AnualYPHN,'BYPHNDOY.',YPHNName,'.2001.2015.tif']);

% 2) processing average
        
    Obs12AVG = nanmean(OYPHNDOY,3);
%     Obs12AVG = round(Obs12AVG,0);
        
%     Cnn12AVG = nanmean(CYPHNDOY,3);
%     Cnn12AVG = round(Cnn12AVG,0);

    Bio12AVG = nanmean(BYPHNDOY,3);
%     Bio12AVG = round(Bio12AVG,0);

    % write data
    FileName=['Obs12AVG.',YPHNName,'.2001.2015.tif'];
    geotiffwrite([Path_TAVG12IND,FileName],Obs12AVG,R,'GeoKeyDirectoryTag',...
        Proj.GeoTIFFTags.GeoKeyDirectoryTag,'TiffTags',struct('Compression',Tiff.Compression.Deflate));

%     FileName=['Cnn12AVG.',YPHNName,'.2001.2015.tif'];
%     geotiffwrite([Path_TAVG12IND,FileName],Cnn12AVG,R,'GeoKeyDirectoryTag',...
%         Proj.GeoTIFFTags.GeoKeyDirectoryTag,'TiffTags',struct('Compression',Tiff.Compression.Deflate));

    FileName=['Bio12AVG.',YPHNName,'.2001.2015.tif'];
    geotiffwrite([Path_TAVG12IND,FileName],Bio12AVG,R,'GeoKeyDirectoryTag',...
        Proj.GeoTIFFTags.GeoKeyDirectoryTag,'TiffTags',struct('Compression',Tiff.Compression.Deflate));

    

 % 3)processing statistics Evaluate Index 
   
%  %% obs-cnn
%     
%     Cnn12NSE= nse3d(Obs12AVG,Cnn12AVG);
%     Cnn12RMSE=rmse3d(Obs12AVG,Cnn12AVG); 
%     Cnn12BIAS=mbe3d(Obs12AVG,Cnn12AVG);
%     
%     
%     % write data
%    FileName=['Cnn12NSE.',YPHNName,'.2001.2015.tif'];
%     geotiffwrite([Path_TAVG12IND,FileName],Cnn12NSE,R,'GeoKeyDirectoryTag',...
%         Proj.GeoTIFFTags.GeoKeyDirectoryTag,'TiffTags',struct('Compression',Tiff.Compression.Deflate)); 
%    FileName=['Cnn12RMSE.',YPHNName,'.2001.2015.tif'];
%     geotiffwrite([Path_TAVG12IND,FileName],Cnn12RMSE,R,'GeoKeyDirectoryTag',...
%         Proj.GeoTIFFTags.GeoKeyDirectoryTag,'TiffTags',struct('Compression',Tiff.Compression.Deflate));
%    FileName=['Cnn12BIAS.',YPHNName,'.2001.2015.tif'];
%     geotiffwrite([Path_TAVG12IND,FileName],Cnn12BIAS,R,'GeoKeyDirectoryTag',...
%         Proj.GeoTIFFTags.GeoKeyDirectoryTag,'TiffTags',struct('Compression',Tiff.Compression.Deflate));
% 
% 
    
 % obs-biom
    Bio12NSE= nse3d(Obs12AVG,Bio12AVG);
    Bio12RMSE=rmse3d(Obs12AVG,Bio12AVG); 
    Bio12BIAS=mbe3d(Obs12AVG,Bio12AVG);
    
    
    % write data
   FileName=['Bio12NSE.',YPHNName,'.2001.2015.tif'];
    geotiffwrite([Path_TAVG12IND,FileName],Bio12NSE,R,'GeoKeyDirectoryTag',...
        Proj.GeoTIFFTags.GeoKeyDirectoryTag,'TiffTags',struct('Compression',Tiff.Compression.Deflate)); 
   FileName=['Bio12RMSE.',YPHNName,'.2001.2015.tif'];
    geotiffwrite([Path_TAVG12IND,FileName],Bio12RMSE,R,'GeoKeyDirectoryTag',...
        Proj.GeoTIFFTags.GeoKeyDirectoryTag,'TiffTags',struct('Compression',Tiff.Compression.Deflate));
   FileName=['Bio12BIAS.',YPHNName,'.2001.2015.tif'];
    geotiffwrite([Path_TAVG12IND,FileName],Bio12BIAS,R,'GeoKeyDirectoryTag',...
        Proj.GeoTIFFTags.GeoKeyDirectoryTag,'TiffTags',struct('Compression',Tiff.Compression.Deflate));

 
 
disp(['Done with ',FileName]);


end
