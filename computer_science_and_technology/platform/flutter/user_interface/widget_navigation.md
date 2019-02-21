---
layout: page
permalink: ./technology-home/platform/flutter/user-interface/widget-navigation
---

## Navigation
* routes - 屏幕和页面，也就是Activity和UIViewController
* navigator - 管理routes的栈，主要功能push和pop

### 1. 基本使用

    1. Create two routes
    2. Navigator.push(
        context,
            MaterialPageRoute(builder: (context) => SecondRoute()),
       );
    3. Navigator.pop(context);

### 2. 命名routes
如果在多个routes中导航到同一个routes中，就导致代码重复，这时就要用命名routes。
`Navigator.pushNamed`

    1. Create two screens
    2. Define the routes
        MaterialApp(
            // Start the app with the "/" named route. In our case, the app will start
            // on the FirstScreen Widget
            initialRoute: '/',
            routes: {
                // When we navigate to the "/" route, build the FirstScreen Widget
                '/': (context) => FirstScreen(),
                // When we navigate to the "/second" route, build the SecondScreen Widget
                '/second': (context) => SecondScreen(),
            },
        );
    3. Navigator.pushNamed(context, '/second');
   
### 3. 传递数据
    // 返回数据
    1. Navigator.pop(context, 'Yep!');
    2. final result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => SelectionScreen()),
        );

传递数据到新routes，使用构造函数。
