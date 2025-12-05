import Cocoa

/* Day 9: closures & Checkpoint 5*/
/* Closures */
/*
 - default arguments are not allowed in closures
 - you do not use external parameter labels for closures
 - functions have types
    - types are defined by the *types* of data a function recieves and returns
 -  there are many (optional) shorthand syntax options for closures
    - trailing closures: If one or more of a function’s final parameters are functions, you can use trailing closure syntax
    - shorthand parameter names ($0, $1, etc)
 - useful for the following:
    - running code after a delay
    - running code after an animation has finished
    - running code when a download has finished
    - running code when a user has selected an option from your menu
 */

func sayHello(_ name: String = "Anon") {
    print("Hello \(name).")
}

// default value from sayHello will not apply to this function
let greet = sayHello

// no-parameter closure expression
let greet2 = {
    print("Hello.")
}

let greet3 = { (_ name: String) in
    print("Hello \(name).")
}

greet("Amier")
greet2()
greet3("Amier")

func getUserData(for id: Int) -> String {
    if id == 909 {
        return "Amier"
    } else {
        return "Unknown"
    }
}

/*
 this defines a variable, data, as a function with argument type Int and return type
 String and sets that function, data, to the function of that same type getUserData.
 */
let data: (Int) -> String = getUserData
// the data function does not need the for external parameter name
let user = data(909)
print(user)

let team = ["Hampton", "NSU", "Morgan State", "Howard", "PVAMU", "ASU"]
let sortedTeam = team.sorted()
print(sortedTeam)

func specificSort(s1: String, s2: String) -> Bool {
    if s1 == "Hampton" {
        return true
    } else if s2 == "Hampton" {
        return false
    }
    return s1 < s2
}

// passing a function into .sorted
let sortBy: (String, String) -> Bool = specificSort
let sortedTeam2 = team.sorted(by: sortBy)
print(sortedTeam2)

// passing a closure into .sorted
let sortedTeam3 = team.sorted(by: { (s1: String, s2: String) -> Bool in
    if s1 == "Howard" {
        return true
    } else if s2 == "Howard" {
        return false
    }
    return s1 < s2
})
print(sortedTeam3)

// 1st shortening of previous code: removing implicit types
let sortedTeam4 = team.sorted(by: { s1, s2 in
    if s1 == "Howard" {
        return true
    } else if s2 == "Howard" {
        return false
    }
    return s1 < s2
})
print(sortedTeam4)

// 2nd shortneing of previous code: trailing closure (passing the closure directly instead of as a parameter)
let sortedTeam5 = team.sorted { s1, s2 in
    if s1 == "Howard" {
        return true
    } else if s2 == "Howard" {
        return false
    }
    return s1 < s2
}
print(sortedTeam5)

// 3rd and final shortening of previous code: shorthand syntax for values
let sortedTeam6 = team.sorted {
    if $0 == "Howard" {
        return true
    } else if $1 == "Howard" {
        return false
    }
    return $0 < $1
}
print(sortedTeam6)

print(team.sorted {$0 > $1})

print(team.map {$0.uppercased()})

// creating a function that takes a function as a parameter
func makeArray(size: Int, using generator: () -> Int) -> [Int] {
    var array = [Int]()
    
    for _ in 1...size {
        array.append(generator())
    }
    return array
}

func getRandSeven() -> Int {
    return Int.random(in: 1...10) * 7
}

print(makeArray(size: 5, using: getRandSeven))

// syntax for multiple trailing closures
func doSomethingImportant(one: () -> Void, two: () -> Void, three: () -> Void) {
    print("First thing:")
    one()
    print("Second thing:")
    two()
    print("Third thing:")
    three()
}

doSomethingImportant {
    print("That first thing")
} two: {
    print("That second thing")
} three: {
    print("That third thing")
}

// another example of trailing closure syntax
func animate(duration: Double, animations: () -> Void) {
    print("Starting a \(duration) second animation…")
    animations()
}

// normal closure
animate(duration: 3, animations: {
    print("Fade out the image")
})

// trailing closure
animate(duration: 3) {
    print("Fade out the image")
}
