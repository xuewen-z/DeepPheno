clear;

Path_LandCover = '../input/';
Path_TypYPHN = '../output/13_TypYPHN/' 
Path_CNN12YPHN = '../output/14_CNN12YPHN/' 

system(['rm -rf   ',Path_CNN12YPHN]);
system(['mkdir -p ',Path_CNN12YPHN]);

[Landcover,R] = geotiffread([Path_LandCover,'LCT_Mul_CMG025_USGS.tif']);  %Landcover坐标

% 2001-2015 phenology
YearBgn = 2001;
YearEnd = 2015;
YearNum = numel(YearBgn:YearEnd);

VegeList= {'SD','DV','EV'};
YPHNList = {'SPR','SUM','AUT','WIN'};


for SiteYear = 2001 : 2015
    YearName = num2str(SiteYear,'%d');
    
      
     for I_YPHN = 1: numel(YPHNList)

            YPHNName  = YPHNList{I_YPHN};                       
            PreYPHN = zeros(R.RasterSize);
            
        for I_Vege = 1: numel(VegeList)

            VegeName  = VegeList{I_Vege}; 
    
            FileName = dir([Path_TypYPHN,'*',VegeName,YPHNName,'.A',YearName,'.tif']);
            Tempor = geotiffread(fullfile(FileName.folder,FileName.name));   
            PreYPHN = PreYPHN + Tempor;
        end
            PreYPHN(Landcover==0 | Landcover==15 | Landcover==16 |...
            Landcover==11 | Landcover==12 |Landcover==13 | Landcover==14)=nan;
            
        % edge value missing
            PreYPHN(PreYPHN==0)=nan;
        
    %% geotiffwrite

    RefeName=[Path_LandCover,'LCT_Mul_CMG025_USGS.tif']; 

    [~,R]= geotiffread(RefeName);
    Proj = geotiffinfo(RefeName);

    [GridLon,GridLat]=pixcenters(Proj);
    [LonMesh,LatMesh]=meshgrid(GridLon,GridLat); %坐标

    geotiffwrite([Path_CNN12YPHN,'CNN12',YPHNName,'.A',YearName,'001.006.tif'],PreYPHN,R,'GeoKeyDirectoryTag',...
    Proj.GeoTIFFTags.GeoKeyDirectoryTag,'TiffTags',struct('Compression',Tiff.Compression.Deflate));
 
    disp([YearName,'/',YPHNName]);

        
     end
end
 
     