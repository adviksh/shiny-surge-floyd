#!/bin/bash

fips=(01 02 04 05 06 08 09 10 11 12 13 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39 40 41 42 44 45 46 47 48 49 50 51 53 54 55 56)

for fp in "${fips[@]}"
do
  url="https://www2.census.gov/geo/tiger/TIGER2018/BG/tl_2018_"$fp"_bg.zip"
  local_zip="tl_2018_"$fp"_bg.zip"
  local_dir="tl_2018_"$fp"_bg"
  curl $url --output $local_zip
  unzip $local_zip -d $local_dir
  rm -rf $local_zip
done