---
layout: page
permalink: ./technology-home/platform/flutter/package/convert
---

## Convert

### 1. Json

    // 解析成Map，数据类型丢失，容易出类型不正确和拼写错误
    Map<String, dynamic> user = jsonDecode(jsonString);

    // 使用fromJson来解决上面的问题
    class User {
        final String name;
        final String email;

        User(this.name, this.email);

        User.fromJson(Map<String, dynamic> json)
            : name = json['name'],
                email = json['email'];

        Map<String, dynamic> toJson() =>
            {
            'name': name,
            'email': email,
            };
    }

    // 序列化不用调用toJson(), jsonEncode()帮助调用
    String json = jsonEncode(user);