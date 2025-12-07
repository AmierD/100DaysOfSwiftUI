import Cocoa

/* Day 11: access control, static properties, and property observers */
/*
 - private: don’t let anything outside the struct use this
 - private(set): dont let anything outside of the struct modify this (strictly viewing it is ok)
 - fileprivate: don’t let anything outside the current file use this
 - public: let anyone, anywhere use this
 - if you use private for properties, you will likely have to create your own initializer
 */

struct BankAccount{
    private var funds: Int {
        didSet {
            print("Previous balance: \(oldValue)\nNew balance: \(funds)")
        }
    }
    
    init() {
        self.funds = 1000
    }
    init(funds: Int) {
        self.funds = funds
    }
    
    mutating func deposit(_ amount: Int) {
        funds += amount
    }
    mutating func withdrawal(_ amount: Int) -> Bool {
        if amount > funds {
            return false
        } else {
            funds -= amount
            return true
        }
    }
}

var account = BankAccount()

account.deposit(10)
print(account.withdrawal(1010) ? "Withdrawal Successful" : "Withdrawal Unsuccessful")
print(account.withdrawal(10) ? "Withdrawal Successful" : "Withdrawal Unsuccessful")

/* static */

struct MyApp {
    static let url = "google.com"
    static var usrCount = 0
}

print(MyApp.usrCount)
print(MyApp.url)

