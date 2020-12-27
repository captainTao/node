#!/bin/bash

# android打包

#!/bin/zsh -il

cd ${WORKSPACE}
echo "项目路径："
pwd

rm -rf app/build/outputs
rm -rf output
mkdir output

./gradlew clean "assemble${env}${type}" --info
str=app/build/outputs/apk/${env}/${type}
str="$(echo $str | tr "[:upper:]" "[:lower:]")"
apkPath=$(find $str -name "*.apk")
if [[ $apkPath ]]; then
    echo "apk路径："$apkPath"\n"
    cp -r $str/*.apk output
fi



#第二版：

#!/bin/zsh -il

cd ${WORKSPACE}
echo "项目路径："
pwd

rm -rf app/build/outputs
rm -rf output
mkdir output

./gradlew clean "assemble${env}${type}" --info
str=app/build/outputs/apk/${env}/${type}
str="$(echo $str | tr "[:upper:]" "[:lower:]")"
apkPath=$(find $str -name "*.apk")
if [[ -e $apkPath ]]; then
    echo "apk路径: "$apkPath
    file_name=$(echo ${apkPath%.apk*}"_"$branch$(date "+_%Y-%m-%d_%H-%M-%S")".apk")
    echo "重命名路径: "$file_name
    mv $apkPath $file_name
    cp -r $str/*.apk output
fi