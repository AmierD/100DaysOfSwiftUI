import Cocoa

enum OutputStatus {
    case offline
    case nominal
    case peak
}
enum GridSeverity: Int {
    case deficit = 25
    case stable = 60
    case surplus = 100
}

struct PowerGenerator {
    let name: String
    let capacity: Int
    var currentOutput: Int {
        didSet {
            switch status {
            case .offline:
                print("\(name) has unexpectedly shut down.")
            case .peak:
                print("\(name) is running at peak capacity (\(efficiency)%)")
            default:
                print("\(name) running normally.")
            }
        }
    }
    var efficiency: Double {
        Double(currentOutput) / Double(capacity) * 100.0
    }
    var status: OutputStatus {
        if currentOutput == 0 {
            return .offline
        } else if efficiency < 90.0 {
            return .nominal
        } else {
            return .peak
        }
    }
}

var generators = [
    PowerGenerator(name: "Generator 1", capacity: 20, currentOutput: 19),
    PowerGenerator(name: "Generator 2", capacity: 20, currentOutput: 15),
    PowerGenerator(name: "Generator 3", capacity: 10, currentOutput: 5)
]

func simulateLoad(_ generators: inout [PowerGenerator], strategy: (PowerGenerator) -> Int) -> Int {
    var totalOutput = 0
    // can use this instead of 0..<generators.count:
    for i in generators.indices {
        generators[i].currentOutput = strategy(generators[i])
        totalOutput += generators[i].currentOutput
    }
    return totalOutput
}

let solarFlare = simulateLoad(&generators) { $0.capacity * 2 }
let brownout = simulateLoad(&generators) { _ in
    Int.random(in: 1...15)
}

func calculateGridSeverity(_ totalOutput: Int) -> String {
    var gridStatus: String
    switch totalOutput {
    case 0..<GridSeverity.deficit.rawValue:
        gridStatus = "CRITICAL: Output is low."
    case GridSeverity.deficit.rawValue..<GridSeverity.stable.rawValue:
        gridStatus = "Output is stable."
    default:
        gridStatus = "SURPLUS POWER: Ready to export."
    }
    return gridStatus
}

print("Solar flare: \(calculateGridSeverity(solarFlare))")
print("Brownout: \(calculateGridSeverity(brownout))")

enum Weather {
    case sunny
    case cloudy
    case stormy
}

/* Advanced: higher order functions (functions that return functions/closures) */
func getLoadStrategy(for weather: Weather) -> (PowerGenerator) -> Int {
    switch weather {
    case .sunny:
        return {$0.capacity * 2}
    case .cloudy:
        return {_ in
            Int.random(in: 1...20)
        }
    case .stormy:
        return { generator in
            print("\(generator.name) shutdown due to inclimate weather.")
            return 0
        }
    }
}

let sunnyDayLoad = simulateLoad(&generators, strategy: getLoadStrategy(for: .sunny))
let cloudyDayLoad = simulateLoad(&generators, strategy: getLoadStrategy(for: .cloudy))
let stormyDayLoad = simulateLoad(&generators, strategy: getLoadStrategy(for: .stormy))

print("Sunny day status: \(calculateGridSeverity(sunnyDayLoad))")
print("Cloudy day status: \(calculateGridSeverity(cloudyDayLoad))")
print("Stormy day status: \(calculateGridSeverity(stormyDayLoad))")
