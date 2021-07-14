

tic
diary mydiary1

Path_BiomeINI = '../output/22_BiomeINI/';
Path_BioPheno = '../output/26_BioPheno/';

% system(['rm -rf ',Path_BioPheno]);
% system(['mkdir -p ',Path_BioPheno]);


load([Path_BiomeINI,'BiomeINI_SD.mat']);
Pixellist = numel(BiomeINI(:,1));


BioSDSPR = [];
BioSDWIN = [];
Year = 1:15 ;

cd /home/xuewen/Data/DeepLearn/DeepPheno/biomebgc-4.2

for Pixel = 1: Pixellist
    Pixelnum = num2str(Pixel,'%d');
    InIName = [Pixelnum,'SD'];


%run biomebgc

 system (['./bgc -a -g ini/',InIName,'.ini']);

 BioPhen = dlmread('/home/xuewen/Data/DeepLearn/DeepPheno/biomebgc-4.2/outputs/BioPhen.csv');
     
 index = numel(BioPhen(:,1));
 
     if index == 15

         Onday = BioPhen(Year,2)';
         Offday= BioPhen(Year,3)'; 
    
     else 

         Onday = BioPhen(Year+1,2)';
         Offday= BioPhen(Year+1,3)'; 

     end 

         BioSDSPR = [BioSDSPR;Onday];       
         BioSDWIN = [BioSDWIN;Offday];

     
   disp(['Done','/',InIName]);
   
end
toc

cd /home/xuewen/Data/DeepLearn/DeepPheno/code
save([Path_BioPheno,'Biopheno_SD.mat'],'-regexp','^BioSD*','^Ind*');

