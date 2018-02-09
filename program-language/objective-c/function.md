---
layout: page
permalink: /program-language/objective-c/funcation
---

Funcation

### Function Type

#### Block

    // 声明block类型
    (void(^)(void))，无参数，无返回值
    double (^multiplyTwoValues)(double, double);

    // 实现
    ^ {} 无参数，无返回值

    ^ double (double firstValue, double secondValue) {
        return firstValue * secondValue;
    }

#### Selector

@selector(); 返回一个SEL对象
使用[self performSelector:selec];调用

函数的配置

    -(void)methodWithNoParameters;
    SEL noParameterSelector = @selector(methodWithNoParameters);
    
    -(void)methodWithOneParameter:(id)parameter;
    SEL oneParameterSelector = @selector(methodWithOneParameter:); // notice the colon here
    
    -(void)methodWIthTwoParameters:(id)parameterOne and:(id)parameterTwo;
    SEL twoParameterSelector = @selector(methodWithTwoParameters:and:); // notice the parameter names are omit

### 语言链接性 Language Linking
函数原型为：

    -/+ (返回类型) 方法名: (参数1类型) 形参1  参数2描述: (参数2类型) 形参2 参数3描述: (参数3类型) 形参3 .......

为了支持函数重载和重写，所以也要以参数列表生成独特的签名，但是函数的第一个参数的描术是使用函数名，所以
要实现函数重载最少要有2个参数。而且在objective-c中 函数重载跟方法名、参数个数，参数描术有关。跟参数类型无关。

### Funciton Override And Overland

    // Override
    @interface Parent : NSObject
    -(void) handleData: (Data1 *) data;
    @end
    @implementation Parent
    -(void) handleData:(Data1 *)data {
        [data foo];
    }
    @end
    
    @interface Child : Parent
    -(void) handleData: (Data2 *) data;
    @end
    @implementation Child
    -(void) handleData:(Data2 *)data {
        [data foo];
    }
    @end

    // Overland
    @interface Base: NSObject
    /* {} */ // It's optional.
    + (void) foo;
    + (void) foo: (int)param;
    + (void) foo: (int)param and: (int)param2;
    + (void) foo: (int)param and: (int)param2 and: (int)param3;
    - (void) bar;
    - (void) bar: (int)param;
    - (void) bar: (int)param and: (int)param2;
    - (void) bar: (int)param and: (int)param2 and: (int)param3;
    @end
