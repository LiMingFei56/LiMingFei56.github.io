# 1. 行间移动
K
50%
H M L
CTRL-g
CTRL-L

zz zt zb

ZZ保存退出

# 2. 查找
f t F T ; ,

.*[]^%/\?~$<>

? \ * # n N

/\<the\>
/^the$
/c.m

# 3. 使用标记
''
CTRL-] CTRL-O CTRL-I CTRL-T
:jumps

ma 'a
:marks
’ 跳转前的光标位置
" 最后编辑的光标位置
[ 最后修改的开始位置 
] 最后修改的结束位置
. 上次修改的光标位置

修改或离开文件前有效, 只有当前文件里有效

大写字母是全局的

# 4. 修改
x 表示 dl (删除当前光标下的字符) X 表示 dh (删除光标左边的字符)
D 表示 d$ (删除到行尾)
C 表示 c$ (修改到行尾)
s 表示 cl (修改一个字符) S 表示 cc (修改一整行)

`注: 3dw d3w 删除一个单词3次 删除三个单词1次  3d2w 删除3次2个单词`

# 5. 文本对象


# 6. 编辑多个文件
:edit
:write
:args
:next
:wnext
:previous
:last
:first
:args five.c six.c seven.h
:args *.txt
:saveas move.c 
:file move.c

:split
:vsplit
:split two.c
:3split alpha.c
CTRL-W +
4 CTRL-W +
CTRL-W -
{height}CTRL-W _
CTRL-W CTRL-W
:new
:close
:only
:qall
:wall
:wqall
:qall!

:vertical new

编辑另一个文件命令前面加s, 可以打开一个窗口
普通模式跳转另一个文件前面加CTRL-W, 可以打开一个窗口

CTRL-W h CTRL-W j CTRL-W k CTRL-W l
CTRL-W t CTRL-W b
跳转到左边的窗口 跳转到下面的窗口 跳转到上面的窗口 跳转到右边的窗口
跳转到最顶上的窗口 跳转到最底下的窗口

CTRL-W H CTRL-W J CTRL-W L
把当前窗口移到最左边 把当前窗口移到最下边 把当前窗口移到最右边

CTRL-W K

CTRL-^

:splitbelow 
:splitright

:leftabove {cmd} :aboveleft {cmd} :rightbelow {cmd} :belowright {cmd} :topleft {cmd} :botright {cmd}
当前窗口的左上方 同上 当前窗口的右下方 同上
整个 Vim 窗口的最上面或者最左边 整个 Vim 窗口的最下面或者最右边

:tabedit thatfile
:tab split
:gt
:

在任何打开窗口的 Ex 命令前面，你都可以放上 ":tab"

# 7. 折叠
zo zx zO zX
]c diff 跳转到修改
[c 
:diffupdate
:dp
:do?

# 8. 宏
q{register}
@{register}
3@a
@@

大写寄存器  可以对小写寄存器进行追加操作

可以把宏命令从寄存器中复制出来修改

# 9. 替换
:[range]substitute/from/to/[flags]
:%substitute/Professor/Teacher/

:.,$s/yes/no/
% = 1,$
:?^Chapter?,/^Chapter/s=grey=gray=g
:.+3,$-5
:’t,’b
:’<,’>
:’>,$
5: = :.,.+4
:[range]global/{pattern}/{command}

:0read patch
:.,$write tempo
:.,$write! tempo
:.write collection
:.write >>collection

gqap 排版当前段落
gggqG
gU
gu
guu
gUU
g~~

!{motion}{program}

:read !ls
:write !wc

:%s/\([^,]*\), \(.*\)/\2 \1/
:.,/^$/-1!sort
:g/^/m 0
:’t+1,.g/^/m ’t

# 10. 缓冲区
:buffers
:buffer 2
:bnext
:bprevious
:bfirst
:blast
:bdelete 


