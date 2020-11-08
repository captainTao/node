#重命名,输入参数表示服务端需要的文件名
echo "$@"

buildVariant=$1
outPath=$2

#清理老的打包文件
if [ -e "$outPath" ]; then
  rm "$outPath"
fi

#执行打包脚本
rm -rf app/build
funcName="assemble${buildVariant}"
./gradlew clean "$funcName" --info

#获取apk路径
apkPath=$(find app/build/outputs/apk -name "*.apk")

if [ ! -e "$outPath" ]; then
  #取得输出路径的文件夹
  outFolder=$(dirname "$outPath")
  #创建文件夹
  mkdir -p "$outFolder"
  mv "$apkPath" "$outPath"
fi
