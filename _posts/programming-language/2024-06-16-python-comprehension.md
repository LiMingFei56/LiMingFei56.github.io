---
layout: post
title: Comprehension
categories: python
tags: [python]
date: 2024-06-16
---

## Comprehension

### List Comprehension:

    # Basic list comprehension
    new_list = [expression for item in iterable if condition]

    # Example:
    numbers = [1, 2, 3, 4, 5]
    squared = [x**2 for x in numbers if x % 2 == 0]  # squares of even numbers

### Set Comprehension:

    # Basic set comprehension
    new_set = {expression for item in iterable if condition}

    # Example:
    numbers = [1, 2, 3, 4, 5, 4, 3, 2, 1]  # Duplicate numbers
    unique_numbers = {x for x in numbers}  # Set of unique numbers

### Dictionary Comprehension:

    # Basic dictionary comprehension
    new_dict = {key_expression: value_expression for item in iterable if condition}

    # Example:
    numbers = [1, 2, 3, 4, 5]
    squared_dict = {x: x**2 for x in numbers}  # Square of each number as key-value pairs

### Generator Expression:

    # Basic generator expression
    gen = (expression for item in iterable if condition)

    # Example:
    numbers = [1, 2, 3, 4, 5]
    even_squared = (x**2 for x in numbers if x % 2 == 0)  # Generator for squares of even numbers

### Nested Comprehensions:

Comprehensions can be nested within each other.

    # Nested list comprehension
    nested_list = [[i * j for j in range(3)] for i in range(3)]

    # Nested dictionary comprehension
    nested_dict = {i: {j: i * j for j in range(3)} for i in range(3)}

### Conditional Ternary Expression (Not exactly a comprehension, but often used in conjunction):

    # Basic ternary expression
    x = 'Even' if num % 2 == 0 else 'Odd'

## Reference
