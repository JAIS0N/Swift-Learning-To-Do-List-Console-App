# Struct vs Class in Swift (Deep Beginner Explanation)

This is one of the MOST important Swift interview topics.

Apple asks this very often.

Understanding this properly helps with:
- memory management
- concurrency
- performance
- architecture
- thread safety

---

# 1. Simple Definition

| Struct | Class |
|---|---|
| Value Type | Reference Type |

This is the CORE difference.

Everything else comes from this.

---

# 2. What is a Value Type?

Value type means:

> A COPY is created when assigned or passed around.

---

# Example

```swift
struct User {
    var name: String
}
```

Create object:

```swift
var user1 = User(name: "Jaison")
```

Copy:

```swift
var user2 = user1
```

Modify second:

```swift
user2.name = "Apple"
```

Print both:

```swift
print(user1.name)
print(user2.name)
```

Output:

```swift
Jaison
Apple
```

---

# Why?

Because:

```swift
user2 = COPY of user1
```

Two independent values.

---

# Real Life Analogy

Struct is like:
- photocopy of document

Editing photocopy:
- does NOT change original.

---

# 3. What is a Reference Type?

Reference type means:

> Variables point to SAME object in memory.

---

# Example

```swift
class User {

    var name: String

    init(name: String) {
        self.name = name
    }
}
```

Create object:

```swift
var user1 = User(name: "Jaison")
```

Assign:

```swift
var user2 = user1
```

Modify:

```swift
user2.name = "Apple"
```

Print:

```swift
print(user1.name)
print(user2.name)
```

Output:

```swift
Apple
Apple
```

---

# Why?

Because:

```swift
user1
```

and

```swift
user2
```

both point to SAME object.

No copy created.

---

# Real Life Analogy

Class is like:
- shared Google Doc

Everyone edits same document.

---

# 4. Memory Diagram

---

# Struct

```text
user1 → [Jaison]
user2 → [Apple]
```

Separate copies.

---

# Class

```text
user1 ─┐
       ├──→ [Apple]
user2 ─┘
```

Same object shared.

---

# 5. Why Swift Prefers Structs

Swift is designed around:
- safety
- predictability
- performance

Structs help with all three.

---

# Benefits of Structs

---

# Safer

No accidental shared state.

---

# Better for Concurrency

Copies reduce race conditions.

---

# Faster

Usually stack allocated.

Less ARC overhead.

---

# Easier to Reason About

Changes stay local.

---

# 6. Why Classes Still Exist

Sometimes shared state is needed.

Examples:
- UI objects
- managers
- databases
- networking services

---

# 7. Inheritance

BIG difference.

---

# Structs DO NOT support inheritance

This is invalid:

```swift
struct Animal {

}

struct Dog: Animal {

}
```

---

# Classes DO support inheritance

```swift
class Animal {

    func sound() {
        print("Animal")
    }
}

class Dog: Animal {

    override func sound() {
        print("Bark")
    }
}
```

---

# Why Apple Prefers Protocols Over Inheritance

Deep inheritance becomes:
- hard to maintain
- tightly coupled

Apple prefers:
- composition
- protocols
- structs

---

# 8. Mutability

---

# Struct

If struct instance declared with `let`:

```swift
let user = User(name: "Jaison")
```

Cannot modify ANY property.

Even if property is `var`.

---

# Example

```swift
struct User {
    var name: String
}

let user = User(name: "Jaison")

user.name = "Apple"
```

ERROR.

---

# Why?

Entire struct immutable.

---

# Class

Different behavior.

```swift
class User {
    var name = ""
}

let user = User()

user.name = "Apple"
```

VALID.

---

# Why?

`let` only makes reference constant.

Object itself still mutable.

---

# Very Important Interview Point

---

# Struct

```text
let means fully immutable
```

---

# Class

```text
let means reference immutable
object may still change
```

---

# 9. Identity vs Equality

Classes have identity.

Structs usually do not.

---

# Example

```swift
user1 === user2
```

Checks:
- same object in memory

ONLY works for classes.

---

# Example

```swift
class User {

}
```

```swift
let u1 = User()
let u2 = u1

print(u1 === u2)
```

Output:

```swift
true
```

---

# Structs

Cannot use `===`.

Because:
- separate values
- not object identity

---

# 10. Memory Management

Classes use:
- ARC (Automatic Reference Counting)

Structs usually do not.

---

# Why Important?

Classes can create:
- retain cycles
- memory leaks

Structs cannot.

---

# Example Problem

```swift
class A {
    var b: B?
}

class B {
    var a: A?
}
```

Memory leak possible.

---

# Structs Avoid This Entirely

Because:
- copied values
- not shared references

---

# 11. Thread Safety

VERY important for Apple AI/system roles.

---

# Structs

Generally safer in concurrency.

Why?
- independent copies

---

# Classes

Shared mutable state.

Danger:
- race conditions

---

# Example Problem

Two threads modifying same class object.

Could cause:
- corruption
- crashes

---

# Actor Solution

Modern Swift uses:
- actors

to safely manage shared class-like state.

---

# 12. Performance

General rule:

---

# Structs

Usually:
- stack allocated
- faster
- lightweight

---

# Classes

Usually:
- heap allocated
- ARC overhead
- slower

---

# BUT IMPORTANT

Large structs copied repeatedly:
- can become expensive

Swift uses:
- copy-on-write optimizations

for collections.

---

# 13. Copy-on-Write (COW)

Important advanced concept.

---

# Example

```swift
var arr1 = [1,2,3]
var arr2 = arr1
```

Initially:
- same storage shared

Only when modified:
- actual copy happens

Efficient optimization.

---

# 14. When to Use Struct

Apple guideline:

> Use struct by default.

---

# Good Struct Use Cases

- models
- configurations
- data containers
- immutable objects
- API responses

---

# Example

```swift
struct Message {
    let text: String
}
```

Perfect struct candidate.

---

# 15. When to Use Class

Use class when you need:

- shared mutable state
- inheritance
- identity
- lifecycle management

---

# Good Class Use Cases

- view controllers
- managers
- networking services
- caches
- coordinators

---

# Example

```swift
class APIClient {

}
```

Good class candidate.

---

# 16. Apple Interview Favorite Questions

---

# Q: Main difference between struct and class?

Answer:

Structs are value types.
Classes are reference types.

---

# Q: Why does Swift prefer structs?

- safer
- better concurrency
- predictable behavior
- fewer memory issues
- improved performance

---

# Q: Can structs inherit?

No.

---

# Q: Which supports ARC?

Classes.

---

# Q: Which can cause retain cycles?

Classes.

---

# Q: Why are structs concurrency-friendly?

Because copies avoid shared mutable state.

---

# 17. MOST IMPORTANT Mental Model

---

# Struct

```text
Independent copy
```

---

# Class

```text
Shared object
```

If you deeply understand this:
- most interview questions become easy.

---

# 18. Very Common Apple Architecture Pattern

Apple often uses:

```text
Structs for data
Classes for services/managers
Protocols for abstraction
Actors for concurrency safety
```

---

# Example

```swift
struct Message {

}
```

```swift
protocol LLMProvider {

}
```

```swift
class OpenAIClient {

}
```

```swift
actor ConversationStore {

}
```

This is VERY modern Apple-style Swift architecture.

---

# 19. Final Interview Summary

---

# Struct

Use for:
- data
- safety
- immutability
- concurrency-friendly design

---

# Class

Use for:
- shared state
- identity
- lifecycle management
- inheritance

---

# Apple's Philosophy

```text
Prefer structs unless you specifically need classes.
```
