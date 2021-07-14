clear;

Path_GlobDEM = '../input/';
Path_Soil2TIF = '../output/20_Soil2TIF/';
Path_Geo2Site = '../output/08_Geo2Site/';
Path_StatFeat= '../output/09_StatFeat/';

system(['rm -rf   ', Path_StatFeat]);
system(['mkdir -p ', Path_StatFeat]);

% study year
SiteYear = 2008;
YearName = num2str(SiteYear,'%d');

% read data
load([Path_Geo2Site,'Geo2Site.A',YearName,'.mat']);


% read data 

GlobSILT = round(geotiffread([Path_Soil2TIF,'Global.SILT1.CMG25KM.tif']),0);
MaxSILT = nanmax(GlobSILT(:));
MinSILT = nanmin(GlobSILT(:));
SiteSILT = GlobSILT(SiteInd); 


GlobCLAY = round(geotiffread([Path_Soil2TIF,'Global.CLAY1.CMG25KM.tif']),0);
MaxCLAY = nanmax(GlobCLAY(:));
MinCLAY = nanmin(GlobCLAY(:));
SiteCLAY = GlobCLAY(SiteInd); 
    

GlobSAND = 100 - GlobCLAY - GlobSILT;
MaxSAND = nanmax(GlobSAND(:));
MinSAND = nanmin(GlobSAND(:));
SiteSAND = GlobSAND(SiteInd); 
    

GlobDEM = double(geotiffread([Path_GlobDEM,'Global.DEM.CMG25KM.tif']));
MaxDEM = nanmax(GlobDEM(:));
MinDEM = nanmin(GlobDEM(:));
SiteDEM = GlobDEM(SiteInd);    
      
      
% global normalization

GlobSILT= (GlobSILT-MinSILT)./(MaxSILT-MinSILT);
GlobSILT(GlobSILT>1) =1;GlobSILT(GlobSILT<0) =0;
GlobSILT= reshape(GlobSILT,[],1);
GlobSILT= repmat(GlobSILT,[1,365]);

GlobCLAY= (GlobCLAY-MinCLAY)./(MaxCLAY-MinCLAY);
GlobCLAY(GlobCLAY>1) =1;GlobCLAY(GlobCLAY<0) =0;
GlobCLAY= reshape(GlobCLAY,[],1);
GlobCLAY= repmat(GlobCLAY,[1,365]);

GlobSAND= (GlobSAND-MinSAND)./(MaxSAND-MinSAND);
GlobSAND(GlobSAND>1) =1;GlobSAND(GlobSAND<0) =0;
GlobSAND= reshape(GlobSAND,[],1);
GlobSAND= repmat(GlobSAND,[1,365]);

GlobDEM= (GlobDEM-MinDEM)./(MaxDEM-MinDEM);
GlobDEM(GlobDEM>1) =1;GlobDEM(GlobDEM<0) =0;
GlobDEM= reshape(GlobDEM,[],1);
GlobDEM= repmat(GlobDEM,[1,365]);




% site normalization

SiteSILT= (SiteSILT-MinSILT)./(MaxSILT-MinSILT);
SiteSILT(SiteSILT>1) =1;SiteSILT(SiteSILT<0) =0;
SiteSILT = repmat(SiteSILT,[1, 365]);

SiteCLAY= (SiteCLAY-MinCLAY)./(MaxCLAY-MinCLAY);
SiteCLAY(SiteCLAY>1) =1;SiteCLAY(SiteCLAY<0) =0;
SiteCLAY = repmat(SiteCLAY,[1, 365]);

SiteSAND= (SiteSAND-MinSAND)./(MaxSAND-MinSAND);
SiteSAND(SiteSAND>1) =1;SiteSAND(SiteSAND<0) =0;
SiteSAND = repmat(SiteSAND,[1, 365]);

SiteDEM= (SiteDEM-MinDEM)./(MaxDEM-MinDEM);
SiteDEM(SiteDEM>1) =1;SiteDEM(SiteDEM<0) =0;
SiteDEM = repmat(SiteDEM,[1, 365]);


    
% write data
save([Path_StatFeat,'SiteStatic.A2008.mat'],'-regexp','^Site*');
% write data

save([Path_StatFeat,'GlobStatic.A2008.mat'],'-regexp','^Glob*');
   
   
  
