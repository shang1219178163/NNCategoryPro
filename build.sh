#!/bin/bash

export LANG="zh_CN.GB2312"

function currentDate(){
    echo `date "+"%Y:%m:%d %H:%M"`
}

gitFuntion(){
    git add .
    git commit -m "update"
    git tag -a $1 -m "update"
    git push --tags
    pod trunk push $2 --allow-warnings --use-libraries
}

# echo "####################################################################"
# echo "####################################################################"
# echo "####################################################################"
# echo "##################----------####//##############//##################"
# echo "#################//#######//#####//##############//#################"
# echo "################//#######//#####//####//########//##################"
# echo "###############//#######//#####//###//#//######//###################"
# echo "##############//--------#####//##//###//####//######################"
# echo "#############//##############//#//######//##//######################"
# echo "############//###############/////#######////#######################"
# echo "###########//#######################################################"
# echo "####################################################################"
# echo "####################################################################"
# echo "####################################################################"
# echo "####################################################################"

#------------------------------------------------------------------------
#配置项目名称和路径等相关参数
#------------------------------------------------------------------------
# projectName="IntelligentOfParking" #项目所在目录的名称
#projectTarget="IntelligentOfParking"
#buildConfig="Test" #编译的方式,默认为Release,Debug,Test等
#codeSignIdentity="iPhone Distribution: Xi'an iRain IOT Technology Service CO., Ltd. (UB99NJ7K8G)"
#provisioningProfile="cdff2b5d-d1a3-49fb-af8f-275d3afdee3e"

#------------------------------------------------------------------------
#初始化参数
#------------------------------------------------------------------------
#projectDir=`pwd`
#buildDir=${projectDir}/build

# find -name BNCategory.podspec

path=$1
files=$(ls $path)
for filename in $files
do
#   echo $filename >> filename.txt
#   echo "filename——${filename}"
  result=$(echo ${filename} | grep ".podspec")
  if [[ "$result" != "" ]]
  then
    echo "包含___${filename}"
    # var=$(cat ${filename})
    # echo "文件内容___${var}"

    version=$(grep -E 's\.version.+=' ${filename} | grep -E '[0-9][0-9.]+' -o)
    echo "version__${version}"

    # git add .
    # git commit -m "update"
    # git tag -a ${version} -m "update"
    # git push --tags
    # pod trunk push ${filename} --allow-warnings --use-libraries

    gitFuntion version, filename;

  else
    echo "不包含_${filename}"
  fi 

done

filepath=$(cd "$(dirname "$0")"; pwd)
echo ${filepath}

# basepath=$(cd `dirname $0`; pwd)
# echo $basepath


