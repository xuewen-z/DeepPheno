Path_Figure  = '../figure/';

Fig1 =imread([Path_Figure,'ExtentOSPR.tif']);
Fig2 =imread([Path_Figure,'ExtentCSPR.tif']);
Fig3 =imread([Path_Figure,'ExtentBSPR.tif']);
Fig4 =imread([Path_Figure,'ShadedSPR.tif']);
Fig5 =imread([Path_Figure,'RegresCnnSPR.tif']);
Fig6 =imread([Path_Figure,'RegresBioSPR.tif']);

Fig =cat(1,cat(2,Fig1,Fig4),cat(2,Fig2,Fig5),cat(2,Fig3,Fig6));

Fig=imresize(Fig,2244/size(Fig,2));
imwrite(Fig,[Path_Figure,'ExtentSPR.tif'],'Compression','LZW','Resolution',300);


Fig1 =imread([Path_Figure,'ExtentOSUM.tif']);
Fig2 =imread([Path_Figure,'ExtentCSUM.tif']);
Fig4 =imread([Path_Figure,'ShadedSUM.tif']);
Fig5 =imread([Path_Figure,'RegresCnnSUM.tif']);

Fig =cat(1,cat(2,Fig1,Fig4),cat(2,Fig2,Fig5));

Fig=imresize(Fig,2244/size(Fig,2));
imwrite(Fig,[Path_Figure,'ExtentSUM.tif'],'Compression','LZW','Resolution',300);



Fig1 =imread([Path_Figure,'ExtentOAUT.tif']);
Fig2 =imread([Path_Figure,'ExtentCAUT.tif']);
Fig4 =imread([Path_Figure,'ShadedAUT.tif']);
Fig5 =imread([Path_Figure,'RegresCnnAUT.tif']);

Fig =cat(1,cat(2,Fig1,Fig4),cat(2,Fig2,Fig5));

Fig=imresize(Fig,2244/size(Fig,2));
imwrite(Fig,[Path_Figure,'ExtentAUT.tif'],'Compression','LZW','Resolution',300);



Fig1 =imread([Path_Figure,'ExtentOWIN.tif']);
Fig2 =imread([Path_Figure,'ExtentCWIN.tif']);
Fig3 =imread([Path_Figure,'ExtentBWIN.tif']);
Fig4 =imread([Path_Figure,'ShadedWIN.tif']);
Fig5 =imread([Path_Figure,'RegresCnnWIN.tif']);
Fig6 =imread([Path_Figure,'RegresBioWIN.tif']);

Fig =cat(1,cat(2,Fig1,Fig4),cat(2,Fig2,Fig5),cat(2,Fig3,Fig6));

Fig=imresize(Fig,2244/size(Fig,2));
imwrite(Fig,[Path_Figure,'ExtentWIN.tif'],'Compression','LZW','Resolution',300);


Fig1 =imread([Path_Figure,'IntraStatsCnn.SPR.tif']);
Fig2 =imread([Path_Figure,'IntraStatsBio.SPR.tif']);
Fig3 =imread([Path_Figure,'IntraStatsCnn.WIN.tif']);
Fig4 =imread([Path_Figure,'IntraStatsBio.WIN.tif']);

Fig =cat(2,Fig1,Fig2);
Fig=imresize(Fig,2244/size(Fig,2));
imwrite(Fig,[Path_Figure,'IntraSPR.tif'],'Compression','LZW','Resolution',300);

Fig =cat(2,Fig3,Fig4);
Fig=imresize(Fig,2244/size(Fig,2));
imwrite(Fig,[Path_Figure,'IntraWIN.tif'],'Compression','LZW','Resolution',300);


delete([Path_Figure,'ExtentC*.tif']);
delete([Path_Figure,'ExtentO*.tif']);
delete([Path_Figure,'ExtentB*.tif']);
delete([Path_Figure,'Regres*.tif']);
delete([Path_Figure,'Shaded*.tif']);

delete([Path_Figure,'Intra*Bio*.tif']);
delete([Path_Figure,'Intra*Cnn*.SPR.tif']);
delete([Path_Figure,'Intra*Cnn*.WIN.tif']);