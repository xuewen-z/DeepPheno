
clear; clc ;

Path_INIorgin = '../input/ini_template/';
Path_BiomeINI = '../output/22_BiomeINI/';
Path_Metdata = '/media/xuewen/Datause/24_MetdataSD/';
Path_InIdata = '/media/xuewen/Datause/25_InIdataSD/';

system(['rm -rf ',Path_InIdata]);
system(['mkdir -p ',Path_InIdata]);

load([Path_BiomeINI,'BiomeINI_SD.mat']);

Pixellist = numel(BiomeINI(:,1));


for Pixel = 1: Pixellist
    Pixelnum = num2str(Pixel,'%d');
    input = BiomeINI(Pixel,:);
    InIName = [Pixelnum,'SD'];
    
Refdata = fopen([Path_INIorgin,'SD_template.ini'],'r+');

i = 0;

    while ~feof(Refdata)
        i = i + 1;
        Texline = fgetl(Refdata);
        modify{i} = Texline;
        
    % change cell 
        if i==4 
            modify{4} = strrep(Texline,'test',InIName);
                     
        end
        
        if i==11
            modify{11}=strrep(Texline,'test',InIName);
                   
        end
        
        if i==12
            modify{12}=strrep(Texline,'test',InIName);
        end
         
        % write Soil Texture
        if i==35
            modify{35}=strrep(Texline,'66.0',num2str(input(:,1),'%.1f'));
        end
        
        if i==36
            modify{36}=strrep(Texline,'29.0',num2str(input(:,2),'%.1f'));
        end
        
        if i==37
            modify{37}=strrep(Texline,'5.0',num2str(input(:,3),'%.1f'));
        end
        
        % write Elevation
        if i==38
            modify{38}=strrep(Texline,'340.0',num2str(input(:,4),'%.1f'));
        end
        
        % write Latitude
        if i==39
            modify{39}=strrep(Texline,'42.5',num2str(input(:,5),'%.1f'));
        end
        
        if i==74
            modify{74}=strrep(Texline,'test',['SD/',InIName]);
        end

                      
    end
  fclose(Refdata);
    
  % write cell into a new .ini
    InIdata = fopen([Path_InIdata,InIName,'.ini'],'w');
    
     for i = 1: numel(modify)
          fprintf(InIdata,'%s\r\n',modify{i});
     end
    
     fclose(InIdata);
  
     disp(['Done','/',Pixelnum]);
  
end


