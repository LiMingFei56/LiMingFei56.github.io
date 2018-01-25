---
layout: page
permalink: /program-language/swift/grammar
---

Grammar

### Variable And Constant

支持类型推导，可以根据初始化值类型来导推出类型，所以可以省略类型定义

    //变量
    var i: Int

    //常量
    let i: Int

### Control Flow
#### If Statement

    if temperatureInFahrenheit <= 32 {
        print("It's very cold. Consider wearing a scarf.")
    } else if temperatureInFahrenheit >= 86 {
        print("It's really warm. Don't forget to wear sunscreen.")
    } else {
        print("It's not that cold. Wear a t-shirt.")
    }

#### Switch Statement

* 不会显示的穿透(Fallthough)
* 条件可以有多个，使用','分隔
* 可以使用Interval Matching
* 可以使用元组
* 可以使用let，值绑定
* 可以使用where，做额外的比较


    // normal
    switch some value to consider {
        case value 1:
            respond to value 1
        case value 2,
             value 3:
            respond to value 2 or 3
        default:
            otherwise, do something else
        }

    // Interval Matching
    let approximateCount = 62
    let countedThings = "moons orbiting Saturn"
    let naturalCount: String
    switch approximateCount {
    case 0:
        naturalCount = "no"
    case 1..<5:
        naturalCount = "a few"
    case 5..<12:
        naturalCount = "several"
    case 12..<100:
        naturalCount = "dozens of"
    case 100..<1000:
        naturalCount = "hundreds of"
    default:
        naturalCount = "many"
    }
    print("There are \(naturalCount) \(countedThings).")

    // Tuple
    let somePoint = (1, 1)
    switch somePoint {
    case (0, 0):
        print("\(somePoint) is at the origin")
    case (_, 0):
        print("\(somePoint) is on the x-axis")
    case (0, _):
        print("\(somePoint) is on the y-axis")
    case (-2...2, -2...2):
        print("\(somePoint) is inside the box")
    default:
        print("\(somePoint) is outside of the box")
    }

    // Where
    let yetAnotherPoint = (1, -1)
    switch yetAnotherPoint {
    case let (x, y) where x == y:
        print("(\(x), \(y)) is on the line x == y")
    case let (x, y) where x == -y:
        print("(\(x), \(y)) is on the line x == -y")
    case let (x, y):
        print("(\(x), \(y)) is just some arbitrary point")
    }


#### For Statement
Like C# foreach, 循环迭代Iterator，数组，Range, String, Dictionary

    let names = ["Anna", "Alex", "Brian", "Jack"]
    for name in names {
        print("Hello, \(name)!")
    }

#### While Statement

    while condition {
        statements
    }

#### Repeat-While Statement

    repeat {
        statements
    } while condition

#### Guard Statement
提前退出，判断一个条件是否成立，如果不成立就会执行else语句，该语句中最后只能return, break, continue, or throw

    guard let name = person["name"] else {
        return
    }

#### Jumpe

    continue - 跳过当前循环，进入下一步
    break - loop(结束最近的loop);switch(结束当前分支)
    Fallthrough - 开启Switch穿透

Labeled Statement

    label name: while condition {
        statements
    }

    break label name

### Function And Lambda
#### Function

    func greet(person: String, alreadyGreeted: Bool = false) -> String {
        if alreadyGreeted {
            return greetAgain(person: person)
        } else {
            return greet(person: person)
        }
    }
    print(greet(person: "Tim", alreadyGreeted: true))

    // 多个返回对象
    func minMax(array: [Int]) -> (min: Int, max: Int)?

    // 声明argument labels
    func someFunction(argumentLabel parameterName: Int)

    // 嵌套函数
    func chooseStepFunction(backward: Bool) -> (Int) -> Int {
        func stepForward(input: Int) -> Int { return input + 1 }
        func stepBackward(input: Int) -> Int { return input - 1 }
        return backward ? stepBackward : stepForward
    }

#### Function type

    func addTwoInts(_ a: Int, _ b: Int) -> Int {
        return a + b
    }

    (Int, Int) -> Int

#### Lambda

    { (parameters) -> return type in
        statements
    }

    { (s1: String, s2: String) -> Bool in
        return s1 > s2
    }

Operator Methods

Trailing Closures

    func someFunctionThatTakesAClosure(closure: () -> Void) {
        // function body goes here
    }

    someFunctionThatTakesAClosure(closure: {
        // closure's body goes here
    })

Escaping Closures

    @escaping

Autoclosures

    @autoclosure

