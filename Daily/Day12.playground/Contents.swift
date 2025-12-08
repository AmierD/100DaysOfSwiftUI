import Cocoa

/* Day 12: classes and inheritance */

/* Classes */
/*
 - how are classes different than structs?:
    - inheritance
    - no automatic memberwise initializer
    - copying an instance of a class only creates a reference to the instance (i.e.data is shared between copies)
    - When the final copy of a class instance is destroyed, Swift can optionally run a special function called a deinitializer
    - even if a class is created as a constant, you can still change its properties (if they're variables)
 - when inheriting, the subclass must initialize all properties of the superclass as well
 - mark a class as final to stop other classes from inheriting from it
 - deinitializers
    - defined with the deinit keyword
    - never take parameters or return data
    - never called directly
    - structs do not have deinitializers because they cant be copied
 - classes are destroyed when they exit scope
 */

// trivial class that could be implemted as a struct
class Game {
    var score = 0 {
        didSet {
            print("Score is now \(score)")
        }
    }
}

var newGame = Game()
newGame.score += 10

// inheritance
class Employee {
    let hours: Int
    
    init(hours: Int) {
        self.hours = hours
    }
    func printSummary() {
        print("I've worked \(hours) hours today.")
    }
}

class Developer: Employee {
    func work() {
        print("I have been writing code for \(hours).")
    }
}
class Manager: Employee {
    func work() {
        print("I have been in meetings for \(hours).")
    }
    override func printSummary() {
        print("Ok, I've only been working for \(hours/2) hours.")
    }
}

let amier = Manager(hours: 100)
let john = Developer(hours: 5)
amier.work()
john.work()
john.printSummary()
amier.printSummary()

// super keyword for referencing super class init/properties
class Vehicle {
    let isElectric: Bool
    
    init(isElectric: Bool) {
        self.isElectric = isElectric
    }
}

class Car: Vehicle {
    let isConvertible: Bool
    
    init(isElectric: Bool, isConvertible: Bool) {
        self.isConvertible = isConvertible
        super.init(isElectric: isElectric)
    }
}

// classes are reference types
class User {
    var username = "Anonymous"
    
    // creating a unique ("deep") copy
    func copy() -> User {
        let user = User()
        user.username = username
        return user
    }
}

var user1 = User()
var user2 = user1
var user3 = user1.copy()

user2.username = "Amier"
print(user1.username)
print(user3.username)

// deinitializaiton
class Book {
    let id: Int
    
    init(id: Int) {
        self.id = id
        print("Book:\(id) created")
    }
    
    deinit {
        print("Book:\(id) destroyed")
    }
}

// each book is created and destroyed each iteration of the loop
for i in 1...3 {
    let book = Book(id: i)
    print("Book:\(book.id) is pretty good")
}

var books = [Book]()

for i in 1...3 {
    let book = Book(id: i)
    print("Book:\(book.id) is pretty good")
    books.append(book)
}

// all books are destroyed at the same time when removeAll() is called
print("Loop is finished!")
books.removeAll()
print("Array is clear!")
