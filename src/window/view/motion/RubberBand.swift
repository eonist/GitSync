import Cocoa
/**
 *
 */
class RubberBand:Mover{
    var maskRect:CGRect = CGRect(0,0,200,200)
    var itemRect:CGRect = CGRect(0,0,200,450)
    var frictionStrength:CGFloat/*This value is the strength of the friction*/
    var hasStopped:Bool = true
    init(_ target:NSView, _ value:CGFloat, _ velocity:CGFloat = 0, _ frictionStrength:CGFloat = 0.98){
        self.frictionStrength = frictionStrength
        super.init(target, value, velocity)
        
    }
    override func updatePosition() {
        super.updatePosition()
        //applyFriction()/*apply friction for every frame called*/
        checkBoundries()/*assert if the movement is close to stopping, if it is then stop it*/
        checkForStop()
    }
    /**
     *
     */
    func checkBoundries(){
        if(itemRect.y > maskRect.y){
            Swift.print("the top of the item-container passed the mask-container top checkPoint")
            
            //apply log10 friction here
            
        }
        
        Swift.print("a: " + "\((itemRect.y + itemRect.height))")
        
        
        if((itemRect.y + itemRect.height) < maskRect.height ){
            Swift.print("the bottom of the item-container passed the mask-container bottom checkPoint")
            
            //apply log10 friction here
            
            
        }
    }
    /*
     * When velocity is less than epsilon basically less than half of a twib 0.15. then set the hasStopped flag to true
     * NOTE: Basically stops listening for the onFrame event
     */
    func checkForStop() {
        //Swift.print( "\(value.toFixed(3))" + " checkForStop " + "\((lastValue).toFixed(3))")
        if(velocity < 0.15) {
            Swift.print("stop")
            hasStopped = true
        }
    }
}
