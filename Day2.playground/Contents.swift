import Cocoa
// Day 2: Booleans and string interpolation

/* Booleans */
/*
 - can use .toggle() on a boolean to flip it
 */

var isAuthenticated = false
isAuthenticated.toggle()
print(isAuthenticated)

/* String interpolation */
/*
 - "My name is \(name)."
 - You can do math inside of strings with string interpolation too:
     - "5 * 5 is \(5 * 5)."
 */

let first = "Hello, "
let second = "world!"
let greet = first + second
print(greet)

let people = "Players"
let action = "Play"
let lyric = people + " gonna " + action
print(lyric)

// inefficient because swift cannot add them all together in one step
let code  = "1" + "2" + "3" + "4" + "5"

let name = "AD"
let age = 19
let message = "\(greet) My name is \(name). I am \(age) years old."
print(message)

print ("5 * 5 is \(5*5)")
