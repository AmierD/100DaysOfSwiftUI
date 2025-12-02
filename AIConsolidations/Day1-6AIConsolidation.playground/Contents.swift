import Cocoa

/*
 Used AI to create a problem to consolidate my knowledge of the last few days.
 This is my answer to that problem, with the corrections having comments preceding them
 */

enum ServerState: String {
    case active
    case maintanence = "currently being serviced."
    case offline = "Non-critical server offline."
    case overheated = "CRITICAL TEMP ALERT"
}
let criticalSystems = Set(["Srv-Alpha", "Srv-Beta", "Srv-Gamma"])

/*
 Correction:
 can use Type Annotation to only have to write ServerState once
 */
let registry: [String: ServerState] = [
    "Srv-Alpha": .active,
    "Srv-Beta": .overheated,
    "Srv-Delta": .offline,
    "Srv-Gamma": .active,
    "Srv-Epsilon": .maintanence
]
let dailyYields = [4.5, 2.3, 0.0, 5.1, 1.2, 0.0, 3.8]


var totalYield = 0.0
var operationalCount = 0
var criticalAlerts = 0

/*
 Correction:
 dicts are unordered, so simply looping through them would be non-deterministic
 so, best practice is to use closures which are introduced around day 9
 */
outerLoop: for (server, status) in registry.sorted(by: {$0.key < $1.key}) {
    switch status {
    case .active:
        operationalCount += 1
    case .maintanence:
        print("\(server) \(status.rawValue)")
    case .offline:
        if criticalSystems.contains(server) {
            print("URGENT: \(status.rawValue)")
            criticalAlerts += 1
        }
        else {
            print(status.rawValue)
        }
    case .overheated:
        print(status.rawValue)
        break outerLoop
    }
}

for yield in dailyYields {
    if yield.isZero {
        continue
    }
    totalYield += yield
}

print("""
    System Check Complete.
    Operational Servers: \(operationalCount)
    Total Yield (excluding down days): \(totalYield)
    """)
