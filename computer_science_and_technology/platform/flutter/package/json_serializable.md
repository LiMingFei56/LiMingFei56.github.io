---
layout: page
permalink: ./technology-home/platform/flutter/package/json-serializable
---

## json_serializable
[dart:convert](./convert)中介绍为了使用json，需要创建一个model，这个model需要实现fromJson和toJson两个方法。
如果model更多更复杂就容易出错，乏味。那么可以选择使用fromJson、toJson自动生成库

### 1. 配置库

    dependencies:
    # Your other regular dependencies here
    json_annotation: ^2.0.0

    dev_dependencies: // 开发模式下依赖
    # Your other dev_dependencies here
    build_runner: ^1.0.0
    json_serializable: ^2.0.0

### 2. 创建model


    import 'package:json_annotation/json_annotation.dart';

    /// This allows the `User` class to access private members in
    /// the generated file. The value for this is *.g.dart, where
    /// the star denotes the source file name.
    part 'user.g.dart';

    /// An annotation for the code generator to know that this class needs the
    /// JSON serialization logic to be generated.
    @JsonSerializable()

    class User {
    User(this.name, this.email);

    String name;
    String email;

    /// A necessary factory constructor for creating a new User instance
    /// from a map. Pass the map to the generated `_$UserFromJson()` constructor.
    /// The constructor is named after the source class, in this case User.
    factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

    /// `toJson` is the convention for a class to declare support for serialization
    /// to JSON. The implementation simply calls the private, generated
    /// helper method `_$UserToJson`.
    Map<String, dynamic> toJson() => _$UserToJson(this);

### 3. 生成代码
* 生成一次： flutter packages pub run build_runner build
* 观察者：flutter packages pub run build_runner 
  
### 4. 使用
同[dart:convert](./convert)

    Map userMap = jsonDecode(jsonString);
    var user = User.fromJson(userMap);

    String json = jsonEncode(user);