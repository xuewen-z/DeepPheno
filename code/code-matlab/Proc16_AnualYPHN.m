clc;clear;

Path_LandCover = '../input/';
Path_CNN12YPHN = '../output/14_CNN12YPHN/'; 
Path_OBS12YPHN = '../output/15_OBS12YPHN/';
Path_Bio12YPHN = '../output/27_Bio12YPHN/';
Path_AnualYPHN = '../output/16_AnualYPHN/';

% system(['rm -rf '  ,Path_AnualYPHN]);
% system(['mkdir -p ',Path_AnualYPHN]);

YearBgn = 2001;
YearEnd = 2015;
YPHNList = {'SPR','SUM','AUT','WIN'};


% read data
RefeName=[Path_LandCover,'LCT_Mul_CMG025_USGS.tif']; 
[~,R]= geotiffread(RefeName);
Proj = geotiffinfo(RefeName);

% OYPHNDOY = nan([R.RasterSize,YearEnd-YearBgn+1]);
CYPHNDOY = nan([R.RasterSize,YearEnd-YearBgn+1]);
% BYPHNDOY = nan([R.RasterSize,YearEnd-YearBgn+1]);

% 1) processing
for I_YPHN = 1: numel(YPHNList)

    YPHNName  = YPHNList{I_YPHN}; 
	
    for Year=YearBgn:YearEnd
    
%         Tempor = geotiffread([Path_OBS12YPHN,'OBS12',YPHNName,'.A',num2str(Year),'001.006.tif']);
%         OYPHNDOY(:,:,Year-YearBgn+1)= Tempor;
% 
%         
        Tempor = geotiffread([Path_CNN12YPHN,'CNN12',YPHNName,'.A',num2str(Year),'001.006.tif']);
        CYPHNDOY(:,:,Year-YearBgn+1)= Tempor;
%              
        
%         Tempor = geotiffread([Path_Bio12YPHN,'Bio12',YPHNName,'.A',num2str(Year),'001.006.tif']);
%         BYPHNDOY(:,:,Year-YearBgn+1)= Tempor;

    end

    % write data
%         FileName=[Path_AnualYPHN,'OYPHNDOY.',YPHNName,'.',num2str(YearBgn),'.',num2str(YearEnd),'.tif'];
%         geotiffwrite(FileName,OYPHNDOY,R,'GeoKeyDirectoryTag',...
%         Proj.GeoTIFFTags.GeoKeyDirectoryTag,'TiffTags',struct('Compression',Tiff.Compression.Deflate));

    
        FileName=[Path_AnualYPHN,'CYPHNDOY.',YPHNName,'.',num2str(YearBgn),'.',num2str(YearEnd),'.tif'];
        geotiffwrite(FileName,CYPHNDOY,R,'GeoKeyDirectoryTag',...
        Proj.GeoTIFFTags.GeoKeyDirectoryTag,'TiffTags',struct('Compression',Tiff.Compression.Deflate));

    
%         FileName=[Path_AnualYPHN,'BYPHNDOY.',YPHNName,'.',num2str(YearBgn),'.',num2str(YearEnd),'.tif'];
%         geotiffwrite(FileName,BYPHNDOY,R,'GeoKeyDirectoryTag',...
%         Proj.GeoTIFFTags.GeoKeyDirectoryTag,'TiffTags',struct('Compression',Tiff.Compression.Deflate));

disp(['Done',YPHNName]);

end
