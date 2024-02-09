---
layout: post
title: TypeScript
categories: lang
tags: [lang]
date: 2024-01-22
---

## TypeScript

> 随着JS项目规模越来越大, 维护和定位问题越来越因难

1. 动态类型, 不明确当前变量类型, 变量类型何时变化的
2. 不明确当前变量是否有对应属性

可以解决:
    1. typos
    2. uncalled functions
    3. basic logic errors
    4. Static type-checking

### tsc , the TypeScript compiler

    npm install -g typescript
    tsc --noEmitOnError hello.ts

### Type

> 类型标注
> JS版本降级

* string string[]
* number number[]
* boolean boolean[]
* T<U> 
* any

    let myName: string = "Alice";
    async function getFavoriteNumber(name: string): Promise<number> {
      return 26;
    }

    # Object Types
    function printName(obj: { first: string; last?: string }) {
       // Error - might crash if 'obj.last' wasn't provided!
       console.log(obj.last.toUpperCase());
      'obj.last' is possibly 'undefined'.

      if (obj.last !== undefined) {
        // OK
        console.log(obj.last.toUpperCase());
      }
     
        // A safe alternative using modern JavaScript syntax:
        console.log(obj.last?.toUpperCase());
    }

    # Union Types
    function printId(id: number | string) {
      console.log(id.toUpperCase());
      Property 'toUpperCase' does not exist on type 'string | number'.
      Property 'toUpperCase' does not exist on type 'number'.
    }

#### Type Aliases

    type ID = number | string;
    type UserInputSanitizedString = string;

#### Interface

    interface Point {
      x: number;
      y: number;
    }
     
    function printCoord(pt: Point) {
      console.log("The coordinate's x value is " + pt.x);
      console.log("The coordinate's y value is " + pt.y);
    }

> Type aliases and interfaces are very similar, and in many cases you can choose
> between them freely. Almost all features of an interface are available in type,
> the key distinction is that a type cannot be re-opened to add new properties
> vs an interface which is always extendable.

#### Type Assertions

    const myCanvas = document.getElementById("main_canvas") as HTMLCanvasElement;
    const myCanvas = <HTMLCanvasElement>document.getElementById("main_canvas");

#### Literal Types


#### Less Common Primitives

    // Creating a bigint via the BigInt function
    const oneHundred: bigint = BigInt(100);
     
    // Creating a BigInt via the literal syntax
    const anotherHundred: bigint = 100n;


    const firstName = Symbol("name");
    const secondName = Symbol("name");
     
    if (firstName === secondName) {
        This comparison appears to be unintentional because the types 'typeof firstName' and 'typeof secondName' have no overlap.

      // Can't ever happen
    }
    
#### Enum

    enum Direction {
      Up = 1,
      Down,
      Left,
      Right,
    }

### Narrowing

    function padLeft(padding: number | string, input: string) {
      if (typeof padding === "number") {
        return " ".repeat(padding) + input;
      }
      return padding + input;
    }

    "string"
    "number"
    "bigint"
    "boolean"
    "symbol"
    "undefined"
    "object"
    "function"

#### Truthiness narrowing

    function getUsersOnlineMessage(numUsersOnline: number) {
      if (numUsersOnline) {
        return `There are ${numUsersOnline} online now!`;
      }
      return "Nobody's here. :(";
    }


> all convert to false, other convert to true.    
    0
    NaN
    "" (the empty string)
    0n (the bigint version of zero)
    null
    undefined

    function printAll(strs: string | string[] | null) {
      if (strs && typeof strs === "object") {
        for (const s of strs) {
          console.log(s);
        }
      } else if (typeof strs === "string") {
        console.log(strs);
      }
    }

#### Equality narrowing

> TypeScript also uses switch statements and equality checks like ===, !==, ==, and != to narrow types. For example:

    function printAll(strs: string | string[] | null) {
      if (strs !== null) {
        if (typeof strs === "object") {
          for (const s of strs) {
                           
    (parameter) strs: string[]
            console.log(s);
          }
        } else if (typeof strs === "string") {
          console.log(strs);
                       
    (parameter) strs: string
        }
      }
    }


#### The in operator narrowing

    type Fish = { swim: () => void };
    type Bird = { fly: () => void };
     
    function move(animal: Fish | Bird) {
      if ("swim" in animal) {
        return animal.swim();
      }
     
      return animal.fly();
    }

#### instanceof narrowing

    function logValue(x: Date | string) {
      if (x instanceof Date) {
        console.log(x.toUTCString());
                   
    (parameter) x: Date
      } else {
        console.log(x.toUpperCase());
                   
    (parameter) x: string
      }
    }

#### Assignments

    let x = Math.random() < 0.5 ? 10 : "hello world!";
   
    let x: string | number
    x = 1;
     
    console.log(x);
               
    let x: number
    x = true;
    Type 'boolean' is not assignable to type 'string | number'.

     
    console.log(x);
               
    let x: string | number

