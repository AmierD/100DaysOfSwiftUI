import Cocoa

/* Checkpoint 4 */

enum SqrtError: Error {
    case outOfBounds
    case noRoot
}

func getSqrt(_ num: Int) throws -> Int {
    if num < 1 || num > 10_000 {
        throw SqrtError.outOfBounds
    }
    if num == 1 {
        return 1
    }
    for i in 2...num {
        if num % i == 0 && num / i == i {
            return i
        }
    }
    throw SqrtError.noRoot
}
for i in 0...49 {
    do {
        try print(getSqrt(i))
    } catch SqrtError.outOfBounds {
        print("\(i) out of bounds")
    } catch SqrtError.noRoot {
        print("No root found for \(i)")
    } catch {
        print("Error")
    }
}
