#!/bin/sh

# CocoaPods requires your terminal to be using UTF-8 encoding. Consider adding the following to ~/.profile:
export LANG=en_US.UTF-8

source ${HOME}/pg_tools/profile
source ${HOME}/.zshrc
cd ${WORKSPACE}

echo "项目路径："
pwd

git clean -df
git checkout .
git reset --hard
git fetch

branch=$(git branch | grep ${BRANCH})
if [ -n "$branch" ]; then
echo "当前分支已存在"
git checkout ${BRANCH}
else
echo "当前分支不存在，创建该分支"
git checkout -b ${BRANCH} remotes/origin/${BRANCH}
fi

git pull origin ${BRANCH}

# 由于编辑使用本地pod，需要临时拉取编辑依赖的库后续删除 编辑Begin
if [ -f "updateEditRepo.sh" ]; then
./updateEditRepo.sh
echo "QA打包机 podinstall"
sh $HOME/pg_tools/pods/ppi.sh
fi
# 编辑End

#pkg -clean ${CONFIG}

rm -rf output/*
pkg -env ${CERT}.cfg

echo "开始 打包 当前证书 ${CERT}"

basepath=$(pwd)
#basepath = ""
if [[ $basepath == *"Camera360"* ]]
then
if [[ ${CERT} == *"toolchain"* ]]
then
echo "使用 fastlane 打inhouse包"
fastlane archive env:inhouse conf:${CONFIG}
else
echo "使用 fastlane 打appstore包"
fastlane archive env:appstore conf:${CONFIG}
fi
else
echo "使用老的打包方式"
if [ ${CHANNEL_TYPE} == "batch" ]; then
echo "Using batch package mode"
pkg -bat ${CONFIG} DEBUG_INFORMATION_FORMAT="dwarf-with-dsym"
else
pkg -make ${CONFIG} DEBUG_INFORMATION_FORMAT="dwarf-with-dsym"
fi
fi


git checkout .

echo $(ls output/*.ipa | cut -d _ -f2)_$(ls output/*.ipa | cut -d _ -f3)_$(ls output/*.ipa | cut -d _ -f5)_$(ls output/*.ipa | cut -d _ -f8)_$(ls output/*.ipa | cut -d _ -f9)

cd output


ls *.dSYM
if [[ $? -eq 0 ]]; then
zip_name=`ls *.ipa | sed s/[[:space:]]/_/g`
zip -r ${zip_name}.dSYM.zip *.dSYM/
fi
