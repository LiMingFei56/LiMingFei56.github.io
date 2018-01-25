---
layout: page
permalink: /program-language/python/grammar
---

Grammar

### Variable And Constant

    i = 12

### Control Flow
#### If Statement

    if_stmt ::=  "if" expression ":" suite
             ( "elif" expression ":" suite )*
             ["else" ":" suite]

#### For Statement
迭代Sequence

    for_stmt ::=  "for" target_list "in" expression_list ":" suite
              ["else" ":" suite]

#### While Statement

    while_stmt ::=  "while" expression ":" suite
                ["else" ":" suite]

#### Jumpe

    continue - 继续下一个迭代
    break    - 结束当前迭代
    pass     - 占位符，什么都不做，一般表示还没有实现

### Function And Lambda
#### Function

    def fib(n)
    // Argument Values
    def ask_ok(prompt, retries=4, reminder='Please try again!'):
    // Keyword Arguments
    def parrot(voltage, state='a stiff', action='voom', type='Norwegian Blue'):
    // Arbitrary Argument Lists
    def write_multiple_items(file, separator, *args):
    // Unpacking Argument Lists
    def parrot(voltage, state='a stiff', action='voom'):
    d = {"voltage": "four million", "state": "bleedin' demised", "action": "VOOM"}
    parrot(**d)

#### Lambda
Small anonymous functions

    lambda a, b: a+b

