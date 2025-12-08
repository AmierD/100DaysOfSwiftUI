import Cocoa

class Animal {
    let legs: Int
    
    init() {
        legs = 4
    }
}

class Dog: Animal {
    
    func speak() {
        print("Bark")
    }
    
}
class Cat: Animal {
    let isTame: Bool
    
    init(isTame: Bool) {
        self.isTame = isTame
    }
    
    func speak() {
        print("meow")
    }
}

class Corgi: Dog {
    override func speak() {
        print("big woof")
    }
}
class Poodle: Dog {
    override func speak() {
        print("woof")
    }
}

class Persian: Cat {
    override func speak() {
        print("purr")
    }
}
class Lion: Cat {
    override func speak() {
        print("roar")
    }
}

var cat = Cat(isTame: true)
var lion = Lion(isTame: false)

cat.speak()

print(lion.isTame)

