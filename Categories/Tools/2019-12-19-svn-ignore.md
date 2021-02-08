## Svn 设备忽略文件
source: `{{ page.path }}`

在项目根目录新建文件.svnignore,内容为要忽略的文件和文件夹

  ViconCommunity.xcworkspace/*
  ViconCommunity.xcworkspace
  Podfile.lock
  Pods/*
  Pods
  ViconCommunity.xcodeproj/project.xcworkspace/xcuserdata
  ViconCommunity.xcodeproj/project.xcworkspace/xcuserdata/*
  .DS_Store
  *.swp
  .git
  .git/*
  .gitignore
  README.en.md
  README.md

在终端执行添加忽略文件：

  svn propset svn:global-ignores -F .svnignore .

propset：svn属性设置
svn:global-ignores：svn全局忽略属性
-F：表示从 .svnignore 文件中读取匹配规则
. ：表示当前目录

执行命令，将忽略配置至服务器：

  svn commit -m "add svn:global-ignores"