#### Control flow analysis

    function example() {
      let x: string | number | boolean;
     
      x = Math.random() < 0.5;
     
      console.log(x);
                 
    let x: boolean
     
      if (Math.random() < 0.5) {
        x = "hello";
        console.log(x);
                   
    let x: string
      } else {
        x = 100;
        console.log(x);
                   
    let x: number
      }
     
      return x;
            
    let x: string | number
    }

#### Using type predicates

> We’ve worked with existing JavaScript constructs to handle narrowing so far, however sometimes you want more direct control over how types change throughout your code.

    function isFish(pet: Fish | Bird): pet is Fish {
      return (pet as Fish).swim !== undefined;
    }

#### [Assertion Functions](https://www.typescriptlang.org/docs/handbook/release-notes/typescript-3-7.html#assertion-functions)

    function multiply(x, y) {
      assert(typeof x === "number");
      assert(typeof y === "number");
      return x * y;
    }

#### Discriminated unions
#### The never type

    type Shape = Circle | Square;
 
    function getArea(shape: Shape) {
      switch (shape.kind) {
        case "circle":
          return Math.PI * shape.radius ** 2;
        case "square":
          return shape.sideLength ** 2;
        default:
          const _exhaustiveCheck: never = shape;
          return _exhaustiveCheck;
      }
    }

### Functions

#### Function Type Expressions

    function greeter(fn: (a: string) => void) {
      fn("Hello, World");
    }
     
    function printToConsole(s: string) {
      console.log(s);
    }
    greeter(printToConsole);

    type GreetFunction = (a: string) => void;
    function greeter(fn: GreetFunction) {
      // ...
    }

#### Call Signatures

    type DescribableFunction = {
      description: string;
      (someArg: number): boolean;
    };
    function doSomething(fn: DescribableFunction) {
      console.log(fn.description + " returned " + fn(6));
    }
     
    function myFunc(someArg: number) {
      return someArg > 3;
    }
    myFunc.description = "default description";
     
    doSomething(myFunc);

> Note that the syntax is slightly different compared to a function type expression - use : between the parameter list and the return type rather than =>.

#### Construct Signatures

    type SomeConstructor = {
      new (s: string): SomeObject;
    };
    function fn(ctor: SomeConstructor) {
      return new ctor("hello");
    }

    interface CallOrConstruct {
      (n?: number): string;
      new (s: string): Date;
    }

#### Generic Functions

    function firstElement<Type>(arr: Type[]): Type | undefined {
      return arr[0];
    }

    # Constraints
    function longest<Type extends { length: number }>(a: Type, b: Type) {
      if (a.length >= b.length) {
        return a;
      } else {
        return b;
      }
    }
     
    // longerArray is of type 'number[]'
    const longerArray = longest([1, 2], [1, 2, 3]);
    // longerString is of type 'alice' | 'bob'
    const longerString = longest("alice", "bob");
    // Error! Numbers don't have a 'length' property
    const notOK = longest(10, 100);

#### Optional Parameters

    function f(x?: number) {
      // ...
    }
    f(); // OK
    f(10); // OK

##### Function Overloads

    function makeDate(timestamp: number): Date;
    function makeDate(m: number, d: number, y: number): Date;
    function makeDate(mOrTimestamp: number, d?: number, y?: number): Date {
      if (d !== undefined && y !== undefined) {
        return new Date(y, mOrTimestamp, d);
      } else {
        return new Date(mOrTimestamp);
      }
    }
    const d1 = makeDate(12345678);
    const d2 = makeDate(5, 5, 5);
    const d3 = makeDate(1, 3);

#### Declaring `this` in a Function

#### Other Types to Know About

* void
* object 
* unknown
* never
* Function

#### Rest Parameters and Arguments

    // Rest Parameters
    function multiply(n: number, ...m: number[]) {
      return m.map((x) => n * x);
    }
    // 'a' gets value [10, 20, 30, 40]
    const a = multiply(10, 1, 2, 3, 4);

    // Rest Arguments
    const arr1 = [1, 2, 3];
    const arr2 = [4, 5, 6];
    arr1.push(...arr2);

#### Parameter Destructuring

    function sum({ a, b, c }) {
      console.log(a + b + c);
    }
    sum({ a: 10, b: 3, c: 9 });

#### Assignability of Functions

> Return type void

    type voidFunc = () => void;
 
    const f1: voidFunc = () => {
      return true;
    };
     
    const f2: voidFunc = () => true;
     
    const f3: voidFunc = function () {
      return true;
    };

### Object Types

    function greet(person: { name: string; age: number }) {
      return "Hello " + person.name;
    }

    interface Person {
      name: string;
      age: number;
    }
     
    function greet(person: Person) {
      return "Hello " + person.name;
    }

    type Person = {
      name: string;
      age: number;
    };
     
    function greet(person: Person) {
      return "Hello " + person.name;
    }

