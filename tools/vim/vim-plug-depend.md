---
# You don't need to edit this file, it's empty on purpose.
# Edit theme's home layout instead if you wanna make some changes
# See: https://jekyllrb.com/docs/themes/#overriding-theme-defaults
layout: page
permalink: /tools/vim/vim-plug-depend
---

VIM Plug Depend

### 插件依赖环境
#### vim-instant-markdown

* 需要安装node.js,npm ![Install npm](https://docs.npmjs.com/getting-started/installing-node)
* [sudo] npm -g install instant-markdown-d
	- xdg-utils
	- curl
	- nodejs-legacy (for Debian-based systems)
* If you're on Windows, you will need into install cURL and put it on your %PATH%.
* Copy the after/ftplugin/markdown/instant-markdown.vim file from this repo into your ~/.vim/after/ftplugin/markdown/ (creating directories as necessary), or follow your vim package manager's instructions.
* Ensure you have the line filetype plugin on in your .vimrc
* Open a markdown file in vim and enjoy!

#### TagBar

安装ctags
- Linux: sudo apt-get install ctags
- MacOS: brew install cmake

#### Ag
[见](https://github.com/ggreer/the_silver_searcher)
