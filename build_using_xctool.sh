export LANG=en_US.UTF-8     #   执行pod install时用到
security unlock-keychain "-p" "12"   # MAC授权密码
appname="GitSearch"
codesignidentify="iPhone Distribution: beijing Tongchengtong Information Technology Co., Ltd"   # 需要指定证书
provisoningprofile="4c419047-9224-4cf7-a328-0248e3e93d8d"

projectpath=$(pwd)
basepath=$HOME


#git更新并删除老的ipa文件
packagepath="$basepath/app-package/production"
cd $packagepath
git pull
git rm *.ipa || true    # ‘|| true’保证继续执行下一步


cd $projectpath     #cd到工程目录下
/usr/local/bin/pod install      # pod安装，要使用根路径

#clean
xcodebuild -workspace "$appname.xcworkspace" -scheme "$appname" -configuration "Release" clean >> /dev/null
#build
archivePath="$projectpath/$appname.xcarchive"
xcodebuild archive -workspace "$appname.xcworkspace" -scheme "$appname" -sdk iphoneos -configuration "Release_Test" -archivePath $archivePath CODE_SIGN_IDENTITY="$codesignidentity" PROVISIONING_PROFILE="$provisoningprofile" >> /dev/null


#获取ipa文件存放的路径
packagepath="$basepath/hidate-app-package/test"
#获取版本号
bundleversion=$(/usr/libexec/PlistBuddy -c "print :CFBundleShortVersionString" "$projectpath/$appname/Info.plist")
ipanameprefix="$appname_test_$bundleversion"
ipapath="$packagepath/$ipanameprefix"


optionsPlist="$projectpath/EnterpriseExportOptions.plist"
xcodebuild -exportArchive -archivePath $archivePath -exportPath $ipapath -exportOptionsPlist $optionsPlist CODE_SIGN_IDENTITY="$codesignidentity" PROVISIONING_PROFILE="$provisoningprofile" >> /dev/null


cd $packagepath
git pull<span style="white-space:pre">              </span># git更新
rm -rf *.ipa || true<span style="white-space:pre">  </span># 删除旧的ipa文件
mv $ipapath/$appname.ipa $ipanameprefix.ipa<span style="white-space:pre">   </span># 按命名格式将文件重命名
rm -rf $ipapath<span style="white-space:pre">           </span># 删除空目录
