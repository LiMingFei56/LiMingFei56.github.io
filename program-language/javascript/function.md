---
layout: page
permalink: /program-language/javascript/funcation
---

Funcation

### Function override And overland
js中不支持接口和抽象类/方法，一般可以按照@徐敏忠的方法来实现，把接口和抽象类中需要实现的方法都抛出异常，如果没有被实现就会报错。

js中不支持函数重载，想重载的话可以按照@Chris给的方法，根据arguments来判断参数个数和类型，然后再函数体中分情况执行不同的代码。
