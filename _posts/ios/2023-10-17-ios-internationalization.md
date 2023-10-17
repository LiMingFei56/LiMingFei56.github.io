---
layout: post
title: iOS 国际化
categories: ios
tags: [ios]
date: 2023-10-17
---

## iOS 国际化

### App Name



Roll back those changes, add a InfoPlist.strings file to your project, localize it and then add the needed keys to it. For example:

"CFBundleDisplayName" = "App display name";
"CFBundleName" = "App bundle name";




To localized Info.plist :

    Find in the x-code the folder Resources (is placed in root)
    Select the folder Resources
    Then press the main menu File->New->File...
    Select in section "Resource" Strings File and press Next
    Then in Save As field write InfoPlist ONLY ("I" capital and "P" capital)
    Then press Create
    Then select the file InfoPlist.strings that created in Resources folder and press in the right menu the button "Localize"
    Then you Select the Project from the Project Navigator and select the The project from project list
    In the info tab at the bottom you can as many as language you want (There is in section Localizations)
    The language you can see in Resources Folder
    To localize the values ("key") from info.plist file you can open with a text editor and get all the keys you want to localize
    You write any key as the example in any InfoPlist.strings like the above example

"NSLocationAlwaysAndWhenInUseUsageDescription"="blabla";

"NSLocationAlwaysUsageDescription"="blabla2";

That's all work and you have localize your info.plist file!

## Reference
