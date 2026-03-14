---
layout: post
title: "线性代数-矩阵"
categories: math
tags: [linear-algebra]
date: 2025-12-26
excerpt: "线性代数-矩阵"
---

矩阵重要概念与常用操作（工程视角）

面向 MongoDB / Pandas / 数据工程的矩阵速查表
核心思想：你每天写的都是矩阵变换，只是没这么叫

一、基础概念
1️⃣ 向量（Vector）

定义
向量是一组有序的数，用来表示一个对象的多个特征。

示例

x = [120, 3, 10]   # 面积, 房间数, 楼龄


工程对应

MongoDB：一条 document

Pandas：DataFrame 的一行

2️⃣ 矩阵（Matrix）

定义
矩阵是多个向量组成的二维结构。

示例

X = [
  [120, 3, 10],
  [ 90, 2,  5],
  [150, 4, 20]
]


工程对应

MongoDB collection

Pandas DataFrame

SQL 表

3️⃣ 维度（Shape）
X ∈ R^(n × m)
n = 行数（样本数）
m = 列数（特征数）


工程中大量 bug 来自 shape 理解错误

二、最常用的矩阵操作
4️⃣ 行选择（Row Selection / Mask）

数学视角

X[mask]


MongoDB

db.col.find({ price: { $gt: 150 } })


Pandas

df[df["price"] > 150]


含义：
👉 从矩阵中挑选满足条件的行（向量）

5️⃣ 列选择（Projection）

数学视角

X[:, ["price", "days"]]


MongoDB

db.col.find(
  { vendor: "a" },
  { price: 1, days: 1, _id: 0 }
)


Pandas

df[["price", "days"]]


含义：
👉 裁剪特征维度，减少矩阵宽度

6️⃣ 矩阵扩维（Add Column）

数学视角

R^(n×m) → R^(n×(m+1))


Pandas

df["score"] = df["price"] / df["days"]


含义：
👉 为每个向量增加一个新特征

7️⃣ 行级计算（Apply / For-loop）

数学视角

∀ xᵢ:
    yᵢ = f(xᵢ)


Pandas（慢）

df["flag"] = df.apply(
    lambda r: r["price"] > 100 and r["days"] < 20,
    axis=1
)


说明：

每一行单独计算

本质是 Python for-loop

数据量一大必慢

8️⃣ 向量化计算（推荐）

数学视角

布尔向量运算


Pandas（快）

df["flag"] = (df["price"] > 100) & (df["days"] < 20)


说明：

一次性对整列计算

底层是 C / NumPy

性能提升 10～100 倍

三、矩阵变换（真正的“计算”）
9️⃣ 矩阵乘法（Matrix Multiplication）

数学定义

Y = X · W


示例：房价预测

X = [
  [120, 3, 10],
  [ 90, 2,  5]
]

W = [1000, 5000, -800]

price = X · W


含义：

X：房屋特征矩阵

W：权重向量

输出：预测价格

🔟 聚合 / 降维（Aggregation）

数学视角

R^(n×m) → R^(k×m)


MongoDB

{
  $group: {
    _id: "$vendor",
    avg_price: { $avg: "$price" }
  }
}


Pandas

df.groupby("vendor")["price"].mean()


含义：

多行 → 少行

汇总信息

降低数据规模

1️⃣1️⃣ 矩阵 Join（横向拼接）

数学视角

Z = X ⨝ Y


MongoDB

$lookup


Pandas

df1.merge(df2, on="dhash", how="left")


说明：

行数可能增加

列数一定增加

是最贵的矩阵操作之一

四、MongoDB + Pandas 的完整矩阵流程
实际代码
docs = db.col.find(
    {"days": {"$gt": 30}},
    {"price": 1, "days": 1, "vendor": 1}
)

df = pd.DataFrame(docs)
df["score"] = df["price"] / df["days"]
result = df.groupby("vendor")["score"].mean()

矩阵视角
X₀  原始矩阵
 ↓  行筛选
X₁
 ↓  列裁剪
X₂
 ↓  扩维
X₃
 ↓  降维
X₄

五、工程版矩阵三定律（非常重要）

能在 MongoDB 裁剪的，不要带到 Pandas

能向量化的，不要 apply

能早降维的，不要晚 group


🔹 例子 1：线性回归（预测房价）
1️⃣ 数据（向量）

房子特征向量：

x = [面积, 房间数, 楼龄]

2️⃣ 权重（矩阵 / 向量）
w = [单价系数, 房间系数, 折旧系数]

3️⃣ 预测公式（矩阵运算）
价格 = w · x


👉 实际系统里：

所有房子的特征 = 矩阵 X

权重 = 向量 w

预测结果 = X · w

📌 机器学习、风控、推荐系统天天在用

🔹 例子 2：图像处理（非常直观）
图片本质是什么？

一张灰度图像：

矩阵 = [
  [  0,  30,  80],
  [120, 200, 255],
  [ 60, 100, 180]
]


每个数 = 像素亮度

整张图片 = 矩阵

模糊 / 锐化怎么做？

用一个小矩阵（卷积核）去“扫”图像：

模糊核 = [
  [1, 1, 1],
  [1, 1, 1],
  [1, 1, 1]
]


👉 手机相机 / 美颜 / PS 全靠矩阵

🔹 例子 3：推荐系统（你刷到的内容）
用户向量
u = [喜欢体育, 喜欢科技, 喜欢音乐]

内容矩阵
I = [
  [1, 0, 0],   # 体育新闻
  [0, 1, 0],   # 科技新闻
  [0, 0, 1]    # 音乐视频
]

推荐计算
得分 = I · u


👉 抖音 / B站 / Netflix 核心就是矩阵

🔹 例子 4：坐标变换（游戏 / 3D / 地图）
一个点（向量）
p = [x, y]

旋转矩阵
R = [
  [cosθ, -sinθ],
  [sinθ,  cosθ]
]

旋转结果
p' = R · p


👉 游戏引擎 / CAD / 自动驾驶

🔹 例子 5：数据库 & 批量计算（你熟悉的场景）

你在 Python / MongoDB / Pandas 里常做的事：

一堆数据

同样的规则

批量计算

这在数学上就是：

结果 = 矩阵 × 向量
