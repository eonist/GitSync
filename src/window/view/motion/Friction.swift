import Cocoa

class Friction:Mover{
    var frictionStrength:CGFloat;/*This value is the strength of the friction*/
    var lastValue:CGFloat = 0;/*this value is a temporary value that is used when checking if the motion is about to stop*/
    var slowDownFriction:CGFloat = 1;/*slowDownFriction is basically an inactive friction value, unless you change it to something else than 1*/
    init(_ target:NSView, _ value:CGFloat, _ velocity:CGFloat = 0, _ frictionStrength:CGFloat = 0.98){
        super.init(target, value, velocity)
        self.frictionStrength = frictionStrength
    }
}
