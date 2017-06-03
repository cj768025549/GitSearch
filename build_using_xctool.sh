# 工程名
APP_NAME="GitSearch"
# 证书
CODE_SIGN_DISTRIBUTION="iPhone Distribution: beijing Tongchengtong Information Technology Co., Ltd"
provisoningprofile="IM_Distribution"

# info.plist路径
project_infoplist_path="./${APP_NAME}/Info.plist"
#取版本号
bundleShortVersion=$(/usr/libexec/PlistBuddy -c "print CFBundleShortVersionString" "${project_infoplist_path}")
#取build值
bundleVersion=$(/usr/libexec/PlistBuddy -c "print CFBundleVersion" "${project_infoplist_path}")
DATE="$(date +%Y%m%d%H%m%s)"
FILENAME="${APP_NAME}_${DATE}"
#IPANAME="${APP_NAME}.ipa"
#要上传的ipa文件路径
#IPA_PATH="$HOME/Desktop/${IPANAME}"
#echo ${IPA_PATH}
#echo "${IPA_PATH}">> text.txt

echo "=================pod install================="
pod install

//下面2行是集成有Cocopods的用法
echo "=================clean================="
xcodebuild -workspace ${APP_NAME}.xcworkspace -scheme ${APP_NAME}  -configuration 'Release' clean


echo "+++++++++++++++++build+++++++++++++++++"
xcodebuild archive -workspace ${APP_NAME}.xcworkspace -scheme ${APP_NAME} -configuration 'Release' -archivePath ./build/${FILENAME}/${APP_NAME}.xcarchive CODE_SIGN_IDENTITY="iPhone Distribution: beijing Tongchengtong Information Technology Co., Ltd" PROVISIONING_PROFILE="IM_Distribution"
echo "+++++++++++++++++archive+++++++++++++++++"
#xcodebuild archive -workspace ${APP_NAME}.xcworkspace -scheme ${APP_NAME} -configuration 'Release' -archivePath ./build/${FILENAME}/${APP_NAME}.xcarchive CODE_SIGN_IDENTITY="$CODE_SIGN_DISTRIBUTION" PROVISIONING_PROFILE="$provisoningprofile"
echo "+++++++++++++++++导出IPA文件++++++++++++++++++"
xcodebuild -exportArchive -archivePath ./build/${FILENAME}/${APP_NAME}.xcarchive -exportPath ./build/${FILENAME}/${APP_NAME}.ipa  -exportOptionsPlist ./export_info.plist CODE_SIGN_IDENTITY="iPhone Distribution: beijing Tongchengtong Information Technology Co., Ltd" PROVISIONING_PROFILE="IM_Distribution"
echo "+++++++++++++++++上传ipa至fir++++++++++++++++++"

echo "正在上传到fir.im...."
fir p ./build/${FILENAME}/${APP_NAME}.ipa
changelog=`cat $projectDir/README`
curl -X PUT --data "changelog=$changelog" http://fir.im/api/v2/app/59313172548b7a16a9000264?token=863efefc2c22d4b761c096e6af9a6024
echo "\n打包上传更新结束"
#fir无法使用时，上传至蒲公英

#fastlane gym --export_method enterprise --output_name ${APP_NAME}
#curl -F "file=./build/${FILENAME}/${APP_NAME}.ipa" -F "uKey=d81326899dd50c3382e2f5e99f3a7495" -F "_api_key=495642f9b1336a64ceb2d5cb44d93183" https://qiniu-storage.pgyer.com/apiv1/app/upload
