import Cocoa
// Arrays, dicts, sets, enums
/* Arrays */
/*
 - Stores any one data type
 - initialization
     - var array = Array<T>()
     - var array = [String]()
     - var array: [Int] = [10, 12, 9]
     - var array = [5, 6]
 - .append() to add
 - .count
 - .contains()
 - .sorted()
 - .reversed()
 - .remove(at: ) - specific index
 - .removeAll()
 */

let days = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"]
var scores = Array<Int>()
scores.append(5)
print("First score: \(scores[0]). Random day: \(days[5])")
for item in days.reversed() {
    print(item)
}

/* Dictionaries */
/*
 - basically a hash map
 - initialization
    - var villains = [String: String]()
    - var villains = [
        "batman": "joker",
        "superman": "zod",
      ]
 - use alot of similar methods to arrays
 */

var villains = [
    "batman": "joker",
    "superman": "zod",
]
print(villains["batman"]) // ok
print(villains["batman", default: "Unknown"]) // best practice
    
/* Sets */
/*
 - Best for specific use cases
    - fast data lookup
    - when you do not want duplicate data
    - etc
 - Automatically removes duplicate values
 - Automatically ordered using the set class' own sorting method (hashes maybe?)
    - makes methods more efficient
    - as a result, we cannot manually order the elements in a set
 - Initialized by creating an array and basically casting it as a set
 */

let people = Set(["AD", "LD", "AD", "AJD"])

for person in people {
    print(person)
}

/* Enums */
/*
 - good for finite, known values
 - essentailly a new data type with specific values we define
 - stored/checked more efficiently than say, a string, under the hood
    - likely assigns an integer to each value
 */

enum Weekday {
    case monday, tuesday, wednesday // can do multiple on one line
    case thursday // or one per line
    case friday
    case saturday
    case sunday
}

var day = Weekday.monday
day = Weekday.tuesday
day = .wednesday // implciit assignment
print (day = Weekday.monday)

