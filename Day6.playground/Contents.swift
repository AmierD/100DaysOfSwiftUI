import Cocoa

// Day 6: loops
/* for loops */
/*
 - for [each element] in [array/dict/set]
 - for i in 1...12
 - for _ in 1..<10
    - if you don't need the count variable like I
 - x...y -> from x to y including x and y
 - x..<y -> from x to y including x and y - 1
 - loop skips:
     - continue -> skips current loop iteration
     - break -> skips all remaining iterations
 - you can label statements in swift and break specific statements
 */
let drinks = ["Fanta", "Lemonade", "Pepsi", "Sierra Mist"]
for drink in drinks {
    print("I love \(drink)!")
}

for i in 1..<10 {
    print("\(i) - 5 = \(i - 5)")
}

let fileExplorer = ["FrenchPresentation.keynote", "Logo.psd", "Picture1.jpg", "Picture2.jpg"]
for file in fileExplorer {
    if (!file.hasSuffix(".jpg")) {
        continue
    }
    print("Picture: \(file)")
}
// finds prime numbers:
let target = 1000
for i in 2...target {
    var isPrime = true
    for j in 2..<i {
        if i % j == 0 {
            isPrime = false
        }
    }
    if isPrime {
        print(i)
    }
}
// illustrating labeled statements:
let options = ["up", "down", "left", "right"]
let secretCombination = ["down","right", "left"]

outerLoop: for option1 in options {
    for option2 in options {
        for option3 in options {
            let currentCombo = [option1, option2, option3]
            if currentCombo == secretCombination {
                print("Found combination!")
                break outerLoop // ends the whole loop when the combo is found
            }
        }
    }
}

/* while loops*/
/*
 
 */
let guessTarget = Int.random(in: 1...10)
var rand = Int.random(in: 1...10)
while rand != guessTarget {
    print("\(rand) not correct.")
    rand = Int.random(in: 1...10)
}
print("Target \(guessTarget) found!")