#### Property Modifiers

##### Optional Properties

    interface PaintOptions {
      shape: Shape;
      xPos?: number;
      yPos?: number;
    }

##### readonly Properties

    interface SomeType {
      readonly prop: string;
    }

##### Index Signatures

    interface StringArray {
      [index: number]: string;
    }
     
    const myArray: StringArray = getStringArray();
    const secondItem = myArray[1];

#### Excess Property Checks

    interface SquareConfig {
      color?: string;
      width?: number;
    }
     
    function createSquare(config: SquareConfig): { color: string; area: number } {
      return {
        color: config.color || "red",
        area: config.width ? config.width * config.width : 20,
      };
    }
     
    let mySquare = createSquare({ colour: "red", width: 100 });
    Argument of type '{ colour: string; width: number; }' is not assignable to parameter of type 'SquareConfig'.
    Object literal may only specify known properties, but 'colour' does not exist in type 'SquareConfig'. Did you mean to write 'color'?

#### Extending Types

    interface Colorful {
      color: string;
    }
     
    interface Circle {
      radius: number;
    }
     
    interface ColorfulCircle extends Colorful, Circle {}
     
    const cc: ColorfulCircle = {
      color: "red",
      radius: 42,
    };

#### Intersection Types

    interface Colorful {
      color: string;
    }
    interface Circle {
      radius: number;
    }
     
    type ColorfulCircle = Colorful & Circle;

#### Generic Object Types

    interface Box<Type> {
      contents: Type;
    }
    interface StringBox {
      contents: string;
    }
     
    let boxA: Box<string> = { contents: "hello" };
    boxA.contents;
            
    (property) Box<string>.contents: string
     
    let boxB: StringBox = { contents: "world" };
    boxB.contents;

#### The Array Type

    function doSomething(value: Array<string>) {
      // ...
    }
     
    let myArray: string[] = ["hello", "world"];
     
    // either of these work!
    doSomething(myArray);
    doSomething(new Array("hello", "world"));

#### The ReadonlyArray Type

    function doStuff(values: ReadonlyArray<string>) {
      // We can read from 'values'...
      const copy = values.slice();
      console.log(`The first value is ${values[0]}`);
     
      // ...but we can't mutate 'values'.
      values.push("hello!");
    Property 'push' does not exist on type 'readonly string[]'.

    }

#### Tuple Types

    type StringNumberPair = [string, number];

    readonly Tuple Types
    function doSomething(pair: readonly [string, number]) {
      pair[0] = "hello!";
    Cannot assign to '0' because it is a read-only property.

    }

### Creating Types from Types

#### [Generics](https://www.typescriptlang.org/docs/handbook/2/generics.html) 

#### Keyof Type Operator

    type Arrayish = { [n: number]: unknown };
    type A = keyof Arrayish;
        
    type A = number
     
    type Mapish = { [k: string]: boolean };
    type M = keyof Mapish;
        
    type M = string | number

#### Typeof Type Operator

    function f() {
      return { x: 10, y: 3 };
    }
    type P = ReturnType<typeof f>;
        
    type P = {
        x: number;
        y: number;
    }

#### Indexed Access Types

    type I1 = Person["age" | "name"];
     
    type I1 = string | number
     
    type I2 = Person[keyof Person];
         
    type I2 = string | number | boolean
     
    type AliveOrName = "alive" | "name";
    type I3 = Person[AliveOrName];
         
    type I3 = string | boolean

#### Conditional Types

    interface Animal {
      live(): void;
    }
    interface Dog extends Animal {
      woof(): void;
    }
     
    type Example1 = Dog extends Animal ? number : string;
            
    type Example1 = number
     
    type Example2 = RegExp extends Animal ? number : string;
            
    type Example2 = string

#### Mapped Types

    // Removes 'readonly' attributes from a type's properties
    type CreateMutable<Type> = {
      -readonly [Property in keyof Type]: Type[Property];
    };
     
    type LockedAccount = {
      readonly id: string;
      readonly name: string;
    };
     
    type UnlockedAccount = CreateMutable<LockedAccount>;
               
    type UnlockedAccount = {
        id: string;
        name: string;
    }

#### Template Literal Types

    type EmailLocaleIDs = "welcome_email" | "email_heading";
    type FooterLocaleIDs = "footer_title" | "footer_sendoff";
     
    type AllLocaleIDs = `${EmailLocaleIDs | FooterLocaleIDs}_id`;
              
    `type AllLocaleIDs = "welcome_email_id" | "email_heading_id" | "footer_title_id" | "footer_sendoff_id"`

### [Class](https://www.typescriptlang.org/docs/handbook/2/classes.html)

    

### [tsconfig.json](https://www.typescriptlang.org/docs/handbook/tsconfig-json.html)


## Reference
+ [TypeScript Handbook](https://www.typescriptlang.org/docs/handbook/intro.html)
