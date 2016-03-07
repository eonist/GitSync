import Cocoa

class Mover:IAnimator {
    var value:CGFloat = 0/*the value that should be applied to the target*/
    var velocity:CGFloat
    init(_ value:CGFloat, _ velocity:CGFloat = 0){
        self.value = value
        self.velocity = velocity;
    }
    func updatePosition() {
        //Swift.print("\(self.dynamicType)" + "updatePosition")
        value += velocity;
    }
}
