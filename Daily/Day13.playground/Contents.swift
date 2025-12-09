import Cocoa

/* Day 13: protocols and extensions */
/* Protocols */
/*
 - similar to interfaces in java
 - allow us to define a "blueprint" for structs/classes/enums
 - we can now pass this blueprint as a type
    - it will accept all things that conform to this blueprint
 - a class can subclass and conform to a protocol
 - you can return protocols
    - ex illustrated w/ protocol Vehicle:
        - () -> Vehicle
            - "returns any vehicle type but we dont know what"
        - () -> some Vehicle (opaque type)
            - "returns a specific type of the Vehicle type but we don't want to say which one"
        - () -> any Vehicle (existential type)
            - "returns a specific type of the Vehicle type but we don't want to say which one"
 */

protocol Vehicle {
    // when implemented, name must at least be able to be read (i.e. a constant or computed with a getter)
    var name: String { get }
    // when implemented, current passengers must be able to be read and written (i.e. a var or computed with a getter and setter)
    var currentPassengers: Int { get set }
    func estimateTime(for distance: Int) -> Int
    func travel(distance: Int)
}

struct Car: Vehicle {
    let name: String = "car"
    var currentPassengers: Int = 3
    func estimateTime(for distance: Int) -> Int {
        distance / 60
    }
    func travel(distance: Int) {
        print("I'm driving \(distance) miles.")
    }
    
    func turnOnHeadLights() {
        print("Head lights are now on.")
    }
}

struct Train: Vehicle {
    let name: String = "train"
    var currentPassengers: Int = 40
    func estimateTime(for distance: Int) -> Int {
        distance / 100
    }
    func travel(distance: Int) {
        print("I'm riding \(distance) miles in a train.")
    }
}

// can pass in any variable of type Vehicle to this function (i.e. a Car or Train)
func commute(distance: Int, using vehicle: Vehicle) {
    if vehicle.estimateTime(for: distance) < 70 {
        print("This \(vehicle.name) is way too slow.")
    } else {
        vehicle.travel(distance: distance)
    }
}

let car = Car()
let train = Train()
let distance = 100

commute(distance: distance, using: car)
commute(distance: distance, using: train)

func getRandomNumber() -> some Equatable {
    Int.random(in: 1...6)
}

// opposed to writing it this way, which would fail the following code
/*
 func getRandomNumber() -> Equatable {
     Int.random(in: 1...6)
 }
 */

if getRandomNumber() == getRandomNumber() {
    print("Equal!")
} else {
    print("Not equal.")
}

/* Extensions */
/*
 - allow us to add functionality to any type (created by me or someone else - even Apple!)
 - you can use extensions to add properties to types
    - they MUST be computed
 - implementing a custom initializer inside an extension will keep the memberwise initializer (assuming it was not diabled prior)
 - we can create extensions for protocols too (protocol extensions)
 */

// trimmingCharacters(in:) is a String method, but it is a long function to write.
// to remedy this, we can use an extension to effectively rename it.

extension String {
    // rerturns the same string, modified
    mutating func trimmed(in characterSet: CharacterSet) -> String {
        self = self.trimmingCharacters(in: characterSet)
        return self
    }
    // returns a new string
    func trim(in characterSet: CharacterSet) -> String {
        self.trimmingCharacters(in: characterSet)
    }
    
    // new property that computes to be an array of all the lines in a string
    var lines: [String] {
        self.components(separatedBy: .newlines)
    }
}

var alot = "      AMier "
print(alot)
print(alot.trim(in: .whitespacesAndNewlines))
print(alot.trimmed(in: .whitespacesAndNewlines))

let multi = """
This is
a
multiline string
"""
print(multi.lines)
print(multi.lines.count)

// protocol extensions
extension Collection {
    var isNotEmpty: Bool {
        !isEmpty
    }
}

print(multi.lines.isNotEmpty)
