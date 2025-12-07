import Cocoa

/* Checkpoint 6 */

struct Car {
    let model: String
    let seats: Int
    private var gear = 0
    
    init(model: String, seats: Int) {
        self.model = model
        self.seats = seats
    }
    
    mutating func shiftUp() {
        if gear < 8 {
            gear += 1
        }
    }
    mutating func shiftDown() {
        if gear > 0 {
            gear -= 1
        }
    }
    func getGear() -> Int {
        return gear
    }
}

var rosa = Car(model: "Civic", seats: 5)

rosa.shiftUp()
rosa.shiftUp()

print("Rosa's model: \(rosa.model), amount of seats Rosa has: \(rosa.seats), Rosa's current gear: \(rosa.getGear())")
