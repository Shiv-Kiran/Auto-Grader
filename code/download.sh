#! /bin/bash

if (( $#==2 ))
then
  wget -nH -qc -np -r -R tmp,"index.html" --cut-dirs=$2 $1
  for d in */
  do 
  	#echo "$d"
  	mv $d mock_grading 2>/dev/null
  done
else
  echo Usage: bash $0 $1 $2 
  #echo Usage: bash download.sh \<link to directory\ \<cut-dirs argument\>
fi


echo mock_grading directory downloaded
