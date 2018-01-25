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
