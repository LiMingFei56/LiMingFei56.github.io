---
layout: page
permalink: ./AndroidStudio指定编译出包的名字
---

AndroidStudio指定编译出包的名字.md

### APK
如果使用的插件是`apply plugin: 'com.android.application'`

#### 3.0 前
    android.applicationVariants.all { variant ->
        variant.outputs.each { output ->
            def outputFile = output.outputFile
            //这里修改apk文件名
            def fileName = outputFile.name.replace("app",
						"EmsPayPlugDhjt${defaultConfig.versionName}")
            output.outputFile = new File(outputFile.parent, fileName)
        }
    }

#### 3.0 后
	android.applicationVariants.all { variant ->
		variant.outputs.all {
			outputFileName = "${variant.name}-${variant.versionName}.apk"
		}
	}

### AAR
如果使用的插件是`apply plugin: 'com.android.library'`

#### 3.0 前
    android.libraryVariants.all { variant ->
        variant.outputs.each { output ->
            def outputFile = output.outputFile
            //这里修改apk文件名
            def fileName = outputFile.name.replace("app", "EmsPayPlugBasic_${defaultConfig.versionName}")
            output.outputFile = new File(outputFile.parent, fileName)
        }
    }

#### 3.0 后
	android.libraryVariants.all { variant ->
        variant.outputs.all {
            outputFileName =
				"TeamSunAppBasic-${variant.name}-${defaultConfig.versionName}.aar"
			}
	}
