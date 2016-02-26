import Cocoa

class Friction:Mover{
    init(target:NSView,aValue:Number, aVelocity:Number = 0, aFrictionStrength:Number=0.98){
        super(aTarget, aValue, aVelocity);
        this.frictionStrength = aFrictionStrength;
    }
}
