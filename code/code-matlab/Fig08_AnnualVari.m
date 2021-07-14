
clear;

Path_AnnualVar = '../output/29_AnnualVar/' ;
Path_Figure    = '../figure/';

%% spr       
        load([Path_AnnualVar,'CNNAnualVar.ASPR.mat']);
        load([Path_AnnualVar,'OBSAnualVar.ASPR.mat']);
        load([Path_AnnualVar,'BioAnualVar.ASPR.mat']);

%% figure

    Fig=figure;
    set(gcf,'position',[120 120 720 600],'defaultAxesFontSize',30);
    set(gca,'Units','Pixels','Position',[120 80 580 500],'Color','none');box on;hold on;
    x=(2001:2015);

    set(gca,'ylim',[100 160],'ytick',90:20:160,'fontsize',28,'Fontname','Times New Roman'); 
    set(gca,'xlim',[2001 2015],'xtick',2001:4:2015,'fontsize',32,'Fontname','Times New Roman');      
    CNNn = plot(x,NorCanu,'color',[0.2  0.2  0.976],'LineWidth',8);

    hold on; 
    OBSn = plot(x,NorOanu,'color',[0.133 0.133 0.133],'LineWidth',8); 
    BIOn = plot(x,NorBanu,'color',[0.11 0.52 0.11],'LineWidth',8); 

ylabel('Green-up (day)','FontWeight','bold','Fontname','Times New Roman','Fontsize',32,'Color','k');
text('String',['a) the NH'],...
    'Units','Normalized','Position',[0.04 0.90],'FontWeight','bold','Fontname','Times New Roman','Fontsize',32); 

HLegend=legend([OBSn,CNNn,BIOn],{'MODIS','1D-CNNR','Biome-BGC'});
set(HLegend,'Units','Pixels','Position',[180 100 760 150],'Box','off','EdgeColor','w','FontWeight','bold','fontsize',24);


pause(5); set(gcf,'position',[120 120 720 600],'defaultAxesFontSize',12);  

print(Fig,'-dtiff','-r300',[Path_Figure,'AnuSPRNH','.tif']);close(Fig);

% SH
    Fig=figure;
    set(gcf,'position',[120 120 720 600],'defaultAxesFontSize',30);
    set(gca,'Units','Pixels','Position',[120 80 580 500],'Color','none');box on;hold on;
    x=(2001:2015);
    
    set(gca,'ylim',[200 310],'ytick',180:30:310,'fontsize',28,'Fontname','Times New Roman'); 
    set(gca,'xlim',[2001 2015],'xtick',2001:4:2015,'fontsize',32,'Fontname','Times New Roman');      
    CNNs = plot(x,SouCanu,'color',[0.2  0.2  0.976],'LineWidth',8);

    hold on; 
    OBSs = plot(x,SouOanu,'color',[0.133 0.133 0.133],'LineWidth',8); 
    BIOs = plot(x,SouBanu,'color',[0.11 0.52 0.11],'LineWidth',8); 


ylabel('Green-up (day)','FontWeight','bold','Fontname','Times New Roman','Fontsize',32,'Color','k');
text('String',['e) the SH'],...
    'Units','Normalized','Position',[0.04 0.90],'FontWeight','bold','Fontname','Times New Roman','Fontsize',32); 

pause(5); set(gcf,'position',[120 120 720 600],'defaultAxesFontSize',12);  

print(Fig,'-dtiff','-r300',[Path_Figure,'AnuSPRSH','.tif']);close(Fig);



%% win       
        load([Path_AnnualVar,'CNNAnualVar.AWIN.mat']);
        load([Path_AnnualVar,'OBSAnualVar.AWIN.mat']);
        load([Path_AnnualVar,'BioAnualVar.AWIN.mat']);

%% figure

    Fig=figure;
    set(gcf,'position',[120 120 720 600],'defaultAxesFontSize',30);
    set(gca,'Units','Pixels','Position',[120 80 580 500],'Color','none');box on;hold on;
    x=(2001:2015);

    set(gca,'ylim',[240 300],'ytick',230:20:300,'fontsize',28,'Fontname','Times New Roman'); 
    set(gca,'xlim',[2001 2015],'xtick',2001:4:2015,'fontsize',32,'Fontname','Times New Roman');      
    CNNn = plot(x,NorCanu,'color',[0.2  0.2  0.976],'LineWidth',8);

    hold on; 
    OBSn = plot(x,NorOanu,'color',[0.133 0.133 0.133],'LineWidth',8); 
    BIOn = plot(x,NorBanu,'color',[0.11 0.52 0.11],'LineWidth',8); 


