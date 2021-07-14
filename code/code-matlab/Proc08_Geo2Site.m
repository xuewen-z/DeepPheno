clc; clear;

% Training Data
Path_LandCover = '../input/';
Path_Geo12YPHN= '../output/06_Geo12YPHN/';
Path_Geo2Site = '../output/08_Geo2Site/';

system(['rm -rf   ',Path_Geo2Site]);
system(['mkdir -p ',Path_Geo2Site]);

% study year
SiteYear = 2008; 
YearName = num2str(SiteYear,'%d');

% geoinformation
[Landcover,R] = geotiffread([Path_LandCover,'LCT_Mul_CMG025_USGS.tif']);  % Landcover
Proj          = geotiffinfo([Path_LandCover,'LCT_Mul_CMG025_USGS.tif']);

[GridLon,GridLat]=pixcenters(Proj);
[LonMesh,LatMesh]=meshgrid(GridLon,GridLat);

% phenology NAN
FileList = dir([Path_Geo12YPHN,'NAN*','.A',YearName,'*.tif']);

NAN12PHNs = nan([size(Landcover,1) size(Landcover,2) 4]);
for I_File = 1 : numel(FileList)
    FileName = FileList(I_File).name;
    [NAN12PHN,R] = geotiffread([Path_Geo12YPHN,FileName]);
    NAN12PHNs(:,:,I_File) = NAN12PHN;
end


% NAN12PHN = (NAN12PHNs(:,:,1) < 50 & NAN12PHNs(:,:,2) < 50 ...
%     & NAN12PHNs(:,:,3) < 50 & NAN12PHNs(:,:,4) < 50);

NAN12PHN = sum(NAN12PHNs<50,3)==4;

% EV:ENF=1(7073);EBF=2(18346);
% DV:DNF=3(4279);DBF=4(1922);MIF=5(17846);
% SD:CSH=6(83);OSH=7(46734);WSA=8(17306);SAV=9(14180);GRA=10(35239)

% PFT
Landcover = double(Landcover);
LogicEV = (Landcover == 1 | Landcover == 2 & NAN12PHN); % belong to EV
LogicSD = (Landcover == 6 | Landcover == 7 | Landcover == 8 | Landcover == 9 | Landcover == 10 & NAN12PHN); % belong to SDV  
LogicDV = (Landcover == 3 | Landcover == 4 | Landcover == 5 & NAN12PHN); % belong to DBF  

IndexEV = find(LogicEV==1);
IndexSD = find(LogicSD==1);
IndexDV = find(LogicDV==1);

rand('seed',25);
RandEV = randperm(numel(IndexEV),6000);  % 4000 for training (8:2 train,valid), 2000 for test

rand('seed',25);
RandSD = randperm(numel(IndexSD),6000);  % 4000 for training (8:2 train,valid), 2000 for test

rand('seed',25);
RandDV = randperm(numel(IndexDV),6000);  % 4000 for training (8:2 train,valid), 2000 for test

SiteInd  = [IndexEV(RandEV);    IndexSD(RandSD);    IndexDV(RandDV)];

% land cover
SiteCode = Landcover(SiteInd);

% Lat Lon
SiteLat  = LatMesh(SiteInd);
SiteLon  = LonMesh(SiteInd);

% write data
save([Path_Geo2Site,'Geo2Site.A',YearName,'.mat'],'-regexp','^Site');
