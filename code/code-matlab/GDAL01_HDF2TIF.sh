#!/bin/bash

InDir='../input/MCD12Q2';
OuDir='../output/01_MCD12YPHN';

rm -rf $OuDir/
mkdir -p $OuDir/

#Year=2002;
for Year in {2001..2016..1}; do

  mkdir -p  $OuDir/$Year

  Thread=0;
  Number=4;

  for InName in $(ls $InDir/$Year/*"MCD12Q2"*); do
    InFile=$(echo $InName | awk -F/ '{print $NF}');

    # spring
    OuFile=$(echo $InFile | sed 's/hdf/tif/g' | sed 's/MCD12Q2/MCD12SPR/g') ;
    OuName=$OuDir/$Year/$OuFile;

    echo "gdal_translate HDF4_EOS:EOS_GRID:"$InName":MCD12Q2:Greenup -co @COMPRESS=LZW@ $OuName";
    gdal_translate HDF4_EOS:EOS_GRID:"$InName":MCD12Q2:Greenup -co "COMPRESS=LZW" $OuName &

    # summer
    OuFile=$(echo $InFile | sed 's/hdf/tif/g' | sed 's/MCD12Q2/MCD12SUM/g') ;
    OuName=$OuDir/$Year/$OuFile;

    echo "gdal_translate HDF4_EOS:EOS_GRID:"$InName":MCD12Q2:Maturity -co @COMPRESS=LZW@ $OuName";
    gdal_translate HDF4_EOS:EOS_GRID:"$InName":MCD12Q2:Maturity -co "COMPRESS=LZW" $OuName &


    # autumn
    OuFile=$(echo $InFile | sed 's/hdf/tif/g' | sed 's/MCD12Q2/MCD12AUT/g') ;
    OuName=$OuDir/$Year/$OuFile;

    echo "gdal_translate HDF4_EOS:EOS_GRID:"$InName":MCD12Q2:Senescence -co @COMPRESS=LZW@ $OuName";
    gdal_translate HDF4_EOS:EOS_GRID:"$InName":MCD12Q2:Senescence -co "COMPRESS=LZW" $OuName &


    # winter
    OuFile=$(echo $InFile | sed 's/hdf/tif/g' | sed 's/MCD12Q2/MCD12WIN/g') ;
    OuName=$OuDir/$Year/$OuFile;

    echo "gdal_translate HDF4_EOS:EOS_GRID:"$InName":MCD12Q2:Dormancy -co @COMPRESS=LZW@ $OuName";
    gdal_translate HDF4_EOS:EOS_GRID:"$InName":MCD12Q2:Dormancy -co "COMPRESS=LZW" $OuName &

    Thread=`expr $Thread + $Number`;echo $Thread; if (( $Thread % 12 ==0 )); then wait; fi

  done

  rm -rf $OuDir/$Year/*xml
done




