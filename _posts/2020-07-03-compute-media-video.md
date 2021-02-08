## 视频原理
source: `{{ page.path }}`

### 图像
三原色: RGB

屏幕显示原理: TV CRT; PC CRT; XO-1 LCD; LCD
屏幕由像素点排列组成, 像素由3个发光子像素点组成
#### 图像的数值表示
##### RGB表示方式

* 浮点表示: 0.0~1.0
* 整数表示: 0~255或者00~FF, RGBA\_8888 RGB\_565

RGBA\_8888 1280x720计算图像大小: 1280 \* 720 \* 4 = 3.516MB
位图(bitmap)在内存中所占用的大小

##### YUV表示方式
视频帧裸数据一般使用YUV表示

Y: Luma, 灰阶值
U, V: Chroma, 色度, 分为Cr(色调)和Cb(饱和度)

Cr: RGB输入信号红色部分与RGB信号亮度值之间的差异
Cb: RGB输入信号蓝色部分与RGB信号亮度值之间的差异

Y、U、V都使用8个字节来表示

在广播电视系统中不传输很低和很高的数值，实际 上是为了防止信号变动造成过载

Y的取值范围都是 16~235
UV的取值范围都是16~240

采样格式是4:2:0

##### 图像压缩
JPEG: 有损, 静态, 较好的重建质量


##### YUV与RGB间转换

标清电视使用标准BT.601
\left[ \begin{matrix} Y' \\ U \\ V \end{matrix} \right] = \left[ \begin{matrix} 0.299 & 0.587 & 0.114 \\ -0.14713 & -0.28886 & 0.436 \\ 0.615 \\ -0.51499 \\ -0.10001 \end{matrix} \right] \left[ \begin{matrix} R \\ G \\ B \end{matrix} \right]

\left[ \begin{matrix} R \\ G \\ B \end{matrix} \right] = \left[ \begin{matrix} 1 & 0 & 1.13983 \\ 1 & -0.39465 & -0.58060 \\ 1 & 2.03211 & 0 \end{matrix} \right] \left[ \begin{matrix} Y' \\ U \\ V \end{matrix} \right]

高清电视使用标准BT.709
\left[ \begin{matrix} Y' \\ U \\ V \end{matrix} \right] = \left[ \begin{matrix} 0.2126 & 0.7152 & 0.0722 \\ -0.09991 & -0.33609 & 0.436 \\ 0.615 & -0.55861 & -0.05639 \end{matrix} \right] \left[ \begin{matrix} R \\ G \\ B \end{matrix} \right]

\left[ \begin{matrix} R \\ G \\ B \end{matrix} \right] = \left[ \begin{matrix} 1 & 0 & 1.28033 \\ 1 & -0.21482 & -0.38059 \\ 1 & 2.12798 & 0 \end{matrix} \right] \left[ \begin{matrix} Y' \\ U \\ V \end{matrix} \right]


### 视频编码

去除时间上的冗余信息: 帧间编码技术

* 运动补偿: 运动补偿是通过先前的局部图像来预测、补偿当前的 局部图像，它是减少帧序列冗余信息的有效方法。
* 运动表示: 不同区域的图像需要使用不同的运动矢量来描述运动信息。
* 运动估计: 运动估计是从视频序列中抽取运动信息的一整套技术。

ISO MPEG: Mpeg1(VCD), Mpeg2(DVD), Mpeg4 AVC
ITU-T H.261, H.262, H.263, H.264
H.264创造了多参考帧、多块类型、整数变换、帧内预测等 新的压缩技术，使用了更精细的分像素运动矢量(1/4、1/8)和新一代的环路滤波器

### 编码概念

#### IPB帧

I帧: 帧内编码帧(intra picture)，I帧通常是每个GOP(MPEG所 使用的一种视频压缩技术)的第一个帧, 可以当成静态图像. 去掉视频的空间冗余信息
P帧: 前向预测编码帧(predictive-frame)，通过将图像序列中前 面已编码帧的时间冗余信息充分去除来压缩传输数据量的编码图像，也称为预测帧。去掉时间冗余信息
B帧: 双向预测内插编码帧(bi-directional interpolated prediction frame)，既考虑源图像序列前面的已编码帧，又顾及源图像序列后面 的已编码帧之间的时间冗余信息，来压缩传输数据量的编码图像，也称为双向预测帧. 去掉时间冗余信息

·I帧自身可以通过视频解压算法解压成一张单独的完整视频画面，所以I帧去掉的是视频帧在空间维度上的冗余信息。 
·P帧需要参考其前面的一个I帧或者P帧来解码成一张完整的视频画面。
·B帧则需要参考其前一个I帧或者P帧及其后面的一个P帧来生成一 张完整的视频画面，所以P帧与B帧去掉的是视频帧在时间维度上的冗余信息。

#### IDR帧与I帧的理解

IDR(instantaneous decoding refresh picture), 在H264中采用了多帧预测, 有多条I帧作为参考,
因此引入IDR, 是一个特殊的I帧, 作为唯一的参考.

#### PTS与DTS

DTS: Decoding Time Stamp, 用户视频解码
PTS: Presentation TIme Stamp, 用户解码阶段进行视频同步和输出

B帧会打乱解码和显示的顺序, 所以一旦存在B帧, PTS与DTS势必就会不同

FFmpeg中使用AVPacket描述解码前或解码后的压缩数据, 用AVFrame来描述解码后或解码前  
的原始数据. AVFrame什么时候显示, 取决于它的PTS. DTS是AVPacket的成员, 表示什么时  
候解码.

#### GOP的概念

GOP(Group Of Picture), 两个I帧之间形成的一组图片, 就是GOP

gop\_size, 代表的是两个I帧之间的帧数目.

I压缩率是7(与JPG差不多), P是20, B可以达到50

### Reference

