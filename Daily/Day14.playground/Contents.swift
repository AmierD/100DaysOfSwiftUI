import Cocoa

/* Day 14: optionals */
/*
 - every data type can be optional
 - optional means there may be a value present or they may not be, you must unwrap to check
 - optionals must be unwrapped
    - if let [temp variable] = [optional variable] {}
    - if let [optional variable] {}
        - allows you to choose what will happen if the optional is not nil
        - temp variable and optional variable can have the same name when unwrapping in this way
    - guard let [temp variable] = [optional variable] else {}
    - guard let [optional variable] {}
        - allows you to choose what will happen if the optional is nil
            - usually returning a function
        - allows you to keep using the variable after the guard let else block if it ends up not being nil
        - you can use guard with any condition, not just ones that unwrap optionals
    - ?? (nil coalescing operator)
        - allows us to unwrap an optional and provide a default value if it is nil
        - this ensures that the result will always be non-optional
    - optional chaining
        - does nothing if optional was empty
 - try?
    - if an error is thrown:
        - returns nil
        - app does not crash
        - error is ignored (therefore this is not good if you need to know which error is thrown)
    - useful:
        - in combination with guard let to exit the current function if the try? call returns nil
        - in combination with nil coalescing to attempt something or provide a default value on failure
        - when calling any throwing function without a return value (when you dont care what is thrown)
 */
let opposites = [
    "Mario": "Wario",
    "Luigi": "Waluigi"
]

// if let syntax
if let peachOpposite = opposites["Peach"] {
    print("Peaches opposite is \(peachOpposite).")
} else {
    print("No value for peach.")
}

var username: String? = nil
if let user = username {
    print("User is \(user).")
} else {
    print("No user found.")
}

func square(num: Int) -> Int {
    return num * num
}

// the following code will not build because the function does not take in an optional, and has no way of unwrapping one
/*
 var num: Int? = nil
 print(square(num: num))
 */

var number: Int? = 5

// temp variable and optional variable can have the same name when unwrapping with if let
if let number = number {
    print("Number is \(number).")
} else {
    print("Number is nil.")
}

var myVar: Int? = 3

// guard let else syntax
func unwrapOne(_ num: Int?) {
    if let num = num {
        print("Variable has a value.")
    }
}
func unwrapTwo(_ num: Int?) {
    guard let num else {
        print("Variable does not a value.")
        return
    }
    print("\(num * num)")
}

unwrapOne(myVar)
unwrapTwo(myVar)

// ?? (nil coalescing)
let fruitFavorites = [
    "Oranges": true,
    "Pineapples": true,
    "Mangoes": false
]

let apple = fruitFavorites["Apples"] ?? false

// optional chaining
struct Book {
    let title: String
    let author: String?
}

var book: Book? = nil

let author = book?.author?.first?.uppercased() ?? "A"

// try?
enum MathError: Error {
    case divideByZero
}
func divide(_ num1: Int, by num2: Int) throws -> Int {
    if num2 == 0 { throw MathError.divideByZero }
    return num1 / num2
}

// result1 will be 5
let result1 = try? divide(10, by: 2)

// result2 will be nil
let result2 = try? divide(10, by: 0)

