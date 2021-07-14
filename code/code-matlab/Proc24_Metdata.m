

Path_BiomeMET = '../output/23_BiomeMET/';
Path_Metdata = '/media/xuewen/Datause/24_MetdataSD/';

system(['rm -rf ',Path_Metdata]);
system(['mkdir -p ',Path_Metdata]);

Metdata =[];

for Year = 2001 : 2015
    YearName = num2str(Year,'%d');
    
    FileName = dir([Path_BiomeMET,'SD*',YearName,'.mat']);
    load(fullfile(FileName.folder,FileName.name));
    Metdata = [Metdata;SubMET];
    
end
 

Pixellist = numel(Metdata(1,1,:));
Metlist =numel(Metdata(:,1,1));

for Pixel = 1: Pixellist
    Pixelnum = num2str(Pixel,'%d');
    Input = Metdata(:,:,Pixel);
    
    %Daylength
    Input(:,9)=round(Input(:,9),0);
    
            FileName =[Path_Metdata,Pixelnum,'SD.mtc41'];

            TexTitle=[Pixelnum,'SD',', ','2001-2015',' : Sample input for MTCLIM v4.1\r\n'];
            TexTime=['MTCLIM v4.1 OUTPUT FILE : ',date,'\r\n'];

            fid=fopen(FileName,'w');
            fprintf(fid,TexTitle);
            fprintf(fid,TexTime);
            fprintf(fid,'%6s%6s%8s%8s%8s%8s%9s%9s%8s\r\n','year','yday','Tmax','Tmin','Tday',...
                                                      'prcp','VPD','srad','  daylen');
            fprintf(fid,'%6s%6s%8s%8s%8s%8s%9s%9s%8s\r\n','','','(deg C)','(deg C)','(deg C)',...
                                                      '(cm)','(Pa)','  (W m-2)','(s)');
            
            for DOY = 1: Metlist                                
            
                fprintf(fid,'%6d%6d%8.2f%8.2f%8.2f%8.2f%9.2f%9.2f%8d\r\n', Input(DOY,:));
            end
            
          fclose(fid);
          
          disp(['Done','/',Pixelnum]);
end



