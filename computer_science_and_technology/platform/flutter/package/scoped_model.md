---
layout: page
permalink: ./technology-home/platform/flutter/package/scoped-model
---

## Scoped Model
管理应用状态

配置库：scoped_model: ^1.0.0

### 1. Model
声明状态，需要继承`Model`类。关键函数`notifyListeners()`，这个函数通知所有监听的Widget，状态改变需要重建。

    class CartModel extends Model {
        /// Internal, private state of the cart.
        final List<Item> _items = [];

        /// An unmodifiable view of the items in the cart.
        UnmodifiableListView<Item> get items => UnmodifiableListView(_items);

        /// The current total price of all items (assuming all items cost $1).
        int get totalPrice => _items.length;

        /// Adds [item] to cart. This is the only way to modify the cart from outside.
        void add(Item item) {
            _items.add(item);
            // This call tells [Model] that it should rebuild the widgets that
            // depend on it.
            notifyListeners();
            }
    }

### 2. ScopedModel
把`Model`共享给后代，需要判断`Model`的作用域，不能低了使有些Widget看不到，不能高了造成作用污染。需要使用
泛型指定共享的具体类：ScopedModel<CartModel>

    ScopedModel<SomeOtherModel>(
        model: myOtherModel,
        child: ScopedModel<CartModel>(
            model: cart,
            child: MyApp(),
        ),
    )
共享多个`Model`需要嵌套ScopedModel

### 3. ScopedModelDescendant
使用及监听`Model`的改变，使用ScopedModelDescendant。重要的参数为`buildre`，接收一个函数，当第一次
构建或者`Model`改变时调用。有三个参数:
1. context - 上下文
2. child - 子Widget只构建一次，不会随`Model`改变而重建
3. Model - 指定监听的Model

    return ScopedModelDescendant<CartModel>(
        builder: (context, child, cart) => Stack(
                children: [
                // Use SomeExpensiveWidget here, without rebuilding every time.
                child,
                Text("Total price: ${cart.totalPrice}"),
                ],
            ),
        // Build the expensive widget here.
        child: SomeExpensiveWidget(), // 重用Widget时使用
    );

需要使用泛型指定具体的类，不然不能工作：ScopedModelDescendant<CartModel>
ScopedModelDescendant需要尽可能的深入Widget树，不要重建多余的Widget

### 4. 非Widget访问Model
在非Widget的情况下访问Model
    ScopedModel.of<CartModel>(context).add(item);
    ScopedModelDescendant<CartModel>(builder: myBuilder, rebuildOnChange: false) // 不推荐，语法长了，而且使用的是构造函数