ylabel('Dormancy (day)','FontWeight','bold','Fontname','Times New Roman','Fontsize',32,'Color','k');
text('String',['d) the NH'],...
    'Units','Normalized','Position',[0.04 0.90],'FontWeight','bold','Fontname','Times New Roman','Fontsize',32); 



pause(5); set(gcf,'position',[120 120 720 600],'defaultAxesFontSize',12);  

print(Fig,'-dtiff','-r300',[Path_Figure,'AnuWINNH','.tif']);close(Fig);

% SH
    Fig=figure;
    set(gcf,'position',[120 120 720 600],'defaultAxesFontSize',30);
    set(gca,'Units','Pixels','Position',[120 80 580 500],'Color','none');box on;hold on;
    x=(2001:2015);

    set(gca,'ylim',[60 220],'ytick',50:40:220,'fontsize',28,'Fontname','Times New Roman'); 
    set(gca,'xlim',[2001 2015],'xtick',2001:4:2015,'fontsize',32,'Fontname','Times New Roman');      

    CNNs = plot(x,SouCanu,'color',[0.2  0.2  0.976],'LineWidth',8);

    hold on; 
    OBSs = plot(x,SouOanu,'color',[0.133 0.133 0.133],'LineWidth',8); 
    BIOs = plot(x,SouBanu,'color',[0.11 0.52 0.11],'LineWidth',8); 


ylabel('Dormancy (day)','FontWeight','bold','Fontname','Times New Roman','Fontsize',32,'Color','k');
text('String',['h) the SH'],...
    'Units','Normalized','Position',[0.04 0.90],'FontWeight','bold','Fontname','Times New Roman','Fontsize',32); 

pause(5); set(gcf,'position',[120 120 720 600],'defaultAxesFontSize',12);  

print(Fig,'-dtiff','-r300',[Path_Figure,'AnuWINSH','.tif']);close(Fig);

%% SUM       
        load([Path_AnnualVar,'CNNAnualVar.ASUM.mat']);
        load([Path_AnnualVar,'OBSAnualVar.ASUM.mat']);

%% figure

    Fig=figure;
    set(gcf,'position',[120 120 720 600],'defaultAxesFontSize',30);
    set(gca,'Units','Pixels','Position',[120 80 580 500],'Color','none');box on;hold on;
    x=(2001:2015);

    set(gca,'ylim',[150 210],'ytick',140:20:210,'fontsize',28,'Fontname','Times New Roman'); 
    set(gca,'xlim',[2001 2015],'xtick',2001:4:2015,'fontsize',32,'Fontname','Times New Roman');      
    CNNn = plot(x,NorCanu,'color',[0.2  0.2  0.976],'LineWidth',8);

    hold on; 
    OBSn = plot(x,NorOanu,'color',[0.133 0.133 0.133],'LineWidth',8); 


ylabel('Maturation (day)','FontWeight','bold','Fontname','Times New Roman','Fontsize',32,'Color','k');
% xlabel('MODIS (day)','FontWeight','bold','Fontname','Times New Roman','Fontsize',22,'Color','k');
text('String',['b) the NH'],...
    'Units','Normalized','Position',[0.04 0.90],'FontWeight','bold','Fontname','Times New Roman','Fontsize',32); 


pause(5); set(gcf,'position',[120 120 720 600],'defaultAxesFontSize',12);  

print(Fig,'-dtiff','-r300',[Path_Figure,'AnuSUMNH','.tif']);close(Fig);

% SH
    Fig=figure;
    set(gcf,'position',[120 120 720 600],'defaultAxesFontSize',30);
    set(gca,'Units','Pixels','Position',[120 80 580 500],'Color','none');box on;hold on;
    x=(2001:2015);

    set(gca,'ylim',[60 220],'ytick',50:40:220,'fontsize',28,'Fontname','Times New Roman'); 
    set(gca,'xlim',[2001 2015],'xtick',2001:4:2015,'fontsize',32,'Fontname','Times New Roman');      
    CNNs = plot(x,SouCanu,'color',[0.2  0.2  0.976],'LineWidth',8);

    hold on; 
    OBSs = plot(x,SouOanu,'color',[0.133 0.133 0.133],'LineWidth',8); 


