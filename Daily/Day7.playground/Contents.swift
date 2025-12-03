import Cocoa

// Day 7: functions, parameters, and return values
/*
 - can define different parameter labels for internal vs external
    - func function(label name: String) {}
 - define return type with ->
    - func rollDice() -> Int {}
 - can return multiple values in a function many ways, but usually the best way is with a tuple
 */

func showWelcome(_ name: String) {
    print("""
        Welcome, \(name) to my program!
        My name is Amier.
        """)
}

func showGoodbye(firstName name: String, count: Int) {
    for _ in 1...count {
        print("""
            Goodbye, \(name) to my program!
            I'll see you next time!.
            """)
    }
}

showWelcome("Bob")
showWelcome("James")
showGoodbye(firstName: "Alex", count: 3)

func rollDice() -> Int {
    return Int.random(in: 1...20)
}
print(rollDice())

/*
 when a function only has one line of code (that returns the specified data type,
 we do not have to write "return," as it is implied.
 */
func hasSameLetters(stringOne one: String, stringTwo two: String) -> Bool {
    one.sorted() == two.sorted()
}
func hasSameLettersPrint(_ one: String, _ two: String) {
    print(
        "\(one) \(hasSameLetters(stringOne: one, stringTwo: two) ? "has the same letters as" : "does not have the same letters as") \(two)")
}

let one = "tacocat"
let two = "cattaco"
let three = "games"
hasSameLettersPrint(one, two)
hasSameLettersPrint(one, three)

/*
 using a similar principle as before, the following is an example of using
 "if as an expression," it is similar to the ternary operator
 */
func greet(name: String) -> String {
    let response = if name == "Amier" {
        "Hello Amier"
    } else {
        "Who are you, \(name)?"
    }
    return response
}

print(greet(name: "Amier"))
print(greet(name: "John"))

func pythagoras(side1 a: Double, side2 b: Double) -> Double {
    sqrt(pow(a, 2) + pow(b, 2))
}

let sideOne = 3.0
let sideTwo = 4.0

print("""
    The length of the hypotenuse of a triangle with sides
    of length \(sideOne) and \(sideTwo) is \(pythagoras(side1: sideOne, side2: sideTwo))
    """)

func getUser() -> (firstName: String, lastName: String) {
    /*
     when returning a tuple from a function, the names
     of the items in the returned tuple are implicit:
     */
    return ("Amier", "Davis")
}
let user = getUser()
print("Hello \(user.firstName) \(user.lastName)")

/*
 creates two variables and assigns each to the corresponding value of
 the returned tuple from the function:
 */
let (firstName, lastName) = getUser()

print("Hello \(firstName) \(lastName)")

// if you do not need all the values from the returned tuple, use an _
let (name, _) = getUser()
print("Hello \(name)")

func printTimesTables(for number: Int) {
    for i in 1...12 {
        print("\(i) x \(number) is \(i * number)")
    }
}

printTimesTables(for: 5)


