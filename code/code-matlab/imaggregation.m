function ImaOUT = imaggregation(ImaIN,n,Fct)
%%Description
%   ImaOUT = imaggregation(ImaIN,n,Fct)
%
%   resize an image to a smaller one using 7 possible function
%
%INPUT:
%   ImaIN: image N dimension
%   n: factor for aggregation.
%   Fct: type of aggregation 
%   (1=mean (default); 2=mode; 3=std; 4=min; 5=max; 6=median; 7=nanmean; 8=nansum; 9=nanstd; 10=nanmedian)
%
%OUTPUT
%   ImaOUT: aggregated image.
%
%Example
%   if ImaIN is a 100 by 100 image and n=4, ImaOUT will be a 25*25 image
%   ImaOUT = imaggregation(ImaIN,4,Fct);
%
%Notice
%   It works with N dimension image and an extra dimension is temporally added to compute the aggregation.
%   There is no pixel by pixel (time consuming) computation.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   Author: Martin Claverie, Univesity of Maryland
%   $Date: November 2012 $
%   Modified by Qinchuan Xin
%   $Date: 2013/11/25 $
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

d=[];
ClassT = class(ImaIN);

DimIma = ndims(ImaIN);

for i=1:n
  for j=1:n
    d=cat(DimIma+1,d,ImaIN(i:n:end-(n-i),j:n:end-(n-j),:));
  end
end

if nargin<3
  Fct=1;
end

switch Fct
  case 1
    ImaOUT =mean(double(d),DimIma+1);
  case 2
    ImaOUT =mode(double(d),DimIma+1);
  case 3
    ImaOUT =std(double(d),[],DimIma+1);
  case 4
    ImaOUT =min(double(d),[],DimIma+1);
  case 5
    ImaOUT =max(double(d),[],DimIma+1);
  case 6
    ImaOUT =median(double(d),DimIma+1);
  case 7
    ImaOUT =nanmean(double(d),DimIma+1);
  case 8
    ImaOUT =nansum(double(d),DimIma+1);
  case 9
    ImaOUT =nanstd(double(d),0,DimIma+1);
  case 10
    ImaOUT =nanmedian(double(d),DimIma+1);
end

ImaOUT = cast(ImaOUT,ClassT);
