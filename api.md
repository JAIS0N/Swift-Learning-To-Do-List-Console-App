# Swift for APIs + LLM Agents (Apple AI Role Focus)

This guide explains the MOST important Swift concepts related to:
- API calls
- LLM apps
- AI agents
- async systems
- evaluation tooling
- infrastructure

This is the practical Swift knowledge relevant for the Apple JD.

---

# 1. Big Picture

When building LLM agents in Swift, your app usually does:

```text
User Input
    ↓
Send API Request
    ↓
LLM Processes
    ↓
Receive JSON Response
    ↓
Parse Response
    ↓
Update UI / Tool / Agent State
```

So the MOST important Swift concepts become:

| Concept | Why Important |
|---|---|
| async/await | API calls are asynchronous |
| closures | callbacks/completion handlers |
| Codable | JSON parsing |
| URLSession | networking |
| error handling | APIs fail often |
| actors | thread-safe shared state |
| protocols | modular architecture |
| generics | reusable infrastructure |
| ARC | memory management |
| Task | async execution |
| Result type | success/failure handling |

---

# 2. URLSession (Core Networking)

Swift uses:
- `URLSession`

for API calls.

---

# Basic API Call

```swift
let url = URL(string: "https://api.example.com")!

URLSession.shared.dataTask(with: url) { data, response, error in

    if let error = error {
        print(error)
        return
    }

    print(data)

}.resume()
```

---

# Understanding Step-by-Step

---

# Step 1

```swift
let url = URL(...)
```

Create endpoint URL.

---

# Step 2

```swift
URLSession.shared.dataTask
```

Starts asynchronous API request.

---

# Step 3

```swift
{ data, response, error in
```

Closure runs AFTER request finishes.

This is callback/completion handler.

---

# Why Closure Needed?

Because API calls take time.

Without closure:
- app freezes while waiting

Closure says:

> "Run this code later when response arrives."

---

# 3. Completion Handlers

Old Swift networking style.

---

# Example

```swift
func fetchLLM(prompt: String,
              completion: @escaping (String) -> Void) {

    completion("LLM response")
}
```

---

# Meaning

Function accepts closure:

```swift
(String) -> Void
```

Meaning:
- receives String
- returns nothing

---

# Using It

```swift
fetchLLM(prompt: "Hello") { response in
    print(response)
}
```

---

# Flow

```text
Call function
    ↓
API request starts
    ↓
Function exits immediately
    ↓
Response arrives later
    ↓
Closure executes
```

---

# 4. Why async/await Replaced Closures

Nested closures become ugly.

Called:
- callback hell

---

# Example

```swift
fetchUser {
    fetchPosts {
        fetchComments {

        }
    }
}
```

Messy.

---

# Modern Swift

```swift
let user = await fetchUser()
let posts = await fetchPosts()
let comments = await fetchComments()
```

Cleaner.

---

# 5. async/await (VERY IMPORTANT)

Modern Apple-preferred concurrency model.

---

# Async Function

```swift
func fetchData() async -> String {
    return "Hello"
}
```

Meaning:
- function may pause
- does asynchronous work

---

# await

```swift
let result = await fetchData()
```

Meaning:
- wait for async task

without blocking thread.

---

# Real Life Analogy

Ordering food.

Without async:
- stand doing nothing

With async:
- continue other work
- notified later

---

# 6. Real OpenAI API Call Example

---

# Request Model

```swift
struct ChatRequest: Codable {
    let model: String
    let messages: [Message]
}
```

---

# Message Model

```swift
struct Message: Codable {
    let role: String
    let content: String
}
```

---

# API Call

```swift
func callOpenAI() async throws {

    let url = URL(string: "https://api.openai.com/v1/chat/completions")!

    var request = URLRequest(url: url)

    request.httpMethod = "POST"

    request.addValue("application/json",
                     forHTTPHeaderField: "Content-Type")

    request.addValue("Bearer API_KEY",
                     forHTTPHeaderField: "Authorization")

    let body = ChatRequest(
        model: "gpt-4o",
        messages: [
            Message(role: "user",
                    content: "Hello")
        ]
    )

    request.httpBody = try JSONEncoder().encode(body)

    let (data, response) =
        try await URLSession.shared.data(for: request)

    print(String(data: data, encoding: .utf8))
}
```

---

# MOST IMPORTANT Concepts Here

| Concept | Usage |
|---|---|
| Codable | JSON encoding |
| async/await | async API call |
| URLSession | networking |
| throws | error handling |
| URLRequest | HTTP request |
| JSONEncoder | request serialization |

---

# 7. Codable (SUPER IMPORTANT)

Used for JSON parsing.

---

# Why Needed?

API sends JSON:

```json
{
  "name": "Jaison"
}
```

Swift needs conversion into objects.

---

# Example

```swift
struct User: Codable {
    let name: String
}
```

---

# Decode JSON

```swift
let user = try JSONDecoder().decode(User.self, from: data)
```

---

# Encode JSON

```swift
let jsonData = try JSONEncoder().encode(user)
```

---

