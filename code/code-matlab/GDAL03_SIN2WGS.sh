#!/bin/bash
InPath='../output/02_MRG12YPHN';
OuPath='../output/03_WGS12YPHN';

rm -rf   $OuPath/
mkdir -p $OuPath/

Thread=0;

for InName in $(ls $InPath/*tif); do
  InFile=$(echo $InName | awk -F/ '{print $NF}');
  OuFile=$(echo $InFile | sed 's/MRG/WGS/g') ; 
  OuName=$OuPath/$OuFile;

  echo "$InName $OuName -ts 86400 36000 -te -180 -60 180 90 -co COMPRESS=LZW -t_srs '+proj=longlat +ellps=WGS84'"" & "

  gdalwarp $InName $OuName -ts 86400 36000 -te -180 -60 180 90 -co COMPRESS=LZW -t_srs "+proj=longlat +ellps=WGS84" &

  echo $(( Thread++ )); if (( $Thread % 12 ==0 )); then wait; fi
done

