
clc; clear;

Path_AnualYPHN = '../output/16_AnualYPHN/';
Path_TAVG12IND = '../output/17_TAVG12IND/'; 
Path_GlobAnoma = '../output/19_GlobAnoma/'; 

system(['rm -rf   ',Path_GlobAnoma]);
system(['mkdir -p ',Path_GlobAnoma]);


% read data
ObsSPR = geotiffread([Path_AnualYPHN,'OYPHNDOY.SPR.2001.2015.tif']);
CnnSPR = geotiffread([Path_AnualYPHN,'CYPHNDOY.SPR.2001.2015.tif']);
BioSPR = geotiffread([Path_AnualYPHN,'BYPHNDOY.SPR.2001.2015.tif']);
ObsAVGSPR = geotiffread([Path_TAVG12IND,'Obs12AVG.SPR.2001.2015.tif']);
CnnAVGSPR = geotiffread([Path_TAVG12IND,'Cnn12AVG.SPR.2001.2015.tif']);
BioAVGSPR = geotiffread([Path_TAVG12IND,'Bio12AVG.SPR.2001.2015.tif']);

% SPR

for i_Year =1:15
    
    OTemp = ObsSPR(:,:,i_Year);
    OAnoma = OTemp-ObsAVGSPR;
    OSPRmean(i_Year,1)=nanmean(OAnoma(:));
    OSPRstd(i_Year,1)=nanstd(OAnoma(:));
   
    CTemp = CnnSPR(:,:,i_Year);
    CAnoma = CTemp-CnnAVGSPR;
    CSPRmean(i_Year,1)=nanmean(CAnoma(:));
    CSPRstd(i_Year,1)=nanstd(CAnoma(:));
    
    BTemp = BioSPR(:,:,i_Year);
    BAnoma = BTemp-BioAVGSPR;
    BSPRmean(i_Year,1)=nanmean(BAnoma(:));
    BSPRstd(i_Year,1)=nanstd(BAnoma(:));
    
    
end

% read data
ObsSUM = geotiffread([Path_AnualYPHN,'OYPHNDOY.SUM.2001.2015.tif']);
CnnSUM = geotiffread([Path_AnualYPHN,'CYPHNDOY.SUM.2001.2015.tif']);
ObsAVGSUM = geotiffread([Path_TAVG12IND,'Obs12AVG.SUM.2001.2015.tif']);
CnnAVGSUM = geotiffread([Path_TAVG12IND,'Cnn12AVG.SUM.2001.2015.tif']);

% SUM

for i_Year =1:15
    
    OTemp = ObsSUM(:,:,i_Year);
    OAnoma = OTemp-ObsAVGSUM;
    OSUMmean(i_Year,1)=nanmean(OAnoma(:));
    OSUMstd(i_Year,1)=nanstd(OAnoma(:));
   
    CTemp = CnnSUM(:,:,i_Year);
    CAnoma = CTemp-CnnAVGSUM;
    CSUMmean(i_Year,1)=nanmean(CAnoma(:));
    CSUMstd(i_Year,1)=nanstd(CAnoma(:));  
    
end


% read data
ObsAUT = geotiffread([Path_AnualYPHN,'OYPHNDOY.AUT.2001.2015.tif']);
CnnAUT = geotiffread([Path_AnualYPHN,'CYPHNDOY.AUT.2001.2015.tif']);
ObsAVGAUT = geotiffread([Path_TAVG12IND,'Obs12AVG.AUT.2001.2015.tif']);
CnnAVGAUT = geotiffread([Path_TAVG12IND,'Cnn12AVG.AUT.2001.2015.tif']);

% AUT

for i_Year =1:15
    
    OTemp = ObsAUT(:,:,i_Year);
    OAnoma = OTemp-ObsAVGAUT;
    OAUTmean(i_Year,1)=nanmean(OAnoma(:));
    OAUTstd(i_Year,1)=nanstd(OAnoma(:));
   
    CTemp = CnnAUT(:,:,i_Year);
    CAnoma = CTemp-CnnAVGAUT;
    CAUTmean(i_Year,1)=nanmean(CAnoma(:));
    CAUTstd(i_Year,1)=nanstd(CAnoma(:));  
    
end

% read data
ObsWIN = geotiffread([Path_AnualYPHN,'OYPHNDOY.WIN.2001.2015.tif']);
CnnWIN = geotiffread([Path_AnualYPHN,'CYPHNDOY.WIN.2001.2015.tif']);
BioWIN = geotiffread([Path_AnualYPHN,'BYPHNDOY.WIN.2001.2015.tif']);
ObsAVGWIN = geotiffread([Path_TAVG12IND,'Obs12AVG.WIN.2001.2015.tif']);
CnnAVGWIN = geotiffread([Path_TAVG12IND,'Cnn12AVG.WIN.2001.2015.tif']);
BioAVGWIN = geotiffread([Path_TAVG12IND,'Bio12AVG.WIN.2001.2015.tif']);

% WIN

for i_Year =1:15
    
    OTemp = ObsWIN(:,:,i_Year);    
    OAnoma = OTemp-ObsAVGWIN;
    OWINmean(i_Year,1)=nanmean(OAnoma(:));
    OWINstd(i_Year,1)=nanstd(OAnoma(:));
   
    CTemp = CnnWIN(:,:,i_Year);
    CAnoma = CTemp-CnnAVGWIN;
    CWINmean(i_Year,1)=nanmean(CAnoma(:));
    CWINstd(i_Year,1)=nanstd(CAnoma(:));
    
    BTemp = BioWIN(:,:,i_Year);
    BAnoma = BTemp-BioAVGWIN;
    BWINmean(i_Year,1)=nanmean(BAnoma(:));
    BWINstd(i_Year,1)=nanstd(BAnoma(:));
    
    
end


save([Path_GlobAnoma,'GlobAnomaly.mat'],'*mean','*std')
    
