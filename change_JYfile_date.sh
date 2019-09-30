#!/bin/bash

#获取当前路径
curr_path=`pwd`
#echo "curr_path is $curr_path"

#获取当天日期
curr_date=` date  +%Y%m%d `
#echo "curr_date is $curr_date"

#当前JY文件日期 --待优化  过滤字符
curr_JYfile=`  ls -lt  | awk '{print $8}' | grep  -v [^0-9,0-9$] |grep -v "^$"  `
#echo "curr_JYfile is $curr_JYfile"
dir_name=$curr_JYfile
#echo "dir_name is  $dir_name"
if [ "$dir_name" \< "$curr_date" ] ;then
     mv $dir_name   $curr_date
    # echo "changed dir_name is `ls | grep '201*'` "
	 
else
     echo "tips :"
     echo "this is already the latest JY_file ! "
     exit
fi

#进入数据JY文件夹
cd $curr_date
#读取所有JY文件
ls |grep 'PBOX*'  > tmp_JYfile_name.txt
#cat tmp_JYfile_name.txt


#复制
cat tmp_JYfile_name.txt > ori_tmp_JYfile_name.txt
#cat ori_tmp_JYfile_name.txt


#在JY文件中修改JY文件日期
#echo "$curr_JYfile"
#echo "$curr_date"
sed -i   "s/$curr_JYfile/$curr_date/g"   /home/ls1/JYfile/$curr_date/tmp_JYfile_name.txt
#echo "changed JYfile_name is : "
#cat tmp_JYfile_name.txt

#将原JY文件名称放到数组中arr_ori[]中。
num=`grep -o "PBOX_"   tmp_JYfile_name.txt | wc -l `
#echo "JY_file number is :  $num"
index=0
arr_ori=()
arr_new=()
for file_name in `cat ori_tmp_JYfile_name.txt`
do
 arr_ori[$index]=$file_name 
 #echo "arr_ori[$index] is : ${arr_ori[$index]}"
 index=$(($index+1))
done

#将目标日期的JY文件名称放到数组arr_new[]中。
index=0
for file_name in `cat tmp_JYfile_name.txt`
do
 arr_new[$index]=$file_name
 #echo "arr_new[$index] is : ${arr_new[$index]}"
 index=$(($index+1))
done

#更改JY文件名
for ((index=0; index<=$num-1; index++)) 
do  
    #echo "$index"
    #echo "${arr_ori[$index]}"
    #echo "${arr_new[$index]}"
    mv ${arr_ori[$index]}   ${arr_new[$index]}
done

echo "tips :"
echo "JY_file has been successfully changed !"

rm -f ori_tmp_JYfile_name.txt 
rm -f tmp_JYfile_name.txt
