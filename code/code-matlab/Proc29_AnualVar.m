
clc; clear;

Path_CNN12YPHN = '../output/14_CNN12YPHN/'; 
Path_OBS12YPHN = '../output/15_OBS12YPHN/';
Path_Bio12YPHN = '../output/27_Bio12YPHN/';
Path_AnnualVar = '../output/29_AnnualVar/' 

system(['rm -rf   ',Path_AnnualVar]);
system(['mkdir -p ',Path_AnnualVar]);


YPHNList = {'SPR','SUM','AUT','WIN'};
CaptList={'green-up','maturation','senescence','dormancy'};


YPHNListB = {'SPR','WIN'};
CaptListB={'green-up','dormancy'};

 for I_YPHN = 1: numel(YPHNList)

            YPHNName  = YPHNList{I_YPHN};                       
      
    for SiteYear = 2001 : 2015
        YearName = num2str(SiteYear,'%d');
        i= SiteYear - 2000;
          

[CNN12YPHN,R]= geotiffread([Path_CNN12YPHN,'CNN12',YPHNName,'.A',YearName,'001.006.tif']); 
[OBS12YPHN,R]= geotiffread([Path_OBS12YPHN,'OBS12',YPHNName,'.A',YearName,'001.006.tif']); 


% Northern  Hemisphere
CClass=CNN12YPHN;
OClass=OBS12YPHN;

CClass(361:600,:)=NaN;
OClass(361:600,:)=NaN;

CClass(CClass<0 | CClass>365)=nan;
OClass(OClass<0 | OClass>365)=nan;

NorCanu(i,:)=nanmean(CClass(:));
NorOanu(i,:)=nanmean(OClass(:));

% Southern Hemisphere
CClass=CNN12YPHN;
OClass=OBS12YPHN;

CClass(1:360,:)=NaN;
OClass(1:360,:)=NaN;

CClass(CClass<0 | CClass>365)=nan;
OClass(OClass<0 | OClass>365)=nan;

SouCanu(i,:)=nanmean(CClass(:));
SouOanu(i,:)=nanmean(OClass(:));
      
            
     end
     save([Path_AnnualVar,'CNNAnualVar.A',YPHNName,'.mat'],'NorCanu','SouCanu');
     save([Path_AnnualVar,'OBSAnualVar.A',YPHNName,'.mat'],'NorOanu','SouOanu');
    
 end
     
    
        
        for I_YPHNB = 1: numel(YPHNListB)

            YPHNNameB  = YPHNListB{I_YPHNB};                       
            
             for SiteYear = 2001 : 2015
                    YearName = num2str(SiteYear,'%d');
                    i= SiteYear - 2000;
 
            [Bio12YPHN,R]= geotiffread([Path_Bio12YPHN,'Bio12',YPHNNameB,'.A',YearName,'001.006.tif']); 

                % Northern  Hemisphere
                BClass = Bio12YPHN;
                BClass(361:600,:)=NaN;
                
                BClass(BClass<0 | BClass>365)=nan;
                NorBanu(i,:)=nanmean(BClass(:));

                % Southern Hemisphere
                BClass = Bio12YPHN;
                BClass(1:360,:)=NaN;
                
                BClass(BClass<0 | BClass>365)=nan;
                SouBanu(i,:)=nanmean(BClass(:));


                    
             end
         save([Path_AnnualVar,'BioAnualVar.A',YPHNNameB,'.mat'],'NorBanu','SouBanu');
        
end

