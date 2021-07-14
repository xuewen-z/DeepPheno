
Path_LandCover = '../input/';
Path_BioPheno = '../output/26_BioPheno/';
Path_Bio12YPHN = '../output/27_Bio12YPHN/';


system(['rm -rf ',Path_Bio12YPHN]);
system(['mkdir -p ',Path_Bio12YPHN]);


load([Path_BioPheno,'Biopheno_SD.mat']);
load([Path_BioPheno,'Biopheno_DV.mat']);


RefeName = [Path_LandCover,'LCT_Mul_CMG025_USGS.tif'];
[~,R]= geotiffread(RefeName);
Proj = geotiffinfo(RefeName);

PixelNum = prod(R.RasterSize);
RefeNum = nan(PixelNum,1);

[m,n] = find(BioSDWIN ==-1);
Miss = unique(m);

BioSDSPR(Miss,:) = nan;
BioSDWIN(Miss,:) = nan;

for YearNum= 1:15
     SiteYear = 2000+YearNum;
     YearName = num2str(SiteYear,'%d');

     SDSPR = BioSDSPR(:,YearNum);
     DVSPR = BioDVSPR(:,YearNum);
 
     RefeNum(IndexSD) = SDSPR;
     RefeNum(IndexDV) = DVSPR;
     Bio12YSPR = reshape(RefeNum,600,1440);
     
     Bio12YSPR(361:600,:) = Bio12YSPR(361:600,:) + 182;
     NextInd = find(Bio12YSPR >365);
     Bio12YSPR(NextInd) = Bio12YSPR(NextInd)-365;

     
     SDWIN = BioSDWIN(:,YearNum);
     DVWIN = BioDVWIN(:,YearNum);

     RefeNum(IndexSD) = SDWIN;
     RefeNum(IndexDV) = DVWIN;
     Bio12YWIN = reshape(RefeNum,600,1440); 
     
     Bio12YWIN(361:600,:) =Bio12YWIN(361:600,:)+182;
     NextInd = find(Bio12YWIN >365);
     Bio12YWIN(NextInd) = Bio12YWIN(NextInd)-365;

%      geotiffwrite

 geotiffwrite([Path_Bio12YPHN,'Bio12SPR.A',YearName,'001.006.tif'],Bio12YSPR,R,'GeoKeyDirectoryTag',...
            Proj.GeoTIFFTags.GeoKeyDirectoryTag,'TiffTags',struct('Compression',Tiff.Compression.Deflate));

 geotiffwrite([Path_Bio12YPHN,'Bio12WIN.A',YearName,'001.006.tif'],Bio12YWIN,R,'GeoKeyDirectoryTag',...
            Proj.GeoTIFFTags.GeoKeyDirectoryTag,'TiffTags',struct('Compression',Tiff.Compression.Deflate));
            
        disp(['Done','/',YearName]);
      
end



