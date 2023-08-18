#!/bin/bash

touch distribution.txt
touch marksheet.csv

cd organised/
score=0
declare -a scores
scores=()

for files in *
do
	cd $files/
	mkdir student_outputs -p
	for i in *.cpp
	do
		g++ $i -o executable 2>/dev/null
		for j in ../../mock_grading/inputs/*
		do
			temp=$(basename "$j" .in)
			timeout 5 ./executable < $j > student_outputs/$temp.out 2>/dev/null |:
		done
	done
	cd student_outputs/
	for j in *
	do
		if  cmp -s "$j" "../../../mock_grading/outputs/$j" 
		then
			(( score++ ))
			#echo $j files are identical!
		#else
			#echo Outputs are not identical
		fi
	done
	cd ..
	#echo $files
	#echo $score
	printf '%s\n' $files $score | paste -sd ',' >> ../../marksheet.csv
	scores+=( $score )
	score=$(( 0 ))
	cd ..
done
echo Contents of marksheet.csv
cat ../marksheet.csv
IFS=$'\n' sorted=($(sort -r <<<"${scores[*]}")); unset IFS
printf "%s\n" "${sorted[@]}" >> ../distribution.txt
echo Contents of distribution.txt:
cat ../distribution.txt