ylabel('Maturation (day)','FontWeight','bold','Fontname','Times New Roman','Fontsize',32,'Color','k');
text('String',['f) the SH'],...
    'Units','Normalized','Position',[0.04 0.90],'FontWeight','bold','Fontname','Times New Roman','Fontsize',32); 

pause(5); set(gcf,'position',[120 120 720 600],'defaultAxesFontSize',12);  

print(Fig,'-dtiff','-r300',[Path_Figure,'AnuSUMSH','.tif']);close(Fig);

%% Aut       
        load([Path_AnnualVar,'CNNAnualVar.AAUT.mat']);
        load([Path_AnnualVar,'OBSAnualVar.AAUT.mat']);

%% figure

    Fig=figure;
    set(gcf,'position',[120 120 720 600],'defaultAxesFontSize',30);
    set(gca,'Units','Pixels','Position',[120 80 580 500],'Color','none');box on;hold on;
    x=(2001:2015);

    set(gca,'ylim',[190 250],'ytick',180:20:250,'fontsize',28,'Fontname','Times New Roman'); 
    set(gca,'xlim',[2001 2015],'xtick',2001:4:2015,'fontsize',32,'Fontname','Times New Roman');      
    CNNn = plot(x,NorCanu,'color',[0.2  0.2  0.976],'LineWidth',8);

    hold on; 
    OBSn = plot(x,NorOanu,'color',[0.133 0.133 0.133],'LineWidth',8); 


ylabel('Senescence (day)','FontWeight','bold','Fontname','Times New Roman','Fontsize',32,'Color','k');
% xlabel('MODIS (day)','FontWeight','bold','Fontname','Times New Roman','Fontsize',22,'Color','k');
text('String',['c) the NH'],...
    'Units','Normalized','Position',[0.04 0.90],'FontWeight','bold','Fontname','Times New Roman','Fontsize',32); 



pause(5); set(gcf,'position',[120 120 720 600],'defaultAxesFontSize',12);  

print(Fig,'-dtiff','-r300',[Path_Figure,'AnuAUTNH','.tif']);close(Fig);

% SH
    Fig=figure;
    set(gcf,'position',[120 120 720 600],'defaultAxesFontSize',30);
    set(gca,'Units','Pixels','Position',[120 80 580 500],'Color','none');box on;hold on;
    x=(2001:2015);

    set(gca,'ylim',[60 220],'ytick',50:40:220,'fontsize',28,'Fontname','Times New Roman'); 
    set(gca,'xlim',[2001 2015],'xtick',2001:4:2015,'fontsize',32,'Fontname','Times New Roman');      
    CNNs = plot(x,SouCanu,'color',[0.2  0.2  0.976],'LineWidth',8);

    hold on; 
    OBSs = plot(x,SouOanu,'color',[0.133 0.133 0.133],'LineWidth',8); 


ylabel('Senescence (day)','FontWeight','bold','Fontname','Times New Roman','Fontsize',32,'Color','k');
text('String',['g) the SH'],...
    'Units','Normalized','Position',[0.04 0.90],'FontWeight','bold','Fontname','Times New Roman','Fontsize',32); 

pause(5); set(gcf,'position',[120 120 720 600],'defaultAxesFontSize',12);  

print(Fig,'-dtiff','-r300',[Path_Figure,'AnuAUTSH','.tif']);close(Fig);


%% Combine

Fig1=imread([Path_Figure,'AnuSPRNH.tif']);
Fig2=imread([Path_Figure,'AnuSPRSH.tif']);
Fig3=imread([Path_Figure,'AnuSUMNH.tif']);
Fig4=imread([Path_Figure,'AnuSUMSH.tif']);
Fig5=imread([Path_Figure,'AnuAUTNH.tif']);
Fig6=imread([Path_Figure,'AnuAUTSH.tif']);
Fig7=imread([Path_Figure,'AnuWINNH.tif']);
Fig8=imread([Path_Figure,'AnuWINSH.tif']);

Fig=cat(1,cat(2,Fig1,Fig3,Fig5,Fig7),cat(2,Fig2,Fig4,Fig6,Fig8));

Fig=imresize(Fig,2244/size(Fig,2));

imwrite(Fig,[Path_Figure,'FigAnuVar.tif'],'Compression','LZW','Resolution',300);

delete([Path_Figure,'Anu*','.tif']);

