clear;clc;

Path_GlobPredic = '/home/xuewen/Python/predict/Pre_GlobCNN_SDWIN/';
Path_LandCover = '../input/';
Path_TypYPHN = '../output/13_TypYPHN/' 

% system(['rm -rf   ',Path_TypYPHN]);
% system(['mkdir -p ',Path_TypYPHN]);

[Landcover,R] = geotiffread([Path_LandCover,'LCT_Mul_CMG025_USGS.tif']);  %Landcover坐标

VegeName = 'SD';
YPHNName ='WIN';
Name = strcat(VegeName,YPHNName);


for SiteYear = 2001 : 2015
    YearName = num2str(SiteYear,'%d');

    FileList = dir([Path_GlobPredic,'GlobCNN_A',YearName,'*.csv']);

    GlobYPHN = [];

    for I_File= 1:numel(FileList)
        FileName = strcat([Path_GlobPredic,FileList(I_File).name]);
        TmpData  = dlmread(FileName);
        GlobYPHN = [GlobYPHN;TmpData];
    end

    TypYPHN=reshape(GlobYPHN,600,1440);
    TypYPHN=round(TypYPHN,0);
    
    TypYPHN(TypYPHN<0) = 0;
    TypYPHN(TypYPHN>365)= 365;

    % SD type
    TypYPHN(Landcover==1 | Landcover==2 | Landcover == 3 | Landcover == 4| Landcover == 5)= 0;


    % DV type
%     TypYPHN(Landcover==1 | Landcover==2  | Landcover == 6 |...
%       Landcover == 7 | Landcover == 8 | Landcover == 9 | Landcover == 10)= 0;

    % EV type
%     TypYPHN(Landcover==3 | Landcover==4 | Landcover == 5 | Landcover == 6 |...
%     Landcover == 7 | Landcover == 8 | Landcover == 9 | Landcover == 10)=0;
    


%% geotiffwrite

    RefeName=[Path_LandCover,'LCT_Mul_CMG025_USGS.tif']; 

    [~,R]= geotiffread(RefeName);
    Proj = geotiffinfo(RefeName);

    [GridLon,GridLat]=pixcenters(Proj);
    [LonMesh,LatMesh]=meshgrid(GridLon,GridLat); %坐标


    geotiffwrite([Path_TypYPHN,'PreY',Name,'.A',YearName,'.tif'],TypYPHN,R,'GeoKeyDirectoryTag',...
    Proj.GeoTIFFTags.GeoKeyDirectoryTag,'TiffTags',struct('Compression',Tiff.Compression.Deflate));
 
    disp([YearName]);
end
