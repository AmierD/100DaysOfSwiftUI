import Cocoa

/* Day 10: structs */
/*
 - structs allow us to create our own data types
 - String, Int, Bool, Set are all data types
 - functions that change data belonging to the struct must be marked as "mutating"
 - properties of structs
    - computed properties (as opposed to normal, stored properties)
        - these properties can have different behaviors for getting and setting
        - newValue is provided by swift
    - property observers
        - didSet
            - runs immediately after a property is changed
            - oldValue is provided by swift
        - willSet
            - runs immediately before a property is changed
            - newValue is provided by swift
 - initializers
    - swift gives a "default memberwise initializer" that can take all properties as arguments, even those with default values
        - this initializer goes away once you define your own, uncless you mark it with extension
    - can define custom initializers with init() but they must be exhaustive (assign all properties to something)
 */

struct Employee {
    // properties
    let name: String
    var vacationDays = 15
    var vacationTaken = 0
    // computed property:
    var vacationRemaining: Int {
        get {
            vacationDays - vacationTaken
        }
        set {
            vacationDays = vacationTaken + newValue // newValue is automatically given by swift
        }
    }
    
    // method
    mutating func takeVacation(_ days: Int) {
        if vacationRemaining >= days {
            vacationTaken += days
        } else {
            print("Not enough vacation days.")
        }
    }
}

// creates an instance of the Employee struct called employee1 with an initializer
var employee1 = Employee(name: "Amier")
employee1.takeVacation(5)
print("\(employee1.name) has \(employee1.vacationRemaining) days of vacation left. They took \(employee1.vacationTaken) days of vacation this year.")

// default initializer can take all properties as arguments, even those with default values
var employee2 = Employee(name: "John", vacationDays: 10)
employee2.takeVacation(10)
print("\(employee2.name) has \(employee2.vacationRemaining) days of vacation left. They took \(employee2.vacationTaken) days of vacation this year.")

employee2.vacationRemaining += 5

print("\(employee2.name) has \(employee2.vacationRemaining) days of vacation left. They took \(employee2.vacationTaken) days of vacation this year.")

/* Property Observers */

struct Game {
    var score = 0 {
        willSet {
            print("Score was \(score). Score is now \(newValue)")
        }
        didSet {
            print("Score was \(oldValue). Score is now \(score)")
        }
    }
}

var game = Game()
game.score += 5

/* Custom Initializers */
struct Player {
    let name: String
    let number: Int
    
    // inits must be exhaustive
    init(name: String) {
        self.name = name
        number = Int.random(in: 1...99)
    }
}

let player = Player(name: "James")
print(player.number)
