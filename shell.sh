#!/bin/bash
#by Captain on 2/13/2019


# 判断文件/夹是否存在：
# https://www.cnblogs.com/fnlingnzb-learner/p/10238101.html

#！/bin/sh
# This is to show what a example looks like.
echo "Our first example"
echo # This inserts an empty line in output
echo "We are currently in the following directory."
/bin/pwd
echo
echo "This directory contains the following files"
/bin/ls

/bin/pwd 显示当前路径
pwd你会常用，前面加/bin/表示这个命令的绝对路径
/bin/ls 显示当前目录下的内容


变量
------------------
your_name="www.baidu.com"                #变量 your_name 赋值
echo $your_name                          #输出变量 要在变量前加$,可以使用 $your_name 或 ${your_name}
for file in `ls /`;do                    #for循环 `ls /` 目录下的文件,并赋值给file ;
   echo ${file}                          #在循环里输出 ${file}
done                                     #结束循环
#readonly your_name                      #把变量变成只读,只读后变量不能重新赋值
your_name="www.aliyun.com"               #重新赋值变量
echo ${your_name}                        #输出变量
unset your_name                          #删除变量
echo ${your_name}                        #删除变量后，将不会输出任何东西,unset 命令不能删除只读变量。



echo与printf
------------------
echo -e "ok \n"                          # echo -e 开启转义  \n是换行
echo `date`                              #显示命令执行结果,2019年 2月23日 星期六 10时57分05秒 CST

echo "echo command"                      # echo 输出，自带回车符
printf "printf command \n"               # printf 输出

printf "%-10s %-8s %-4s\n" 姓名 性别 体重kg
printf "%-10s %-8s %-4.2f\n" 郭靖 男 66.1234
printf "%-10s %-8s %-4.2f\n" 黄蓉 女 45.3241
printf "%-10s %-8s %-4.2f\n" 郭芙 女 42.1532

# %s %c %d %f都是格式替代符
# %-10s 指一个宽度为10个字符（-表示左对齐，没有则表示右对齐），任何字符都会被显示在10个字符宽的字符内，如果不足则自动以空格填充，超过也会将内容全部显示出来。
# %-4.2f 指格式化为小数，其中.2指保留2位小数。

printf  format-string  [arguments...]
printf "%d %s\n" 1 "abc"                 # format-string为前半部分双引号内容，也可以单引号，或者不要引号
printf %s abc def                        # 格式只指定了一个参数，但多出的参数仍然会按照该格式输出，format-string 被重用
printf "%s %s %s\n" a b c d e f g h i j



字符串
------------------
#字符串可以用单引号，也可以用双引号，也可以不用引号。
echo "It is a test"
echo It is a test                            #双引号可以省略

#双引号的优点：
#双引号里可以有变量
#双引号里可以出现转义字符
echo "\"It is a test\""                      #输出："It is a test"
echo '$name\"'                               #原样输出字符串，不进行转义或取变量(用单引号)

#拼接字符串
your_name="world"
str="hello, "$your_name" !"                  #字符串拼接变量再拼接字符串
str1="hello, ${your_name} !"                 #双引号里直接引用变量
echo $str $str1                              #输出  变量str 拼接 变量str1

