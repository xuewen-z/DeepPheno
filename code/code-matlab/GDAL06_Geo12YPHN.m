Path_FUS12YPHN = '../output/05_FUS12YPHN/';
Path_Geo12YPHN = '../output/06_Geo12YPHN/';

system(['rm -rf '  ,Path_Geo12YPHN]);
system(['mkdir -p ',Path_Geo12YPHN]);


FileList = dir([Path_FUS12YPHN,'*.tif']);

% for I_File = 2
for I_File = 1 : numel(FileList)
    
    [FUS12YPHN,R] = geotiffread(fullfile(FileList(I_File).folder,FileList(I_File).name));
    Proj           = geotiffinfo(fullfile(FileList(I_File).folder,FileList(I_File).name));

    % process
    Geo12YPHN = imaggregation(FUS12YPHN,60,7);
    Geo12YPHN = round(Geo12YPHN,0);
    
    NAN12YPHN = imaggregation(double(isnan(FUS12YPHN)),60,8);
    NAN12YPHN = round(NAN12YPHN/3600 *100,0);
    
    % write data
    R.RasterSize = size(Geo12YPHN);
    
    FileName = regexprep(FileList(I_File).name,'WGS','Geo');
    geotiffwrite([Path_Geo12YPHN,FileName],Geo12YPHN,R,'GeoKeyDirectoryTag',...
        Proj.GeoTIFFTags.GeoKeyDirectoryTag,'TiffTags',struct('Compression',Tiff.Compression.Deflate));
    
    FileName = regexprep(FileList(I_File).name,'WGS','NAN');
    geotiffwrite([Path_Geo12YPHN,FileName],NAN12YPHN,R,'GeoKeyDirectoryTag',...
        Proj.GeoTIFFTags.GeoKeyDirectoryTag,'TiffTags',struct('Compression',Tiff.Compression.Deflate));
    
    disp(['Done with ',FileList(I_File).name]);
end
