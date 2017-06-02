## 工程名
#APP_NAME="GitSearch"
## 证书
#CODE_SIGN_DISTRIBUTION="iPhone Distribution: beijing Tongchengtong Information Technology Co., Ltd"
## info.plist路径
##project_infoplist_path="./${APP_NAME}/Info.plist"
##取版本号
##bundleShortVersion=$(/usr/libexec/PlistBuddy -c "print CFBundleShortVersionString" "${project_infoplist_path}")
##取build值
##bundleVersion=$(/usr/libexec/PlistBuddy -c "print CFBundleVersion" "${project_infoplist_path}")
#DATE="$(date +%Y%m%d%H%m%s)"
#FILENAME="${APP_NAME}_${DATE}"
#IPANAME="${APP_NAME}.ipa"
##要上传的ipa文件路径
#IPA_PATH="$HOME/${IPANAME}"
#echo ${IPA_PATH}
#echo "${IPA_PATH}">> text.txt
#
#//下面2行是集成有Cocopods的用法
#echo "=================clean================="
#xcodebuild -workspace "${APP_NAME}.xcworkspace" -scheme "${APP_NAME}"  -configuration 'Release' clean
#echo "+++++++++++++++++build+++++++++++++++++"
#xcodebuild -workspace "${APP_NAME}.xcworkspace" -scheme "${APP_NAME}" -sdk iphoneos -configuration 'Release' CODE_SIGN_IDENTITY="${CODE_SIGN_DISTRIBUTION}" SYMROOT='$(PWD)'
#echo "+++++++++++++++++archive+++++++++++++++++"
#xcodebuild -workspace ${APP_NAME}.xcworkspace -scheme "${APP_NAME}" -configuration Release -archivePath ./build/${FILENAME}/${FILENAME}.xcarchive archive
#echo "+++++++++++++++++导出IPA文件++++++++++++++++++"
#xcodebuild -exportArchive -archivePath ./build/${FILENAME}/${FILENAME}.xcarchive -exportPath ./build/${FILENAME}/${FILENAME}  -exportOptionsPlist ./export_info.plist
#echo "+++++++++++++++++上传ipa至fir++++++++++++++++++"
#
#echo "正在上传到fir.im...."
#fir p ./build/${FILENAME}/${APP_NAME}.ipa
#changelog=`cat $projectDir/README`
#curl -X PUT --data "changelog=$changelog" http://fir.im/api/v2/app/59313172548b7a16a9000264?token=863efefc2c22d4b761c096e6af9a6024
#echo "\n打包上传更新结束"
#fir无法使用时，上传至蒲公英

#fastlane gym --export_method enterprise --output_name ${APP_NAME}
#curl -F "file=./build/${FILENAME}/${APP_NAME}.ipa" -F "uKey=d81326899dd50c3382e2f5e99f3a7495" -F "_api_key=495642f9b1336a64ceb2d5cb44d93183" https://qiniu-storage.pgyer.com/apiv1/app/upload

#!/bin/bash

#计时
SECONDS=0

#假设脚本放置在与项目相同的路径下
project_path=$(pwd)
#取当前时间字符串添加到文件结尾
now=$(date +"%Y_%m_%d_%H_%M_%S")

#指定项目的scheme名称
scheme="GitSearch"
#指定要打包的配置名
configuration="enterprise"
#指定打包所使用的provisioning profile名称
provisioning_profile='IM_Distribution.mobileprovision'

#指定项目地址
workspace_path="$project_path/GitSearch.xcworkspace"
#指定输出路径
output_path="${HOME}/Desktop/GitSearch/"
#指定输出归档文件地址
archive_path="$output_path/GitSearch_${now}.xcarchive"
#指定输出ipa地址
ipa_path="$output_path/GitSearch_${now}.ipa"
#获取执行命令时的commit message
commit_msg="$1"

#输出设定的变量值
echo "===workspace path: ${workspace_path}==="
echo "===archive path: ${archive_path}==="
echo "===ipa path: ${ipa_path}==="
echo "===profile: ${provisioning_profile}==="
echo "===commit msg: $1==="

#先清空前一次build
xctool clean -workspace ${workspace_path} -scheme ${scheme} -configuration ${configuration}

#根据指定的项目、scheme、configuration与输出路径打包出archive文件
xctool build -workspace ${workspace_path} -scheme ${scheme} -configuration ${configuration} archive -archivePath ${archive_path}

#使用指定的provisioning profile导出ipa
#我暂时没找到xctool指定provisioning profile的方法，所以这里用了xcodebuild
xcodebuild -exportArchive -archivePath ${archive_path} -exportPath ${ipa_path} -exportFormat ipa -exportProvisioningProfile "${provisioning_profile}"

#上传到fir
fir publish ${ipa_path} -T fir_token -c "${commit_msg}"

#输出总用时
echo "===Finished. Total time: ${SECONDS}s==="
