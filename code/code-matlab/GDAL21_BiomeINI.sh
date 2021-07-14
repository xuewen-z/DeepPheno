#!/bin/bash
InPath='../output/20_Soil2TIF';
OuPath='../output/20_Soil2TIF';


Thread=1;
for InName in $(ls $InPath/*.tif); do
  InFile=$(echo $InName | awk -F/ '{print $NF}');
  OuFile=$(echo $InFile | sed 's/1KM/25KM/g') ;
  OuName=$OuPath/$OuFile;

  echo "gdalwarp $InName $OuName -r average -tr 0.2500 0.2500 -te -180 -60 180 90 -co COMPRESS=DEFLATE -t_srs \""+proj=longlat +ellps=WGS84\"" & "

  gdalwarp $InName $OuName -r average -tr 0.2500 0.2500 -te -180 -60 180 90 -co COMPRESS=DEFLATE -t_srs "+proj=longlat +ellps=WGS84" &

  echo $(( Thread++ )); if (( $Thread % 12 ==0 )); then wait; fi
done

