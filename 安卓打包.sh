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
echo "apk路径："
echo $str
cp -r $str/*.apk output