
clc; clear;

Path_LandCover = '../input/';
Path_TAVG12IND = '../output/17_TAVG12IND/';
Path_Figure  = '../figure/';

    CrseSPR = geotiffread([Path_TAVG12IND,'Cnn12RMSE.SPR.2001.2015.tif']);
    CrseSUM = geotiffread([Path_TAVG12IND,'Cnn12RMSE.SUM.2001.2015.tif']);
    CrseAUT = geotiffread([Path_TAVG12IND,'Cnn12RMSE.AUT.2001.2015.tif']);
    CrseWIN = geotiffread([Path_TAVG12IND,'Cnn12RMSE.WIN.2001.2015.tif']);
    
    BrseSPR = geotiffread([Path_TAVG12IND,'Bio12RMSE.SPR.2001.2015.tif']);
    BrseWIN = geotiffread([Path_TAVG12IND,'Bio12RMSE.WIN.2001.2015.tif']);
  
[Landcover,R] = geotiffread([Path_LandCover,'LCT_Mul_CMG025_USGS.tif']);  %Landcover坐标

    
    % SD type
    CSDspr=CrseSPR;
    CSDsum=CrseSUM;
    CSDaut=CrseAUT;
    CSDwin=CrseWIN;

        
    BSDspr=BrseSPR;
    BSDsum=BrseWIN;

    
    CSDspr(Landcover==1 | Landcover==2 | Landcover == 3 | Landcover == 4| Landcover == 5)= nan;
    CSDsum(Landcover==1 | Landcover==2 | Landcover == 3 | Landcover == 4| Landcover == 5)= nan;
    CSDaut(Landcover==1 | Landcover==2 | Landcover == 3 | Landcover == 4| Landcover == 5)= nan;
    CSDwin(Landcover==1 | Landcover==2 | Landcover == 3 | Landcover == 4| Landcover == 5)= nan;

    BSDspr(Landcover==1 | Landcover==2 | Landcover == 3 | Landcover == 4| Landcover == 5)= nan;
    BSDsum(Landcover==1 | Landcover==2 | Landcover == 3 | Landcover == 4| Landcover == 5)= nan;

    
    SDSPRC = reshape(CSDspr,[],1);
    SDSUMC = reshape(CSDsum,[],1);
    SDAUTC = reshape(CSDaut,[],1); 
    SDWINC = reshape(CSDwin,[],1); 

    SDSPRB = reshape(BSDspr,[],1);
    SDWINB = reshape(BSDsum,[],1);


%     DV type
    CDVspr=CrseSPR;
    CDVsum=CrseSUM;
    CDVaut=CrseAUT;
    CDVwin=CrseWIN;

        
    BDVspr=BrseSPR;
    BDVwin=BrseWIN;

    
    CDVspr(Landcover==1 | Landcover==2  | Landcover == 6 |...
      Landcover == 7 | Landcover == 8 | Landcover == 9 | Landcover == 10)= nan;
    CDVsum(Landcover==1 | Landcover==2  | Landcover == 6 |...
      Landcover == 7 | Landcover == 8 | Landcover == 9 | Landcover == 10)= nan;
    CDVaut(Landcover==1 | Landcover==2  | Landcover == 6 |...
      Landcover == 7 | Landcover == 8 | Landcover == 9 | Landcover == 10)= nan;
    CDVwin(Landcover==1 | Landcover==2  | Landcover == 6 |...
      Landcover == 7 | Landcover == 8 | Landcover == 9 | Landcover == 10)= nan;

    BDVspr(Landcover==1 | Landcover==2  | Landcover == 6 |...
      Landcover == 7 | Landcover == 8 | Landcover == 9 | Landcover == 10)= nan;
    BDVwin(Landcover==1 | Landcover==2  | Landcover == 6 |...
      Landcover == 7 | Landcover == 8 | Landcover == 9 | Landcover == 10)= nan;

    
    DVSPRC = reshape(CDVspr,[],1);
    DVSUMC = reshape(CDVsum,[],1);
    DVAUTC = reshape(CDVaut,[],1); 
    DVWINC = reshape(CDVwin,[],1); 

    DVSPRB = reshape(BDVspr,[],1);
    DVWINB = reshape(BDVwin,[],1);


