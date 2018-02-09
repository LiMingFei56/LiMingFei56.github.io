---
layout: page
permalink: /program-language/swift/features
---

features

### Operator Overloading
[Swift Operator Overloading](https://developer.apple.com/library/content/documentation/Swift/Conceptual/Swift_Programming_Language/AdvancedOperators.html#//apple_ref/doc/uid/TP40014097-CH27-ID28)

Swift 支持自定义操作符，前后缀操作符，重载现有操作符


    // 重缀操作符
    static func <Operator> (Parameter-List)

    // 前缀perfix 后缀postfix
    static prefix func - (vector: Vector2D) -> Vector2D
    {
        return Vector2D(x: -vector.x, y: -vector.y)
    }

    // 自定义操作符
    prefix operator +++

    static prefix func +++ (vector: inout Vector2D) -> Vector2D {
        vector += vector
        return vector
    }


