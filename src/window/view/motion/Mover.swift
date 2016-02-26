import Cocoa

class Mover {
    var value:CGFloat = 0
    var velocity:CGFloat
    var target:NSView//change this to IPositionable in the future
    init(target:NSView, value:CGFloat, velocity:CGFloat = 0){
        self.target = target;
        self.value = value;
        self.velocity = velocity;
    }
    func updatePosition() {
        //trace("updatePosition")
        value += velocity;
    }
}
