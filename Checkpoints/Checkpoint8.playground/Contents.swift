import Cocoa

protocol Building {
    var rooms: Int { get }
    var cost: Int { get }
    var agent: String { get set }
    
    func getSalesSummary()
}

extension Building {
    func getSalesSummary() {
        print("""
            Rooms: \(self.rooms)
            Construction cost: \(cost)
            Agent: \(agent)
            """)
    }
}

struct House: Building {
    var rooms: Int = 4
    var cost: Int = 100__000
    var agent: String = "Anon"
    
    mutating func addExtension() {
        rooms += 1
    }
}

struct Office: Building {
    var rooms: Int = 12
    var cost: Int = 600_000
    var agent: String = "Anon"
}

var house = House(agent: "John")
var office = Office(agent: "Amier")

house.addExtension()
house.getSalesSummary()
office.getSalesSummary()
