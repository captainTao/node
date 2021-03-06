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


# 第三版：


#!/bin/zsh -il

# shellcheck disable=SC2164
cd "${WORKSPACE}"
echo "项目路径："
pwd

rm -rf app/build/outputs


# shellcheck disable=SC2154
if [ "${env}" == "none" ]; then
  ./gradlew clean "assemble${type}" --info
else
  ./gradlew clean "assemble${env}${type}" --info
fi

str="app/build/outputs/apk"
str="$(echo "$str" | tr "[:upper:]" "[:lower:]")"
path=$(find "$str" -name "*.apk")
# shellcheck disable=SC2206
apkPathList=($path)
# shellcheck disable=SC2034
for apkPath in ${apkPathList[*]}
do
  if [[ -e $apkPath ]]; then
    echo "apk路径: ""$apkPath"
    # shellcheck disable=SC2116
    # shellcheck disable=SC2154
    # shellcheck disable=SC2046
    # shellcheck disable=SC2027
    file_name=$(echo "${apkPath%.apk*}""_""$branch"$(date "+_%Y-%m-%d_%H-%M-%S")".apk")
    echo "重命名路径: ""$file_name"
    mv "$apkPath" "$file_name"
    cp -r "$file_name" output
  fi
done

