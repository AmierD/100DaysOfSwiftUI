import Cocoa

/* Day 8: default values, throwing functions */

/* Default Values: */
// utilizes a default value for the "to" parameter
func printTimesTables(for number: Int, to: Int = 10) {
    for i in 1...to {
        print ("\(number) * \(i) = \(number * i)")
    }
}
// this makes it optional to include a value for "to" when the function is called
printTimesTables(for: 5)

/* Errors: */
// Step 1: define possible errors
enum PasswordError: Error {
    case short
    case obvious
}

// Step 2: write a function that triggers/throws the errors
func checkPassword(_ pass: String) throws -> String {
    if pass.count < 8 {
        throw PasswordError.short
    }
    if pass == "12345678" || pass == "password" {
        throw PasswordError.obvious
    }
    if pass.count < 10 {
        return "Password is ok"
    } else if pass.count < 12 {
        return "Password is good"
    } else {
        return "Password is excellent"
    }
}
// Step 3: handle thrown errors using do, try, and catch
func printPassword(_ pass: String) {
    do {
        try print(checkPassword(pass))
    } catch PasswordError.short {
        print("Password too short")
    } catch PasswordError.obvious {
        print("Password not secure")
    } catch { // need this line because catch statements must be exhaustive
        print("Password invalid")
    }
}

let pass1 = "Amier"
let pass2 = "12345678"
let pass3 = "Acceptabl3P4ss"

printPassword(pass1)
printPassword(pass2)
printPassword(pass3)
