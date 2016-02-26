import Cocoa

class Friction:Mover{
    init(target:NSView, aValue:CGFloat, velocity:CGFloat = 0, frictionStrength:CGFloat = 0.98){
        super.init(target, aValue, velocity)
        self.frictionStrength = frictionStrength
    }
}
