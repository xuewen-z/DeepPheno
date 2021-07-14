clear;

Path_Geo12YPHN = '../output/06_Geo12YPHN/';
Path_Geo2Site = '../output/08_Geo2Site/';
Path_SiteYPHN  = '../output/09_SiteYPHN/';

system(['rm -rf   ', Path_SiteYPHN]);
system(['mkdir -p ', Path_SiteYPHN]);

% study year
SiteYear = 2008;
YearName = num2str(SiteYear,'%d');

% read data
load([Path_Geo2Site,'Geo2Site.A',YearName,'.mat']);

FileName = dir([Path_Geo12YPHN,'Geo12SPR*','.A',YearName,'*.tif']);
Geo12PHN = geotiffread(fullfile(FileName.folder,FileName.name));
SiteYSPR = Geo12PHN(SiteInd); 


FileName = dir([Path_Geo12YPHN,'Geo12SUM*','.A',YearName,'*.tif']);
Geo12PHN = geotiffread(fullfile(FileName.folder,FileName.name));
SiteYSUM = Geo12PHN(SiteInd); 


FileName = dir([Path_Geo12YPHN,'Geo12AUT*','.A',YearName,'*.tif']);
Geo12PHN = geotiffread(fullfile(FileName.folder,FileName.name));
SiteYAUT = Geo12PHN(SiteInd); 


FileName = dir([Path_Geo12YPHN,'Geo12WIN*','.A',YearName,'*.tif']);
Geo12PHN = geotiffread(fullfile(FileName.folder,FileName.name));
SiteYWIN = Geo12PHN(SiteInd); 


save([Path_SiteYPHN,'SiteYPHN.A2008.mat'],'-regexp','^Site*');
