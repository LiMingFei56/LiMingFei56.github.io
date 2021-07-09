---
layout: post
title: "FLutter 配置"
categories: flutter
tags: [flutter]
date: 2021-04-30
---

## FLutter 配置

### IPHONEOS_DEPLOYMENT_TARGET

1. Set MinimumOSVersion to 9.0 in ios/Flutter/AppFrameworkInfo.plist
2. Ensure that you uncomment platform :ios, '9.0' in ios/Podfile
3. Ensure that ios/Podfile contains the following post install script:

	  post_install do |installer|
      installer.pods_project.targets.each do |target|
        flutter_additional_ios_build_settings(target)
        target.build_configurations.each do |config|
          config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '9.0'
        end
      end
    end

	 flutter clean \
		&& rm ios/Podfile.lock pubspec.lock \
		&& rm -rf ios/Pods ios/Runner.xcworkspace \
		&& flutter build ios --build-name=1.0.0 --build-number=1 --release --dart-define=MY_APP_ENV=prod

### does not contain bitcode. 

	You must rebuild it with bitcode enabled (Xcode setting ENABLE_BITCODE), obtain an updated library from the vendor, or disable bitcode for this target. for architecture arm64 
	
	Build Settings => Build Options => Enable Bitcode set Yes or No

	  post_install do |installer|
      installer.pods_project.targets.each do |target|
        flutter_additional_ios_build_settings(target)
        target.build_configurations.each do |config|
          config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '9.0'
					config.build_settings['ENABLE_BITCODE'] = 'NO'
        end
      end
    end


### Reference
[IPHONEOS_DEPLOYMENT_TARGET](https://stackoverflow.com/questions/63973136/the-ios-deployment-target-iphoneos-deployment-target-is-set-to-8-0-in-flutter)   
