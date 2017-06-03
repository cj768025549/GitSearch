export LANG=en_US.UTF-8     #   执行pod install时用到
security unlock-keychain "-p" "12"   # MAC授权密码
appname="GitSearch"
codesignidentify="iPhone Distribution: beijing Tongchengtong Information Technology Co., Ltd"   # 需要指定证书
provisoningprofile="2bb39949-c853-4f78-a4c5-106928265908"

projectpath=$(pwd)
basepath=$HOME


cd $projectpath     #cd到工程目录下
#/usr/local/bin/pod install      # pod安装，要使用根路径

#clean
xcodebuild -workspace "$appname.xcworkspace" -scheme "$appname" -configuration "Release" clean >> /dev/null
#build
archivePath="$projectpath/$appname.xcarchive"
xcodebuild archive -workspace "$appname.xcworkspace" -scheme "$appname" -sdk iphoneos -configuration "Release" -archivePath $archivePath CODE_SIGN_IDENTITY="$codesignidentity" PROVISIONING_PROFILE="$provisoningprofile" >> /dev/null


#获取ipa文件存放的路径
packagepath="${HOME}/Desktop/ipa"
#获取版本号
bundleversion=$(/usr/libexec/PlistBuddy -c "print :CFBundleShortVersionString" "$projectpath/$appname/Info.plist")
ipanameprefix="$appname_test_$bundleversion"
ipapath="$packagepath/$ipanameprefix"


optionsPlist="$projectpath/export_info.plist"
xcodebuild -exportArchive -archivePath $archivePath -exportPath $ipapath -exportOptionsPlist $optionsPlist CODE_SIGN_IDENTITY="$codesignidentity" PROVISIONING_PROFILE="$provisoningprofile" >> /dev/null

