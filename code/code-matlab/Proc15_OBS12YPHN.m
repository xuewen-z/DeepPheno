
Path_LandCover = '../input/';
Path_Geo12YPHN = '../output/06_Geo12YPHN/';
Path_OBS12YPHN = '../output/15_OBS12YPHN/'; 


system(['rm -rf   ',Path_OBS12YPHN]);
system(['mkdir -p ',Path_OBS12YPHN]);

[Landcover,R] = geotiffread([Path_LandCover,'LCT_Mul_CMG025_USGS.tif']);  
RefeName=[Path_LandCover,'LCT_Mul_CMG025_USGS.tif']; 


% 2001-2015 phenology
% YearBgn = 2001;
% YearEnd = 2015;
% YearNum = numel(YearBgn:YearEnd);
YPHNList = {'SPR','SUM','AUT','WIN'};
%     
% for I_YPHN = 1: numel(YPHNList)
% 
%     YPHNName  = YPHNList{I_YPHN}; 
% 	MPHN12AVG = 0;
%     
%     for  Year =  YearBgn : YearEnd
%             FileName = dir([Path_CNN12YPHN,'Pre*',YPHNName,'.A',num2str(Year),'001.006.tif']);
%             Tempor = geotiffread(fullfile(FileName.folder,FileName.name));   
%             MPHN12AVG = MPHN12AVG + Tempor;
%     end
%     
%     MPHN12AVG = MPHN12AVG / YearNum;
%     MPHN12AVG = round(MPHN12AVG,0);
%     
%     write data   
%     [~,R]= geotiffread(RefeName);
%     Proj = geotiffinfo(RefeName);
% 
%     FileName = [Path_CPHN12AVG,'MPHN12AVG.',YPHNName,'.',num2str(YearBgn),'.',num2str(YearEnd),'.tif'];
%     geotiffwrite(FileName,MPHN12AVG,R,'GeoKeyDirectoryTag',...
%     Proj.GeoTIFFTags.GeoKeyDirectoryTag,'TiffTags',struct('Compression',Tiff.Compression.Deflate));
%  
%     disp(['Done','/',YPHNName]);
% 
% end


for SiteYear = 2001 : 2015
    YearName = num2str(SiteYear,'%d');
    
    for I_YPHN = 1: numel(YPHNList)
        YPHNName  = YPHNList{I_YPHN}; 
    
            FileName = dir([Path_Geo12YPHN,'Geo*',YPHNName,'.A',YearName,'001.006.tif']);
            OBSYPHN = geotiffread(fullfile(FileName.folder,FileName.name));         
     
            OBSYPHN(Landcover==0 | Landcover==15 | Landcover==16 |...
            Landcover==11 | Landcover==12 |Landcover==13 | Landcover==14)=nan;
            

   %     write data   
    [~,R]= geotiffread(RefeName);
    Proj = geotiffinfo(RefeName);

    FileName = [Path_OBS12YPHN,'OBS12',YPHNName,'.A',YearName,'001.006.tif'];
    geotiffwrite(FileName,OBSYPHN,R,'GeoKeyDirectoryTag',...
    Proj.GeoTIFFTags.GeoKeyDirectoryTag,'TiffTags',struct('Compression',Tiff.Compression.Deflate));
 
    end
    
    disp(['Done','/',YearName]);
    
end

