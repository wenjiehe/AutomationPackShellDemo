#!/bin/bash

#  AutomationPackShell.sh
#  AutomationPackDemo
#
#  Created by 贺文杰 on 2019/8/22.
#  Copyright © 2019 贺文杰. All rights reserved.

# 查看xcode编译的命令，打开终端，输入 man xcodebuild
# 输入 xcodebuild -list，获取scheme和configuration

echo $1
cd "/Users/hewenjie/Documents/gitDemo/AutomationPackDemo"
echo $(pwd)
echo "`ls $1`"

# 列出Xcode所有可用的SDKs
# xcodebuild -showsdks
# 查看当前工程build Setting的配置参数
# xcodebuild -showBuildSettings
# 查看工程的Targets和Configurations,Schemes
# xcodebuild -list

# 获取描述文件的UUID,https://www.jianshu.com/p/7ff2e7a5265a

projectName="AutomationPackDemo"
configuration_mode="Debug"
# configuration_mode="Release"
# projectXcodeproj="AutomationPackDemo.xcodeproj"
projectXcodeproj="AutomationPackDemo.xcworkspace"
# currentDate=$(date "+%Y-%m-%d %H-%M-%S")
ipaName="${projectName}.ipa"

# ceshi和dabao是文件夹，用于放置ipa和xcarchive
archPath="/Users/hewenjie/Desktop/dabao/${projectName}.xcarchive"
ipaPath="/Users/hewenjie/Desktop/ceshi/"
plistPath="$(pwd)/DevelopmentExportOptions.plist"

# 区分工程是project还是xcworkspace

# 1.clean
# xcodebuild -project ${projectXcodeproj} -scheme ${projectName} -configuration ${configuration_mode} clean
xcodebuild -workspace ${projectXcodeproj} -scheme ${projectName} -configuration ${configuration_mode} clean
# 2.build
# xcodebuild -project ${projectName}/${projectXcodeproj} -scheme ${projectName} -configuration ${configuration_mode}  build
# 3.archive
# xcodebuild -project "${projectXcodeproj}" -scheme "${projectName}" -configuration "${configuration_mode}" \
# -archivePath "${archPath}" archive
xcodebuild -workspace "${projectXcodeproj}" -scheme "${projectName}" -configuration "${configuration_mode}" \
-archivePath "${archPath}" archive
 # 4.打包ipa
if [[ -e $archPath ]]; then
xcodebuild -exportArchive -archivePath "${archPath}" -exportPath "${ipaPath}" -exportOptionsPlist "${plistPath}"
fi

 # 上传蒲公英，替换你自己的user key和api key
uKey="ebb353fb03c08d9f48ffba935327577e" # User Key,在应用->API->API信息中获取
apiKey="8b8abfa589db25dfa082c2fe42d8ad75" # API Key
installType="1" # 1：公开，2：密码安装，3：邀请安装。默认为1公开
password="" # 设置App安装密码，如果不想设置密码，请传空字符串，或不传
description="更新版本-随机测试" # 版本更新描述，请传空字符串，或不传。
if [[ -e ${ipaPath}${ipaName} ]]; then
	 echo "ipa文件存在"
#     curl -F "file=@${ipaPath}${ipaName}" \
#     -F "uKey=$uKey" \
#     -F "_api_key=$apiKey" \
#     -F "installType=$installType" \
#     -F "password=$password" \
#     -F "updateDescription=$description" \
#     https://www.pgyer.com/apiv1/app/upload
fi