#获取字符串长度
string="abcd"
echo ${#string}                              #字符串变量的大括号里加上#号，就可以获取字符串长度, ${#string}

#提取子字符串
#以下实例从字符串第 2 个字符开始截取 4 个字符：
string="hello world is a great world"
echo ${string:1:4}                           #输出 ello, 字符串第 2 个字符开始截取 4 个字符：

#查找子字符串
#查找字符 "i 或 s" 的位置：
string="hello world is a great world"
echo `expr index "$string" is`               # 输出 13, is的开始位置是13
#注意： 以上脚本中 "`" 是反引号，而不是单引号 "'"，不要看错了哦。



字符串截取八种方法
---------------------
var="http://www.baidu.com/123.htm"

#1. # 号截取，删除左边字符，保留右边字符。
echo ${var#*//}    

#其中 var 是变量名，# 号是运算符，*// 表示从左边开始删除第一个 // 号及左边的所有字符
#即删除 http://
#结果是 ：www.baidu.com/123.htm


#2. ## 号截取，删除左边字符，保留右边字符。
echo ${var##*/}

##*/ 表示从左边开始删除最后（最右边）一个 / 号及左边的所有字符
#即删除 http://www.aaa.com/
#结果是 123.htm


#3. %号截取，删除右边字符，保留左边字符
echo ${var%/*}

#%/* 表示从右边开始，删除第一个 / 号及右边的字符
#结果是：http://www.baidu.com


#4. %% 号截取，删除右边字符，保留左边字符
echo ${var%%/*}

#%%/* 表示从右边开始，删除最后（最左边）一个 / 号及右边的字符
#结果是：http:


#5. 从左边第几个字符开始，及字符的个数
echo ${var:0:5}

#其中的 0 表示左边第一个字符开始，5 表示字符的总个数。
#结果是：http:


#6. 从左边第几个字符开始，一直到结束。
echo ${var:7}

#其中的 7 表示左边第8个字符开始，一直到结束。
#结果是 ：www.baidu.com/123.htm


#7. 从右边第几个字符开始，及字符的个数
echo ${var:0-7:3}

#其中的 0-7 表示右边算起第七个字符开始，3 表示字符的个数。
#结果是：123


#8. 从右边第几个字符开始，一直到结束。
echo ${var:0-7}

#表示从右边第七个字符开始，一直到结束。
#结果是：123.htm

#注：（左边的第一个字符是用 0 表示，右边的第一个字符用 0-1 表示）



read
------------------
#read 命令从标准输入中读取一行,并把输入行的每个字段的值指定给 shell 变量
#!/bin/sh
read name 
echo "$name It is a test"
#以上代码保存为 test.sh，name 接收标准输入的变量，结果将是:
[root@www ~]# sh test.sh
OK                     #标准输入
OK It is a test        #输出



test
------------------
#数值测试
# -eq 等于则为真
# -ne 不等于则为真
# -gt 大于则为真
# -ge 大于等于则为真
# -lt 小于则为真
# -le 小于等于则为真

#!/bin/bash
num1=100
num2=200
if test ${num1} -eq ${num2}
then
   echo ${num1}"和"${num2}"相等"
else
   echo ${num1}"和"${num2}"不相等"
fi


##字符串判断
# = 等于则为真
# != 不相等则为真
# -z 字符串 字符串的长度为零则为真
# -n 字符串 字符串的长度不为零则为真
#!/bin/bash
str1="hello"
str2="world"
if test ${str1} = ${str2}
then
   echo ${str1}"和"${str2}"相等"
else
   echo ${str1}"和"${str2}"不相等"
fi


#文件测试参数 说明
# -e 文件名 如果文件存在则为真
# -r 文件名 如果文件存在且可读则为真
# -w 文件名 如果文件存在且可写则为真
# -x 文件名 如果文件存在且可执行则为真
# -s 文件名 如果文件存在且至少有一个字符则为真
# -d 文件名 如果文件存在且为目录则为真
# -f 文件名 如果文件存在且为普通文件则为真
# -c 文件名 如果文件存在且为字符型特殊文件则为真
# -b 文件名 如果文件存在且为块特殊文件则为真
dire="./etc"
if test -e ${dire}
then 
   echo ${dire}"存在"
else
   echo ${dire}"不存在"
fi

##另外，Shell还提供了与( -a )、或( -o )、非( ! )三个逻辑操作符用于将测试条件连接起来，其优先级为："!"最高，"-a"次之，"-o"最低。例如：
dire1="./bash1"
dire2="./bash2"
if test -e ${dire1} -o -e ${dire2}
then
   echo ${dire1}"或"${dire2}"至少有一个存在"
else
   echo ${dire1}"或"${dire2}"都不存在"
fi



[]
------------------
#!/bin/bash
a=5
b=6
result=$[a+b]        # 代码中 [] 执行基本的算数运算，注意等号两边不能有空格
echo "result为$result"



数组
------------------
array_name=(value0 value1 value2 value3)    #数组赋值
val=${array_name[n]}       #把 array_name[n]  赋值给 val
echo ${val}                #输出 val
echo ${array_name[@]}      #使用@符号可以获取数组中的所有元素

#获取数组长度的方法与获取字符串长度的方法相同，例如：
# 取得数组元素的个数
length=${#array_name[@]}
echo ${length}
# 或者
length=${#array_name[*]}
echo ${length}
# 取得数组单个元素的长度
lengthn=${#array_name[n]}
echo ${length}

note(){
这是一个注释，这个可以临时调用或者不调用达到注释的目的
}

单行注释：
# 这是被注释掉的多行文本
# 这里可以写任何内容，Shell会忽略它


多行注释：
: <<COMMENT
这是被注释掉的多行文本
这里可以写任何内容，Shell会忽略它
COMMENT

ipaddr="node1  node2  node3  node4  node5  node6"
iparr=($ipaddr)
for i in ${iparr[*]} #遍历每个数据
do
    echo $i
done
echo ${iparr[0]} # 获取第1个数据

if语句
------------------
if [[ condition ]]; then
	#statements
fi


if [[ condition ]]; then
	#statements
else
	#statements
fi


if [[ condition ]]; then
	#statements
elif [[ condition ]]; then
	#statements
elif [[ condition ]]; then
	#statements
else
	#statements
fi


#!/bin/sh
a=10
b=20
if [ $a == $b ]
then
echo "a is equal to b"
elif [ $a -gt $b ]
then
echo "a is greater than b"
elif [ $a -lt $b ]
then
echo "a is less than b"
else
echo "None of the condition met"
fi

#运行结果：
a is less than b

if也可以写成一行：
if test $[2*3] -eq $[1+5]; then echo 'The two numbers are equal!'; fi;



case语句
------------------
case 值 in
模式1)
command1
command2
command3
;;
模式2）
command1
command2
command3
;;
*)
command1
command2
command3
;;
esac


echo 'Input a number between 1 to 4'
echo 'Your number is:\c'
read aNum
case $aNum in
1) echo 'You select 1'
;;
2) echo 'You select 2'
;;
3) echo 'You select 3'
;;
4) echo 'You select 4'
;;
*) echo "You number $aNum is not between 1 to 4"  # *) echo You number ${aNum} is not between 1 to 4
;;
esac



for语句
------------------
for (( i = 0; i < 10; i++ )); do
	#statements
done

for i in words; do
	#statements
done


for loop in 1 2 3 4 5
do
echo "The value is: $loop"
done

#显示以bash开头的文件
#!/bin/bash
for FILE in $HOME/.bash*
do
echo $FILE
done


for...do...done
----------------------
卸载应用
#!/bin/bash
for var in us.pinguo.storm us.pinguo.filmFlex us.pinguo.catoon
do
   adb uninstall $var
done



while语句
------------------
while [[ condition ]]; do
	#statements
done

COUNTER=0
while [ $COUNTER -lt 5 ]
do
COUNTER='expr $COUNTER+1'
echo $COUNTER
done


until语句
------------------
until [[ condition ]]; do
	#statements
done


转为大小写
----------
# https://www.cnblogs.com/xiaonian8/p/13730126.html
#! /bin/sh

# 方法一
echo "iiii"
string="abcdEEEEE"
echo $string

#将字符串中的小写字母转换为大写字母
string="$(echo $string | tr '[:lower:]' '[:upper:]')"
echo $string

#将字符串中的大写字母转换为小写字母
string="$(echo $string | tr '[:upper:]' '[:lower:]')"
echo $string


# 方法二
echo $PATH | awk '{print toupper($0)}'
echo $PATH | awk '{print tolower($0)}'

# 文件大小写
awk '{print toupper($0)}' test.txt

#方法三：
echo $PATH | sed 's/[a-z]/\U&/g'
echo $PATH | sed 's/[A-Z]/\L&/g'




输出时间格式：
-------------
https://www.cnblogs.com/janezhao/p/9732157.html

1）原格式输出
2018年 09月 30日 星期日 15:55:15 CST

time1=$(date)
echo $time1
 

2）时间串输出
20180930155515

#!bin/bash
time2=$(date "+%Y%m%d%H%M%S")
echo $time2
 

3）格式化输出
2018-09-30 15:55:15

#!bin/bash
time3=$(date "+%Y-%m-%d %H:%M:%S")
echo $time3

4）
2018.09.30

#!bin/bash
time4=$(date "+%Y.%m.%d")
echo $time4

注意：

1、date后面有一个空格，shell对空格要求严格
2、变量赋值前后不要有空格
3、解释
1 Y显示4位年份，如：2018；y显示2位年份，如：18。
2 m表示月份；M表示分钟。
3 d表示天；D则表示当前日期，如：1/18/18(也就是2018.1.18)。
4 H表示小时，而h显示月份。
5 s显示当前秒钟，单位为毫秒；S显示当前秒钟，单位为秒。


shell截取字符串：
--------------
http://c.biancheng.net/view/1120.html
${string: start :length}    从 string 字符串的左边第 start 个字符开始，向右截取 length 个字符。
${string: start}    从 string 字符串的左边第 start 个字符开始截取，直到最后。
${string: 0-start :length}  从 string 字符串的右边第 start 个字符开始，向右截取 length 个字符。
${string: 0-start}  从 string 字符串的右边第 start 个字符开始截取，直到最后。
${string#*chars}    从 string 字符串第一次出现 *chars 的位置开始，截取 *chars 右边的所有字符。
${string##*chars}   从 string 字符串最后一次出现 *chars 的位置开始，截取 *chars 右边的所有字符。
${string%*chars}    从 string 字符串第一次出现 *chars 的位置开始，截取 *chars 左边的所有字符。
${string%%*chars}   从 string 字符串最后一次出现 *chars 的位置开始，截取 *chars 左边的所有字符。


url="c.biancheng.net"
echo ${url: 2: 9}
# biancheng

url="c.biancheng.net"
echo ${url: 2}  #省略 length，截取到字符串末尾
# biancheng.net

#!/bin/bash
从左边开始截取字符：#*, ##*
url="http://c.biancheng.net/index.html"
echo ${url#*:}
# //c.biancheng.net/index.html

url="http://c.biancheng.net/index.html"
echo ${url#*/}    #结果为 /c.biancheng.net/index.html
echo ${url##*/}   #结果为 index.html

str="---aa+++aa@@@"
echo ${str#*aa}   #结果为 +++aa@@@
echo ${str##*aa}  #结果为 @@@

#!/bin/bash
# 从右边开始截取：%*, 
# 从左边开始截取  %%*
url="http://c.biancheng.net/index.html"
echo ${url%/*}  #结果为 http://c.biancheng.net
echo ${url%%/*}  #结果为 http:

str="---aa+++aa@@@"
echo ${str%aa*}  #结果为 ---aa+++
echo ${str%%aa*}  #结果为 ---




判断文件或者文件夹是否存在：
---------------------
https://www.cnblogs.com/DreamDrive/p/7706585.html

-e filename 如果 filename存在，则为真 
-d filename 如果 filename为目录，则为真 
-f filename 如果 filename为常规文件，则为真 
-L filename 如果 filename为符号链接，则为真 
-r filename 如果 filename可读，则为真 
-w filename 如果 filename可写，则为真 
-x filename 如果 filename可执行，则为真 
-s filename 如果文件长度不为0，则为真 
-h filename 如果文件是软链接，则为真


1.判断文件夹是否存在
复制代码
#shell判断文件夹是否存在

#如果文件夹不存在，创建文件夹
if [ ! -d "/myfolder" ]; then
  mkdir /myfolder
fi
复制代码
 

2.判断文件夹是否存在并且是否具有可执行权限
复制代码
#shell判断文件,目录是否存在或者具有权限
folder="/var/www/"
file="/var/www/log"

# -x 参数判断 $folder 是否存在并且是否具有可执行权限
if [ ! -x "$folder"]; then
  mkdir "$folder"
fi
复制代码
 

3.判断文件夹是否存在
# -d 参数判断 $folder 是否存在
if [ ! -d "$folder"]; then
  mkdir "$folder"
fi
 

4.判断文件是否存在
# -f 参数判断 $file 是否存在
if [ ! -f "$file" ]; then
  touch "$file"
fi
 

5.判断一个变量是否有值
# -n 判断一个变量是否有值
if [ ! -n "$var" ]; then
  echo "$var is empty"
  exit 0
fi
 

6.判断两个变量是否相等.

# 判断两个变量是否相等
if [ "$var1" = "$var2" ]; then
  echo '$var1 eq $var2'
else
  echo '$var1 not eq $var2'
fi


basename, dirname
-----------------

str1="app/build/outputs/apk/debug/app-debug.apk"
echo ${str1%%/*}
echo "base: "$(basename $str1)
echo "dir: "$(dirname $str1)
# base: app-debug.apk
# dir: app/build/outputs/apk/debug


带空格的字符串变成数组
-------------------
str="/Users/captain/Desktop/t"
# str="$(echo $str | tr "[:upper:]" "[:lower:]")"
apkPath=$(find $str -name "*.txt")
echo $apkPath
pathlist=($apkPath)
for i in ${pathlist[*]}
do
    echo $i
done


发送get，post请求
---------------
https://www.jb51.cc/linux/694466.html

# curl: 会把请求的内容显示到控制台上
# get:
curl www.baidu.com
# post: -d加参数
curl -d "param1=value1&param2=value2" www.baidu.com
# -I
# 只显示头部信息。
# -i
# 显示全部信息。
# -v
# 显示解析全过程。
# 发送格式化json请求
curl -i -k  -H "Content-type: application/json" -X POST -d '{"version":"6.6.0", "from":"mu", "product_version":"1.1.1.0"}' https://10.10.10.10:80/test

# wget: 会把请求的内容下载本地
# get:
wget www.baidu.com
# get方式并指定下载的文件名
wget -O wordpress.zip http://www.linuxde.net/download.aspx?id=1080
# post:
wget --post-data="user=user1&pass=pass1&submit=Login" http://domain.com/path/p

