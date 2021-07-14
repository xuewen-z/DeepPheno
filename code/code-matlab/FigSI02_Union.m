Path_Figure  = '../figure/SI/';


% CaptList = {'OBS','CNN'};
YPHNList = {'SPR','SUM','AUT','WIN'};
CaptList = {'CNN'};


 for I_CPHN = 1: numel(CaptList)
    CaptName = CaptList{I_CPHN};
    
    parfor    I_YPHN = 1: numel(YPHNList)
              YPHNName = YPHNList{I_YPHN};  

    
Fig1 =imread([Path_Figure,CaptName,YPHNName,'2001.tif']);
Fig2 =imread([Path_Figure,CaptName,YPHNName,'2002.tif']);
Fig3 =imread([Path_Figure,CaptName,YPHNName,'2003.tif']);
Fig4 =imread([Path_Figure,CaptName,YPHNName,'2004.tif']);
Fig5 =imread([Path_Figure,CaptName,YPHNName,'2005.tif']);
Fig6 =imread([Path_Figure,CaptName,YPHNName,'2006.tif']);
Fig7 =imread([Path_Figure,CaptName,YPHNName,'2007.tif']);
Fig8 =imread([Path_Figure,CaptName,YPHNName,'2008.tif']);
Fig9 =imread([Path_Figure,CaptName,YPHNName,'2009.tif']);
Fig10 =imread([Path_Figure,CaptName,YPHNName,'2010.tif']);
Fig11 =imread([Path_Figure,CaptName,YPHNName,'2011.tif']);
Fig12 =imread([Path_Figure,CaptName,YPHNName,'2012.tif']);
Fig13 =imread([Path_Figure,CaptName,YPHNName,'2013.tif']);
Fig14 =imread([Path_Figure,CaptName,YPHNName,'2014.tif']);
Fig15 =imread([Path_Figure,CaptName,YPHNName,'2015.tif']);

Fig =cat(1,cat(2,Fig1,Fig2,Fig3),cat(2,Fig4,Fig5,Fig6),cat(2,Fig7,Fig8,Fig9),...
    cat(2,Fig10,Fig11,Fig12),cat(2,Fig13,Fig14,Fig15));

Fig=imresize(Fig,2244/size(Fig,2));
imwrite(Fig,[Path_Figure,CaptName,YPHNName,'.tif'],'Compression','LZW','Resolution',300);


    end
        
    
 end
 
%  
% CaptList = {'Bio'};
% YPHNList = {'SPR','WIN'};
% 
%  for I_CPHN = 1: numel(CaptList)
%     CaptName = CaptList{I_CPHN};
%     
%     parfor    I_YPHN = 1: numel(YPHNList)
%               YPHNName = YPHNList{I_YPHN};  
% 
%     
% Fig1 =imread([Path_Figure,CaptName,YPHNName,'2001.tif']);
% Fig2 =imread([Path_Figure,CaptName,YPHNName,'2002.tif']);
% Fig3 =imread([Path_Figure,CaptName,YPHNName,'2003.tif']);
% Fig4 =imread([Path_Figure,CaptName,YPHNName,'2004.tif']);
% Fig5 =imread([Path_Figure,CaptName,YPHNName,'2005.tif']);
% Fig6 =imread([Path_Figure,CaptName,YPHNName,'2006.tif']);
% Fig7 =imread([Path_Figure,CaptName,YPHNName,'2007.tif']);
% Fig8 =imread([Path_Figure,CaptName,YPHNName,'2008.tif']);
% Fig9 =imread([Path_Figure,CaptName,YPHNName,'2009.tif']);
% Fig10 =imread([Path_Figure,CaptName,YPHNName,'2010.tif']);
% Fig11 =imread([Path_Figure,CaptName,YPHNName,'2011.tif']);
% Fig12 =imread([Path_Figure,CaptName,YPHNName,'2012.tif']);
% Fig13 =imread([Path_Figure,CaptName,YPHNName,'2013.tif']);
% Fig14 =imread([Path_Figure,CaptName,YPHNName,'2014.tif']);
% Fig15 =imread([Path_Figure,CaptName,YPHNName,'2015.tif']);
% 
% Fig =cat(1,cat(2,Fig1,Fig2,Fig3),cat(2,Fig4,Fig5,Fig6),cat(2,Fig7,Fig8,Fig9),...
%     cat(2,Fig10,Fig11,Fig12),cat(2,Fig13,Fig14,Fig15));
% 
% Fig=imresize(Fig,2244/size(Fig,2));
% imwrite(Fig,[Path_Figure,CaptName,YPHNName,'.tif'],'Compression','LZW','Resolution',300);
% 
% 
%     end
%         
%     
%  end
 
delete([Path_Figure,'*SPR20*.tif']);
delete([Path_Figure,'*SUM20*.tif']);
delete([Path_Figure,'*AUT20*.tif']);
delete([Path_Figure,'*WIN20*.tif']);

