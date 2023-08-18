#! /bin/bash



declare -a files


mkdir organised -p

cd mock_grading

while read line
do
	cd ../organised/
	mkdir "$line" -p
	cd ../mock_grading/
done < roll_list

cd submissions/
for file in *
do 
	files+=($file)
done

cd ../../organised

for file in *
do 
	for i in ${files[@]}
	do
			
		temp=$(basename $i)
		temp=${temp:0:${#file}}
		#echo $temp
		if (($file == $temp))
		then
			#echo $file $i
			ln -s ../../mock_grading/submissions/$i $file/ 
		
		fi
	done
done

echo organised directory created























