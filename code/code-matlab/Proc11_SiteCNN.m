clear;clc;

Path_StatFeat= '../output/09_StatFeat/';
Path_SiteGLDAS = '../output/10_SiteGLDAS/';
Path_SiteCNN = '../output/11_SiteCNN/';

system(['rm -rf   ', Path_SiteCNN]);
system(['mkdir -p ', Path_SiteCNN]);

PixelNum = 6000;

% study year
SiteYear = 2008; 
YearName = num2str(SiteYear,'%d');

% read data
load([Path_SiteGLDAS,'SiteGLDAS.A',YearName,'.mat']);
load([Path_StatFeat,'SiteStatic.A',YearName,'.mat']);



% generate train and tests data for vegetation type and phenology metrics
VegeList = {'EV','SD','DV'};
YPHNList = {'SPR','SUM','AUT','WIN'};
SiteYPHN = [SiteYSPR,SiteYSUM,SiteYAUT,SiteYWIN];

for I_Vege = 1: numel(VegeList)

    VegeName  = VegeList{I_Vege};
    
    RangeVege = 1 + (I_Vege-1)*PixelNum : I_Vege*PixelNum;
    
    TrainVege = RangeVege(1:4000);      % 4000 for train
    TestsVege = RangeVege(4001:end);    % 2000 for tests
    
    for I_YPHN = 1 : numel(YPHNList)
        % phenology name
        YPHNName = YPHNList{I_YPHN};
        
        % seperate data
        ModelYPHNc = [SiteYPHN(:,I_YPHN),SiteAtmpre,SitePhotop,SitePrecip,SiteSpehum,...
            SiteShorad,SiteTemavg,SiteTemmax,SiteTemmin,SiteVapdef,SiteWinspd,SiteDEM,SiteSAND,SiteCLAY,SiteSILT];
        
        TrainYPHN = ModelYPHN(TrainVege,:);
        TestsYPHN = ModelYPHN(TestsVege,:);
        
        % exclude nan data
        I_Valid=sum(isnan(TrainYPHN),2)==0;
        TrainYPHN=TrainYPHN(I_Valid,:);

        I_Valid=sum(isnan(TestsYPHN),2)==0;
        TestsYPHN=TestsYPHN(I_Valid,:);
        
        Header = 0:5110;
        
        % write data
        writematrix([Header;TrainYPHN],[Path_SiteCNN,VegeName,'_Train',YPHNName,'_A',YearName,'.csv']);
        writematrix([Header;TestsYPHN],[Path_SiteCNN,VegeName,'_Tests',YPHNName,'_A',YearName,'.csv']);
%         save([Path_SiteCNN,VegeName,'_Train',YPHNName,'_A',YearName,'.mat'],'TrainYPHN');
%         save([Path_SiteCNN,VegeName,'_Tests',YPHNName,'_A',YearName,'.mat'],'TestsYPHN');
    end
end
