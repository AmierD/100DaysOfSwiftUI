import Cocoa
// Day 1: Variables, strings, ints, doubles

/* Strings */
/*
  - String can include emojis
  - var --> mutable
  - let --> immutable
  - multi-line strings with """ """
  - .count for string length
  - hasPrefix & hasSuffix string methods
  - to cast as string: String(x)
 */
var lastName = "Davis" // var variables are mutable
let character = "Amier 😀" // let variables are immutable
let file = lastName + ".JPG"
let info = """
    Height = 6'0"
    Weight = 164lbs
    Eye color = brown
    """

if (character == "Amier 😀") {
    lastName = character
}
print(lastName)
print(info)
print(lastName.count)
print((character.hasPrefix("Amier") ? "Does".uppercased() : "Does not") + " start with \"Amier\"")
print(file + " " + (file.lowercased().hasSuffix(".jpg") ? "Does" : "Does not") + " end with \".jpg\"")

/* Integers */
/*
  - can be up to quintillions
  - can be separated by underscores for readability
  - .isMultiple(of: int)
  - compound operators are valid (ex: +=, *=, %=, etc
  - to cast as int: Int(x)
  - cannot be added to doubles unless casted as double
 */

// these two numbers are the same
let huge = 100_000_000
let alsoHuge = 1_00000000

print(huge == alsoHuge)

var num = 5
print(num.isMultiple(of: 3))

num += huge
print(num)

/* Doubles */
/*
  - to cast as Double(x)
  - cannot be added to ints unless casted as int
 */

let decimal = 0.1 + 0.5
let otherDecimal = 1.0 // this is a double
print(decimal)

let strAge = "5"
let intAge = Int(strAge)
