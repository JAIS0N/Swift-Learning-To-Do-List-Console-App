# Swift Closures Explained From Scratch

Closures are one of the MOST important Swift concepts.

They are used everywhere:
- async programming
- networking
- sorting
- animations
- callbacks
- SwiftUI
- concurrency

Apple interviews ask closures very frequently.

---

# 1. What is a Closure?

A closure is:

> A block of code that can be stored and passed around like a value.

Simpler definition:

> A function without a name.

---

# 2. Normal Function First

Before closures, understand regular functions.

```swift
func greet(name: String) {
    print("Hello \(name)")
}
```

Call:

```swift
greet(name: "Jaison")
```

Output:

```swift
Hello Jaison
```

---

# 3. Closure Version

Same thing as closure:

```swift
let greet = { (name: String) in
    print("Hello \(name)")
}
```

Call:

```swift
greet("Jaison")
```

Output:

```swift
Hello Jaison
```

---

# 4. What Changed?

Instead of:

```swift
func greet(...)
```

We now:

- created anonymous function
- stored it in variable

---

# 5. Closure Syntax Breakdown

Example:

```swift
let add = { (a: Int, b: Int) -> Int in
    return a + b
}
```

Looks scary initially.

Let's break it.

---

# Part 1

```swift
let add =
```

Store closure in variable named `add`.

---

# Part 2

```swift
(a: Int, b: Int)
```

Parameters.

---

# Part 3

```swift
-> Int
```

Return type.

---

# Part 4

```swift
in
```

Separates:
- parameters
- body

---

# Part 5

```swift
return a + b
```

Closure body.

---

# 6. Calling Closure

```swift
let result = add(2, 3)

print(result)
```

Output:

```swift
5
```

---

# 7. Why Closures Exist

Closures are useful when:

You want to:
- pass behavior
- customize logic
- run code later

---

# Real Life Analogy

Imagine ordering pizza.

Restaurant asks:

> "How should we cut it?"

You provide instructions.

That instruction is like closure.

---

# 8. Closures as Parameters

VERY IMPORTANT.

Functions can accept closures.

---

# Example

```swift
func performOperation(operation: (Int, Int) -> Int) {

    let result = operation(5, 3)

    print(result)
}
```

Meaning:

This function accepts:
- another function/closure

---

# Passing Closure

```swift
performOperation(operation: { (a, b) in
    return a + b
})
```

Output:

```swift
8
```

---

# 9. Why This Is Powerful

Function behavior becomes customizable.

Same function can:
- add
- subtract
- multiply

depending on closure passed.

---

# Example

Addition:

```swift
performOperation(operation: { a, b in
    a + b
})
```

Multiplication:

```swift
performOperation(operation: { a, b in
    a * b
})
```

---

# 10. Trailing Closure Syntax

Swift simplifies closures heavily.

---

# Normal

```swift
performOperation(operation: { a, b in
    a + b
})
```

---

# Trailing Closure

```swift
performOperation { a, b in
    a + b
}
```

Cleaner.

Very common in Swift.

---

# 11. Simplified Closure Syntax

Swift removes unnecessary parts automatically.

---

# Full Version

```swift
numbers.sorted(by: { (a: Int, b: Int) -> Bool in
    return a < b
})
```

---

# Type Inference

Swift already knows types:

```swift
numbers.sorted(by: { a, b in
    return a < b
})
```

---

# Single Expression Return

```swift
numbers.sorted(by: { a, b in
    a < b
})
```

---

# Shorthand Arguments

```swift
numbers.sorted(by: {
    $0 < $1
})
```

---

# Final Shortest Form

```swift
numbers.sorted {
    $0 < $1
}
```

---

# 12. What are $0 and $1?

Swift shorthand parameter names.

| Symbol | Meaning |
|---|---|
| $0 | first parameter |
| $1 | second parameter |

---

# Example

```swift
let nums = [5,2,8,1]

let sortedNums = nums.sorted {
    $0 < $1
}
```

