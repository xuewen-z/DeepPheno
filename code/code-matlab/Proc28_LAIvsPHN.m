clear;

addpath(genpath('./'));

Path_Geo15LAI  = '../input/';
Path_CNN12YPHN = '../output/14_CNN12YPHN/'; 
Path_OBS12YPHN = '../output/15_OBS12YPHN/';
Path_Bio12YPHN = '../output/27_Bio12YPHN/';
Path_LAIvsPHN ='../output/28_LAIvsPHN/';

system(['rm -rf   ',Path_LAIvsPHN]);
system(['mkdir -p ',Path_LAIvsPHN]);


    MOD15DVn = [];  MOD15DVs = []; 
    MOD15SDn = [];  MOD15SDs = [];
    
for Year =2008 : 2009
    YearName = num2str(Year,'%d');


    Geo15LAI = geotiffread([Path_Geo15LAI,'GMMIS3g.DLAI25KM.A',YearName,'.tif']);
    Geo15LAI = reshape(Geo15LAI,[],365);
    
       
    Temp1 = Geo15LAI(476587,:); %north
    Temp2 = Geo15LAI(287865,:); %south 323801
    Temp3 = Geo15LAI(597695,:); %north
    Temp4 = Geo15LAI(503859,:); %south  503859
 
    MOD15DVn = [MOD15DVn,Temp1];
    MOD15DVs = [MOD15DVs,Temp2]; 
    MOD15SDn = [MOD15SDn,Temp3]; 
    MOD15SDs = [MOD15SDs,Temp4];
    
end


YPHNList = {'SPR','WIN'};
Year =2008;

Obs12DVs =[]; Obs12DVn  =[];  Obs12SDs =[]; Obs12SDn =[];

for I_YPHN = 1: numel(YPHNList)

    YPHNName  = YPHNList{I_YPHN}; 
    
    OYPHNDOY = geotiffread([Path_OBS12YPHN,'OBS12',YPHNName,'.A',num2str(Year),'001.006.tif']);
    OYPHNDOY =reshape(OYPHNDOY,[],1);
    
    
    Temp1 = OYPHNDOY(476587,:);
    Temp2 = OYPHNDOY(287865,:); %323801
    Temp3 = OYPHNDOY(658930,:);
    Temp4 = OYPHNDOY(503859,:);
    
    Obs12DVn(I_YPHN,:)=Temp1;
    Obs12DVs(I_YPHN,:)=Temp2;
    Obs12SDn(I_YPHN,:)=Temp3;
    Obs12SDs(I_YPHN,:)=Temp4;
    
    
end

Obs12DVs(2,:)=Obs12DVs(2,:) +365;
Obs12SDs(2,:)=Obs12SDs(2,:) +365;


Cnn12DVs =[]; Cnn12DVn  =[];  Cnn12SDs =[]; Cnn12SDn =[];


for I_YPHN = 1: numel(YPHNList)

    YPHNName  = YPHNList{I_YPHN}; 
    
    CYPHNDOY = geotiffread([Path_CNN12YPHN,'CNN12',YPHNName,'.A',num2str(Year),'001.006.tif']);
    CYPHNDOY =reshape(CYPHNDOY,[],1);
          
    Temp1 = CYPHNDOY(476587,:);
    Temp2 = CYPHNDOY(287865,:);
    Temp3 = CYPHNDOY(597695,:);
    Temp4 = CYPHNDOY(503859,:);
    
    Cnn12DVn(I_YPHN,:)=Temp1;
    Cnn12DVs(I_YPHN,:)=Temp2;
    Cnn12SDn(I_YPHN,:)=Temp3;
    Cnn12SDs(I_YPHN,:)=Temp4;
end
Cnn12DVs(2,:)=Cnn12DVs(2,:) +365;
Cnn12SDs(2,:)=Cnn12SDs(2,:) +365;


Bio12DVs =[]; Bio12DVn  =[];  Bio12SDs =[]; Bio12SDn =[];

for I_YPHN = 1: numel(YPHNList)

    YPHNName  = YPHNList{I_YPHN}; 
    
    BYPHNDOY = geotiffread([Path_Bio12YPHN,'Bio12',YPHNName,'.A',num2str(Year),'001.006.tif']);
    BYPHNDOY =reshape(BYPHNDOY,[],1);
    
    
    Temp1 = BYPHNDOY(476587,:);
    Temp2 = BYPHNDOY(287865,:);
    Temp3 = BYPHNDOY(597695,:);
    Temp4 = BYPHNDOY(503859,:);
    
    Bio12DVn(I_YPHN,:)=Temp1;
    Bio12DVs(I_YPHN,:)=Temp2;
    Bio12SDn(I_YPHN,:)=Temp3;
    Bio12SDs(I_YPHN,:)=Temp4;
    
    
end

Bio12DVs(2,:)=Bio12DVs(2,:) + 365;
Bio12SDs(2,:)=Bio12SDs(2,:) + 365;


save([Path_LAIvsPHN,'LAIvsPHN.mat'],'-regexp','^Cnn*','^Obs*','^Bio*','^MOD*');
