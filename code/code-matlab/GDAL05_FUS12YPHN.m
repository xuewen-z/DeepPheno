Path_DOY12YPHN = '../output/04_DOY12YPHN/';
Path_FUS12YPHN = '../output/05_FUS12YPHN/';

system(['rm -rf '  ,Path_FUS12YPHN]);
system(['mkdir -p ',Path_FUS12YPHN]);

% for Year = 2011
for Year = 2001:2015

    YearName = num2str(Year,'%d');
    FileList = dir([Path_DOY12YPHN,'*.A',YearName,'*.tif']);
    
    for I_File = 1 : numel(FileList)
        
        FileName = FileList(I_File).name;
        % read current year data
        [FUS12YPHN,R] = geotiffread([Path_DOY12YPHN,FileName]);
        Proj          = geotiffinfo([Path_DOY12YPHN,FileName]);
        
        % process current year data to ealiest DOY
        FUS12YPHN(FUS12YPHN<  0)=nan;
        FUS12YPHN(FUS12YPHN>365)=nan;
        FUS12YPHN = min(FUS12YPHN,[],3);
        
        % read next year data
        YearNext = num2str(Year+1,'%d');
        FileNext = regexprep(FileName,['A',YearName],['A',YearNext]);
        FUS12YPHN2 = geotiffread([Path_DOY12YPHN,FileNext]);
        
        % process next year data to ealiest DOY
        FUS12YPHN2 = FUS12YPHN2 + 365;
        FUS12YPHN2(FUS12YPHN2<  0)=nan;
        FUS12YPHN2(FUS12YPHN2>365)=nan;
        FUS12YPHN2 = min(FUS12YPHN2,[],3);

        % fusion data
        FUS12YPHN  = min(FUS12YPHN,FUS12YPHN2);

        % write data
        geotiffwrite([Path_FUS12YPHN,FileName],FUS12YPHN,R,'GeoKeyDirectoryTag',...
            Proj.GeoTIFFTags.GeoKeyDirectoryTag,'TiffTags',struct('Compression',Tiff.Compression.Deflate));

        disp(['Done with ',FileList(I_File).name]);
    end
end
