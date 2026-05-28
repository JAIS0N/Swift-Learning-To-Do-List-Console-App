import Foundation

// MARK: - Task Model

struct Task {
    let id: Int
    var title: String
}

// MARK: - Task Manager

var tasks: [Task] = []
var nextId = 1

// MARK: - Functions

func addTask() {
    print("Enter task title:")

    if let title = readLine(), !title.isEmpty {

        let task = Task(id: nextId, title: title)

        tasks.append(task)

        print("Task added successfully")

        nextId += 1

    } else {
        print("Invalid title")
    }
}

func viewTasks() {

    if tasks.isEmpty {
        print("No tasks available")
        return
    }

    print("\nTasks:")

    for task in tasks {
        print("\(task.id). \(task.title)")
    }
}

func removeTask() {

    viewTasks()

    print("Enter task id to remove:")

    if let input = readLine(),
       let id = Int(input) {

        if let index = tasks.firstIndex(where: { $0.id == id }) {

            tasks.remove(at: index)

            print("Task removed")

        } else {
            print("Task not found")
        }

    } else {
        print("Invalid input")
    }
}

// MARK: - Main Loop

while true {

    print("""
    
    ===== TO-DO APP =====
    1. Add Task
    2. View Tasks
    3. Remove Task
    4. Exit
    
    Enter choice:
    """)

    let choice = readLine()

    switch choice {

    case "1":
        addTask()

    case "2":
        viewTasks()

    case "3":
        removeTask()

    case "4":
        print("Goodbye")
        exit(0)

    default:
        print("Invalid choice")
    }
}
