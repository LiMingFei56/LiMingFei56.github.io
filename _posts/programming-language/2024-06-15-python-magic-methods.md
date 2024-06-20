---
layout: post
title: Python Magic methods
categories: python
tags: [python]
date: 2024-06-15
---

## Python Magic methods

Initialization and Representation

    __init__(self, ...): Object constructor, initializes the object.
    __del__(self): Object destructor, called when the object is about to be destroyed.
    __repr__(self): Defines the "official" string representation of an object, used by repr() and in debugging.
    __str__(self): Defines the "informal" string representation of an object, used by str() and print().

Attribute Access

    __getattr__(self, name): Called when an attribute is accessed that doesn't exist in the instance's __dict__.
    __getattribute__(self, name): Called unconditionally when an attribute is accessed.
    __setattr__(self, name, value): Called when an attribute assignment is attempted.
    __delattr__(self, name): Called when an attribute deletion is attempted.
    __dir__(self): Called by dir() to provide a list of attributes of an object.

Item Access and Management

    __getitem__(self, key): Called to retrieve an item using square bracket notation.
    __setitem__(self, key, value): Called to set an item using square bracket notation.
    __delitem__(self, key): Called to delete an item using square bracket notation.
    __contains__(self, item): Called to check membership using in and not in.

Iteration and Length

    __iter__(self): Returns an iterator object, used in for loops.
    __next__(self): Returns the next item from the iterator.
    __len__(self): Returns the length of the container.
    __reversed__(self): Returns an iterator for the reversed sequence.

Arithmetic Operations

    __add__(self, other): Implements addition (+).
    __sub__(self, other): Implements subtraction (-).
    __mul__(self, other): Implements multiplication (*).
    __matmul__(self, other): Implements matrix multiplication (@).
    __truediv__(self, other): Implements true division (/).
    __floordiv__(self, other): Implements floor division (//).
    __mod__(self, other): Implements modulo (%).
    __divmod__(self, other): Implements divmod().
    __pow__(self, other[, modulo]): Implements exponentiation (**).
    __lshift__(self, other): Implements left bitwise shift (<<).
    __rshift__(self, other): Implements right bitwise shift (>>).
    __and__(self, other): Implements bitwise AND (&).
    __xor__(self, other): Implements bitwise XOR (^).
    __or__(self, other): Implements bitwise OR (|).

Reverse Arithmetic Operations

These methods are called when the left operand does not support the corresponding operation and the operands are of different types.

    __radd__(self, other), __rsub__(self, other), __rmul__(self, other), etc.

In-Place Arithmetic Operations

    __iadd__(self, other): Implements in-place addition (+=).
    __isub__(self, other): Implements in-place subtraction (-=).
    __imul__(self, other): Implements in-place multiplication (*=).
    __imatmul__(self, other): Implements in-place matrix multiplication (@=).
    __itruediv__(self, other): Implements in-place true division (/=).
    __ifloordiv__(self, other): Implements in-place floor division (//=).
    __imod__(self, other): Implements in-place modulo (%=).
    __ipow__(self, other[, modulo]): Implements in-place exponentiation (**=).
    __ilshift__(self, other): Implements in-place left bitwise shift (<<=).
    __irshift__(self, other): Implements in-place right bitwise shift (>>=).
    __iand__(self, other): Implements in-place bitwise AND (&=).
    __ixor__(self, other): Implements in-place bitwise XOR (^=).
    __ior__(self, other): Implements in-place bitwise OR (|=).

Unary Operations

    __neg__(self): Implements unary negation (-self).
    __pos__(self): Implements unary positive (+self).
    __abs__(self): Implements abs().
    __invert__(self): Implements bitwise inversion (~self).

Comparison Operators

    __lt__(self, other): Implements less than (<).
    __le__(self, other): Implements less than or equal to (<=).
    __eq__(self, other): Implements equality (==).
    __ne__(self, other): Implements inequality (!=).
    __gt__(self, other): Implements greater than (>).
    __ge__(self, other): Implements greater than or equal to (>=).

Type Conversion

    __int__(self): Implements int().
    __float__(self): Implements float().
    __complex__(self): Implements complex().
    __bool__(self): Implements bool().
    __index__(self): Implements type conversion to an integer for slicing.
    __round__(self, n): Implements round().

Context Management

    __enter__(self): Defines what the object should do at the beginning of a with statement.
    __exit__(self, exc_type, exc_value, traceback): Defines what the object should do at the end of a with statement.

Callable Objects

    __call__(self, ...): Makes an instance callable like a function.

Copy and Deepcopy

    __copy__(self): Implements shallow copy of the object.
    __deepcopy__(self, memo): Implements deep copy of the object.

Additional Methods

    __format__(self, format_spec): Implements format specification.
    __hash__(self): Implements hashing, used in sets and dictionaries.
    __sizeof__(self): Returns the size of the object in memory.

## Reference
