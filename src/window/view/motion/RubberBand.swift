import Cocoa
/**
 *
 */
class RubberBand:Mover{
    var maskRect:CGRect = CGRect(0,0,200,200)
    var itemRect:CGRect = CGRect(0,0,200,150*5)
    var frictionStrength:CGFloat = 0.98/*This value is the strength of the friction*/
    var hasStopped:Bool = true
    var isDirectlyManipulating:Bool = false
    var result:CGFloat = 0
    init(_ target:NSView, _ value:CGFloat, _ velocity:CGFloat = 0, _ frictionStrength:CGFloat = 0.98){
        self.frictionStrength = frictionStrength
        super.init(target, value, velocity)
    }
    override func updatePosition() {
        Swift.print("updatePosition()")
        //applyFriction()/*apply friction for every frame called*/
        applyBoundries()/*assert if the movement is close to stopping, if it is then stop it*/
        result = value
    }
    //var velocityX:CGFloat = 0
    let springFriction:CGFloat = 0.50;
    let epsilon:CGFloat = 0.15/*twips 20th of a pixel*/
    var spring:CGFloat = 0.1
    func applyBoundries() {
        if(value > maskRect.y){/*the top of the item-container passed the mask-container top checkPoint*/
            //Swift.print("")
            if(isDirectlyManipulating){
                //dont do anything here
                //result = CustomFriction.logConstraintValueForYPoisition(value,200)
            }else{
                let dist = -value/*distanceToGoal*/
                velocity += (dist * spring)
                velocity *= springFriction
                value += velocity
                if(NumberAsserter.isNear(dist, 0, 1)){checkForStop()}
            }
        }else if((value + itemRect.height) < maskRect.height){/*the bottom of the item-container passed the mask-container bottom checkPoint*/
            //Swift.print("")
            if(isDirectlyManipulating){
                //dont do anything here
            }else{
                let dist = maskRect.height - (value + itemRect.height)/*distanceToGoal*/
                velocity += (dist * spring)
                velocity *= springFriction
                value += velocity
                if(NumberAsserter.isNear(dist, 0, 1)){checkForStop()}
            }
        }else{/*within the boundries*/
            velocity *= frictionStrength
            super.updatePosition()
            checkForStop()
        }
    }
    /**
     *
     */
    func applyTopBoundry(){
        
    }
    
    /*
     * When velocity is less than epsilon basically less than half of a twib 0.15. then set the hasStopped flag to true
     * NOTE: Basically stops listening for the onFrame event
     */
    func checkForStop() {
        //Swift.print( "\(value.toFixed(3))" + " checkForStop " + "\((lastValue).toFixed(3))")
        if(!isDirectlyManipulating && NumberAsserter.isNear(velocity, 0, 0.15)) {
            Swift.print("stop velocity: " + "\(velocity)")
            hasStopped = true
        }
    }
}
//
private class CustomFriction{
    /**
     * NOTE: the vertical limit is the point where the value almost doesnt move at all.
     */
    class func logConstraintValueForYPoisition(yPosition : CGFloat, _ verticalLimit:CGFloat) -> CGFloat {
        return verticalLimit * (log10(1.0 + yPosition/verticalLimit))
    }


}