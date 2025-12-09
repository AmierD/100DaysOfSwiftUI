import Cocoa

/* Checkpoint 9 */

func oneRandom(array: [Int]?) -> Int {
    array?.randomElement() ?? Int.random(in: 1...100)
}

let array1: [Int]? = nil
let array2: [Int]? = [5, 6, 7, 90]

print(oneRandom(array: array1))
print(oneRandom(array: array2))