# 8. Error Handling

APIs fail constantly.

Reasons:
- network issue
- invalid key
- timeout
- server crash

Swift uses:
- `throws`
- `do-catch`

---

# Example

```swift
do {

    let data = try await fetch()

} catch {

    print(error)
}
```

---

# Interview Point

Apple cares heavily about:
- reliability
- graceful failure handling

---

# 9. Result Type

Common in APIs.

---

# Example

```swift
Result<String, Error>
```

Means:
- success with String
OR
- failure with Error

---

# Usage

```swift
func fetch() -> Result<String, Error> {
}
```

---

# 10. Actors (VERY IMPORTANT FOR AI SYSTEMS)

Actors solve:
- race conditions
- shared state issues

---

# Problem

Multiple API calls updating same memory.

---

# Bad Example

```swift
var messages: [String] = []
```

Many threads modifying simultaneously:
- crash
- corruption

---

# Actor Solution

```swift
actor ChatStore {

    var messages: [String] = []

    func add(_ message: String) {
        messages.append(message)
    }
}
```

Actor guarantees:
- thread-safe access

---

# VERY Relevant for AI Agents

Agents often maintain:
- conversation state
- memory
- tools
- evaluations

Actors help manage safely.

---

# 11. Task

Creates async work.

---

# Example

```swift
Task {

    let response = await fetch()

    print(response)
}
```

---

# Why Important?

Runs async code from normal context.

---

# 12. Parallel API Calls

VERY useful in evaluation systems.

---

# Example

```swift
async let r1 = modelA()
async let r2 = modelB()

let results = await [r1, r2]
```

Useful for:
- comparing LLM outputs
- evaluation pipelines

VERY relevant for Apple JD.

---

# 13. Streaming Responses

LLM APIs often stream tokens.

---

# Example Concept

```text
Token 1 arrives
Token 2 arrives
Token 3 arrives
```

instead of waiting full response.

---

# Important Related Swift Concepts

| Concept | Purpose |
|---|---|
| AsyncSequence | streaming |
| for await | consume stream |
| actors | shared stream state |
| Task | background streaming |

---

# Example

```swift
for await token in stream {

    print(token)
}
```

---

# 14. Protocol-Oriented Design

Apple LOVES this.

---

# Example

```swift
protocol LLMProvider {

    func generate(prompt: String) async throws -> String
}
```

---

# OpenAI Implementation

```swift
class OpenAIProvider: LLMProvider {

    func generate(prompt: String) async throws -> String {
        return "response"
    }
}
```

---

# Claude Implementation

```swift
class ClaudeProvider: LLMProvider {

    func generate(prompt: String) async throws -> String {
        return "response"
    }
}
```

---

# Why Important?

Easy:
- swapping models
- testing
- evaluation
- modularity

This is EXACTLY infrastructure thinking Apple wants.

---

# 15. Dependency Injection

VERY important architecture concept.

---

# Bad

```swift
class ChatService {

    let provider = OpenAIProvider()
}
```

Hardcoded.

---

# Better

```swift
class ChatService {

    let provider: LLMProvider

    init(provider: LLMProvider) {
        self.provider = provider
    }
}
```

Now:
- testable
- modular
- scalable

Apple likes this strongly.

---

# 16. Retry Logic

Important for production APIs.

---

# Example

```swift
for _ in 1...3 {

    do {
        return try await fetch()
    } catch {

    }
}
```

---

# 17. Rate Limiting

LLM APIs have limits.

Need:
- throttling
- queues
- retry policies

---

# 18. Evaluation Systems (VERY Relevant to JD)

Apple JD repeatedly mentions:
- evaluation
- quality
- measurement

---

# Example Architecture

```text
Prompt
   ↓
Model A
Model B
   ↓
Collect Outputs
   ↓
Score Outputs
   ↓
Store Metrics
   ↓
Dashboard
```

---

# Swift Concepts Used

| Concept | Why |
|---|---|
| concurrency | parallel evaluations |
| actors | shared metrics |
| protocols | pluggable models |
| Codable | result serialization |
| async/await | async inference |
| closures | callbacks |
| Result | failures |
| TaskGroup | parallel evaluation |

---

# 19. Most Important Swift Topics for AI Engineers

Priority order:

1. async/await
2. URLSession
3. Codable
4. Error handling
5. Actors
6. Protocols
7. Task / TaskGroup
8. Closures
9. Dependency Injection
10. Streaming APIs

---

# 20. Biggest Interview Insight

For Apple AI/tooling interviews:

They care LESS about:
- memorizing Swift syntax

More about:
- concurrency
- architecture
- reliability
- abstractions
- infrastructure thinking
- evaluation systems
- production engineering

---

# 21. BEST Mini Project for You

Build:

## Multi-LLM Evaluation Tool

Features:
- send prompt to GPT + Claude
- compare outputs
- score responses
- store metrics
- show latency
- retry failures
- async parallel execution

This project alone touches:
- APIs
- concurrency
- evaluation
- tooling
- architecture
- AI systems

which aligns EXTREMELY well with this Apple role.