%     EV type
   
    CEVspr=CrseSPR;
    CEVsum=CrseSUM;
    CEVaut=CrseAUT;
    CEVwin=CrseWIN;

        
    BEVspr=BrseSPR;
    BEVwin=BrseWIN;

    
    CEVspr(Landcover==3 | Landcover==4 | Landcover == 5 | Landcover == 6 |...
    Landcover == 7 | Landcover == 8 | Landcover == 9 | Landcover == 10)=nan;

    CEVsum(Landcover==3 | Landcover==4 | Landcover == 5 | Landcover == 6 |...
    Landcover == 7 | Landcover == 8 | Landcover == 9 | Landcover == 10)=nan;

    CEVaut(Landcover==3 | Landcover==4 | Landcover == 5 | Landcover == 6 |...
    Landcover == 7 | Landcover == 8 | Landcover == 9 | Landcover == 10)=nan;
    
    CEVwin(Landcover==3 | Landcover==4 | Landcover == 5 | Landcover == 6 |...
    Landcover == 7 | Landcover == 8 | Landcover == 9 | Landcover == 10)=nan;

    BEVspr(Landcover==3 | Landcover==4 | Landcover == 5 | Landcover == 6 |...
    Landcover == 7 | Landcover == 8 | Landcover == 9 | Landcover == 10)=nan;
    
    BEVwin(Landcover==3 | Landcover==4 | Landcover == 5 | Landcover == 6 |...
    Landcover == 7 | Landcover == 8 | Landcover == 9 | Landcover == 10)=nan;


    
    EVSPRC = reshape(CEVspr,[],1);
    EVSUMC = reshape(CEVsum,[],1);
    EVAUTC = reshape(CEVaut,[],1); 
    EVWINC = reshape(CEVwin,[],1); 

   
%% Boxplot figure
Fig=figure;
set(gcf,'position',[100 100 1000 600],'defaultAxesFontSize',22);  
set(gca,'Units','Pixels','Position',[100 90 890 510]);box off;hold on;

    boxplot([SDSPRC,DVSPRC,EVSPRC,SDSUMC,DVSUMC,EVSUMC,SDAUTC,DVAUTC,EVAUTC,SDWINC,DVWINC,EVWINC],'symbol','','Labels',...
        {'SDV','DV','EV','SDV','DV','EV','SDV','DV','EV','SDV','DV','EV'},...
         'BoxStyle','outline','Colors',[[0 0.392 0];[0 0.5451 0.5451];[0.56 0.735 0.56];...
         [1 0.72 0.05];[0.72 0.525 0.004];[1 0.843 0];...
         [0.647 0.164 0.164];[0.823 0.411 0.117];[1 0.388 0.278];...
         [0 0 0.5451];[0.27 0.51 0.71];[0.580  0.784  0.937]],'Widths',0.3);

% set(gca,'ylim',[-4 80],'ytick',0:10:80,'fontsize',20,'FontWeight','bold','Fontname','Times New Roman');   
set(gca,'ylim',[-4 180],'ytick',0:40:180,'fontsize',20,'FontWeight','bold','Fontname','Times New Roman');   

    boxplot([SDSPRC,DVSPRC,EVSPRC,SDSUMC,DVSUMC,EVSUMC,SDAUTC,DVAUTC,EVAUTC,SDWINC,DVWINC,EVWINC],'symbol','','Labels',...
        {'SDV','DV','EV','SDV','DV','EV','SDV','DV','EV','SDV','DV','EV'},...
         'BoxStyle','filled','Colors',[[0 0.392 0];[0 0.5451 0.5451];[0.56 0.735 0.56];...
         [1 0.72 0.05];[0.72 0.525 0.004];[1 0.843 0];...
         [0.647 0.164 0.164];[0.823 0.411 0.117];[1 0.388 0.278];...
         [0 0 0.5451];[0.27 0.51 0.71];[0.580  0.784  0.937]],'Widths',0.3);

   
    set(gca,'ylim',[-4 180],'ytick',0:40:180,'fontsize',20,'FontWeight','bold','Fontname','Times New Roman');   

