#!/bin/bash

InDir='../output/01_MCD12YPHN';
OuDir='../output/02_MRG12YPHN';

rm -rf $OuDir/
mkdir -p $OuDir/

Thread=0;
Number=4;

#for Year in {2005..2005..1}; do
for Year in {2001..2016..1}; do
  YearName="A$Year"
  
  #InName=$(ls $InDir/$Year/*"$YearName"*);
  InName=$(ls $InDir/$Year/"MCD12SPR"*);
  OuName=$OuDir/"MRG12SPR.$YearName""001.006.tif";

  echo "gdal_merge.py -o $OuName $(echo $InName)"
  gdal_merge.py -co COMPRESS=LZW -o $OuName $(echo $InName) &


  InName=$(ls $InDir/$Year/"MCD12SUM"*);
  OuName=$OuDir/"MRG12SUM.$YearName""001.006.tif";

  echo "gdal_merge.py -o $OuName $(echo $InName)"
  gdal_merge.py -co COMPRESS=LZW -o $OuName $(echo $InName) &


  InName=$(ls $InDir/$Year/"MCD12AUT"*);
  OuName=$OuDir/"MRG12AUT.$YearName""001.006.tif";

  echo "gdal_merge.py -o $OuName $(echo $InName)"
  gdal_merge.py -co COMPRESS=LZW -o $OuName $(echo $InName) &


  InName=$(ls $InDir/$Year/"MCD12WIN"*);
  OuName=$OuDir/"MRG12WIN.$YearName""001.006.tif";

  echo "gdal_merge.py -o $OuName $(echo $InName)"
  gdal_merge.py -co COMPRESS=LZW -o $OuName $(echo $InName) &

  Thread=`expr $Thread + $Number`;echo $Thread; if (( $Thread % 12 ==0 )); then wait; fi

done