Internally:

```swift
a < b
```

---

# 13. map()

Closures heavily used with collections.

---

# Example

```swift
let nums = [1,2,3]

let squares = nums.map {
    $0 * $0
}
```

Output:

```swift
[1,4,9]
```

---

# What map Does

Transforms every item.

---

# Step-by-Step

Input:

```swift
[1,2,3]
```

Closure:

```swift
$0 * $0
```

Transformation:

```swift
1 -> 1
2 -> 4
3 -> 9
```

---

# 14. filter()

```swift
let even = nums.filter {
    $0 % 2 == 0
}
```

Output:

```swift
[2]
```

Keeps matching items.

---

# 15. reduce()

```swift
let sum = nums.reduce(0) {
    $0 + $1
}
```

Output:

```swift
6
```

---

# 16. Escaping Closures (IMPORTANT)

Interview favorite.

---

# Normal Closure

Runs immediately.

---

# Escaping Closure

Runs later.

Used in:
- networking
- async tasks
- delayed execution

---

# Example

```swift
func fetchData(completion: @escaping () -> Void) {

    DispatchQueue.main.async {
        completion()
    }
}
```

---

# Why "escaping"?

Because closure:
- escapes function scope
- executes after function ends

---

# Real Example

```swift
fetchData {
    print("Data received")
}
```

---

# 17. Callback Concept

Closures often act as callbacks.

Meaning:

> "Call this code later when task finishes."

---

# Networking Example

```swift
downloadFile {
    print("Download complete")
}
```

---

# 18. Capturing Values

Closures remember variables around them.

---

# Example

```swift
var count = 0

let increment = {
    count += 1
    print(count)
}
```

Call:

```swift
increment()
increment()
```

Output:

```swift
1
2
```

---

# Why?

Closure captures `count`.

It remembers surrounding environment.

---

# 19. Memory Leak Problem

Closures can accidentally keep objects alive.

Very important in Apple interviews.

---

# Example

```swift
class ViewController {

    var name = "Jaison"

    func setup() {

        someFunction {
            print(self.name)
        }
    }
}
```

Closure strongly captures `self`.

Can create:
- retain cycle
- memory leak

---

# Solution → weak self

```swift
someFunction { [weak self] in
    print(self?.name)
}
```

---

# Why weak?

Closure will NOT strongly own object.

Prevents memory leak.

---

# 20. Strong Reference Cycle

Example:

```swift
A owns closure
closure owns A
```

Neither destroyed.

Memory leak.

---

# 21. Common Interview Questions

---

# Q: What is a closure?

Answer:

> Self-contained block of functionality that can be stored and passed around.

---

# Q: Why closures useful?

- callbacks
- async programming
- functional programming
- customization

---

# Q: Difference between function and closure?

| Function | Closure |
|---|---|
| Named | Usually anonymous |
| Declared with func | Stored in variable |
| Permanent | Often temporary |

---

# Q: What is escaping closure?

Closure executed after function returns.

---

# Q: Why weak self used in closures?

To avoid retain cycles and memory leaks.

---

# 22. Most Common Real Usage

---

# Sorting

```swift
nums.sorted { $0 < $1 }
```

---

# Async APIs

```swift
fetchData {
    print("Done")
}
```

---

# Collection Operations

```swift
map
filter
reduce
```

---

# Animations

```swift
UIView.animate {
    view.alpha = 0
}
```

---

# Completion Handlers

```swift
saveData {
    print("Saved")
}
```

---

# 23. Mental Model

The BEST mental model:

Closure = portable piece of behavior.

You can:
- store it
- pass it
- execute later

Like passing instructions.

---

# 24. MOST IMPORTANT Closure Topics for Interviews

Priority order:

1. Basic closure syntax
2. Trailing closures
3. map/filter/reduce
4. Escaping closures
5. Capturing values
6. weak self
7. Completion handlers
8. Async callbacks

---

# 25. One-Line Summary

Closure = function you can pass around like data.
