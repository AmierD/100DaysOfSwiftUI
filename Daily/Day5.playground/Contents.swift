import Cocoa

// Day 5: if, switch, ternary conditional opterator
/* if statements */

let score = 90

if score > 85 {
    print("Great job!. You got a(n) \(score)")
}

let nameOne = "Amier"
let nameTwo = "Johnny"

if nameOne < nameTwo {
    print("\(nameOne) then \(nameTwo)")
}
else if nameTwo < nameOne {
    print("\(nameTwo) then \(nameOne)")
}

var array = [1, 2, 5]
if array.count < 3 {
    array.append(array.count)
} else {
    array.remove(at: 0)
    array.append(array.count)
}

var username = "m.ieracle"
if username == "" { // less efficient under the hood
    username = "Anon"
}
if username.isEmpty { // more efficient under the hood
    username = "Anon"
}
print("Hello, \(username).")

let temp = 84
if 75 < temp && temp < 85 {
    print("It is a nice day!")
}

enum TransportOption {
    case airplane
    case helicopter
    case bicycle
    case car
    case scooter
}
var trip = TransportOption.airplane
if trip == .airplane || trip == .helicopter{
    print("Let's fly!")
} else if trip == .bicycle {
    print("I hope there's a bike path...")
} else if trip == .car {
    print("Time to get stuck in traffic.")
} else {
    print("I'm going to hire a scooter now!")
}

/* switch statements */
/*
 - once case is satisfied, it will stop and not cascade down -> no break statement needed
    - can use the fallthrough keyword to do it though
 - must be exhaustive
    - check all possible cases or use a default case
 */
enum Weather {
    case sun
    case rain
    case wind
    case snow
    case unknown
}

let forecast = Weather.sun

switch forecast {
case .sun:
    print("It should be a nice day.")
case .rain:
    print("Pack an umbrella.")
case .wind:
    print("Wear something warm.")
case .snow:
    print("School is cancelled.")
case .unknown:
    print("Our forecast generator is broken!")
}

let day = 5
print("My true love gave to me:")
switch day {
case 5:
    print("5 golden rings")
    fallthrough
case 4:
    print("4 calling birds")
    fallthrough
case 3:
    print("3 french hens")
    fallthrough
case 2:
    print("2 turtle dove")
    fallthrough
default:
    print("and a partridge in a pear treeee")
}

let userInfo = (access: Access.admin, canEdit: true)
switch userInfo {
case (access: Access.admin, _):
    fallthrough
case (_, canEdit: true):
    print("You can edit.")
default:
    print("You cannot edit.")
}

/* The ternary conditional operator */
/*
 - binary -> 2
    - a binary operator takes two inputs
 - ternary -> 3
    - the ternary operator takes 3 inputs
 */

enum Theme {
    case light
    case dark
}

let theme = Theme.light

let background = theme == .dark ? "black" : "white"
print (background)

enum Access {
    case admin
    case normal
}
