import Cocoa

enum DispatchError: Error {
    case fuelEmpty
    case overCapacity
    case noDriverAssigned
}

protocol TransportUnit {
    var id: String { get }
    var capacity: Int { get }
    var currentFuelLevel: Double { get }
    
    func deliver(package weight: Int) throws
}

extension TransportUnit {
    func reportStatus() {
        print("ID: \(id)\tFuel Percentage: \(currentFuelLevel)")
    }
}

class Drone: TransportUnit {
    let id: String
    let capacity = 3
    var currentFuelLevel = 100.0 {
        didSet {
            if currentFuelLevel < 10.0 {
                print("Warning: low fuel")
            }
        }
    }
    
    init(id: String, currentFuelLevel: Double = 100.0) {
        self.id = id
        self.currentFuelLevel = currentFuelLevel
    }
    
    var flightRange = 70
    static let maxAltitude = 35
    
    func deliver(package weight: Int) throws {
        guard currentFuelLevel > 0 else { throw DispatchError.fuelEmpty }
        
        print("Delivered package of weight: \(weight)")
        currentFuelLevel -= Double(weight) * 8.0
    }
}

class Truck: TransportUnit {
    let id: String
    let capacity = 5
    var driver: Driver?
    
    var currentFuelLevel = 100.0 {
        didSet {
            if currentFuelLevel < 10.0 {
                print("Warning: low fuel")
            }
        }
    }
    
    init(id: String, currentFuelLevel: Double = 100.0) {
        self.id = id
        self.currentFuelLevel = currentFuelLevel
    }
    
    func deliver(package weight: Int) throws {
        guard currentFuelLevel > 0 else { throw DispatchError.fuelEmpty }
        guard weight <= capacity else { throw DispatchError.overCapacity}
        
        let driverName = driver?.name ?? "No Driver Assigned"
        
        currentFuelLevel -= Double(weight) * 4.0
        print(
            """
                \(driverName) delivered package of weight: \(weight)
                Current fuel level: \(currentFuelLevel)
            """
        )
    }
}

enum LicenceLevel {
    case standard
    case heavyDuty
    case pilot
}

struct Driver {
    let name: String
    var licenseLevel = LicenceLevel.standard
}

struct Hub {
    var transportUnits: [TransportUnit]
    
    func processFleet(_ method: (TransportUnit) -> Bool) {
        transportUnits.filter(method).forEach {
            print($0.id)
        }
    }
}