ylabel('RMSE (day)','FontWeight','bold','Fontname','Times New Roman','Fontsize',28,'Color','k');
text('String',['a) 1D-CNNR'],...
    'Units','Normalized','Position',[0.04 0.90],'FontWeight','bold','Fontname','Times New Roman','Fontsize',28); 
text('String',['green-up'],...
    'Units','Normalized','Position',[0.03 -0.10],'FontWeight','bold','Fontname','Times New Roman','Fontsize',28); 
text('String',['maturation'],...
    'Units','Normalized','Position',[0.26 -0.10],'FontWeight','bold','Fontname','Times New Roman','Fontsize',28); 
text('String',['senescence'],...
    'Units','Normalized','Position',[0.52 -0.10],'FontWeight','bold','Fontname','Times New Roman','Fontsize',28); 
text('String',['dormancy'],...
    'Units','Normalized','Position',[0.78 -0.10],'FontWeight','bold','Fontname','Times New Roman','Fontsize',28); 

pause(5); set(gcf,'position',[100 100 1000 600],'defaultAxesFontSize',12);  

print(Fig,'-dtiff','-r300',[Path_Figure,'BoxC','.tif']);close(Fig);


Fig=figure;
set(gcf,'position',[100 100 540 600],'defaultAxesFontSize',24);  
set(gca,'Units','Pixels','Position',[90 90 440 510]);box off;hold on;


Bbox=boxplot([SDSPRB,DVSPRB,SDWINB,DVWINB],'symbol','','Notch','off','Labels',{'SDV','DV','SDV','DV'},...
    'BoxStyle','outline','Colors',[[0 0.392 0];[0 0.5451 0.5451];[0 0 0.5451];[0.27 0.51 0.71]],'Widths',0.3);
Bbox=boxplot([SDSPRB,DVSPRB,SDWINB,DVWINB],'symbol','','Notch','off','Labels',{'SDV','DV','SDV','DV'},...
    'BoxStyle','filled','Colors',[[0 0.392 0];[0 0.5451 0.5451];[0 0 0.5451];[0.27 0.51 0.71]],'Widths',0.3);


set(gca,'ylim',[-4 180],'ytick',0:40:180,'fontsize',20,'FontWeight','bold','Fontname','Times New Roman');   

ylabel('RMSE (day)','FontWeight','bold','Fontname','Times New Roman','Fontsize',28,'Color','k');
text('String',['b) Biome-BGC'],...
    'Units','Normalized','Position',[0.04 0.90],'FontWeight','bold','Fontname','Times New Roman','Fontsize',28); 
text('String',['green-up'],...
    'Units','Normalized','Position',[0.08 -0.10],'FontWeight','bold','Fontname','Times New Roman','Fontsize',28); 
text('String',['dormancy'],...
    'Units','Normalized','Position',[0.55 -0.10],'FontWeight','bold','Fontname','Times New Roman','Fontsize',28); 



pause(5); set(gcf,'position',[100 100 550 600],'defaultAxesFontSize',12);  

print(Fig,'-dtiff','-r300',[Path_Figure,'BoxB','.tif']);close(Fig);


%% Combine

Fig1=imread([Path_Figure,'BoxC.tif']);
Fig2=imread([Path_Figure,'BoxB.tif']);

Fig=cat(1,cat(2,Fig1,Fig2));
Fig=imresize(Fig,2244/size(Fig,2));

imwrite(Fig,[Path_Figure,'ModelBOX.tif'],'Compression','LZW','Resolution',300);

delete([Path_Figure,'Box*','.tif']);

