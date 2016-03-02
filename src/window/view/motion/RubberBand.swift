import Cocoa
/**
 *
 */
class RubberBand:Mover{
    //values
    var inputVal:CGFloat = 0;/*input value*/
    var result:CGFloat = 0/*output value*/
    //props
    var maskRect:CGRect = CGRect(0,0,200,200)
    var itemRect:CGRect = CGRect(0,0,200,150*5)
    //flags
    var hasStopped:Bool = true
    var isDirectlyManipulating:Bool = false
    //Physic settings
    var frictionStrength:CGFloat = 0.98/*This value is the strength of the friction*/
    let springFriction:CGFloat = 0.50;
    let epsilon:CGFloat = 0.15/*twips 20th of a pixel*/
    var spring:CGFloat = 0.1
    init(_ target:NSView, _ value:CGFloat, _ velocity:CGFloat = 0, _ frictionStrength:CGFloat = 0.98){
        self.frictionStrength = frictionStrength
        super.init(target, value, velocity)
    }
    override func updatePosition() {
        Swift.print("updatePosition()")
        //applyFriction()/*apply friction for every frame called*/
        applyBoundries()/*assert if the movement is close to stopping, if it is then stop it*/
    }
    //var velocityX:CGFloat = 0
    
    func applyBoundries() {
        if(value > maskRect.y){/*the top of the item-container passed the mask-container top checkPoint*/
            applyTopBoundry()
        }else if((value + itemRect.height) < maskRect.height){/*the bottom of the item-container passed the mask-container bottom checkPoint*/
           applyBottomBoundry()
        }else{/*within the boundries*/
            velocity *= frictionStrength
            super.updatePosition()
            checkForStop()
            result = value
        }
    }
    func applyTopBoundry(){
        //Swift.print("")
        if(isDirectlyManipulating){
            //dont do anything here
            value = CustomFriction.logConstraintValueForYPoisition(inputVal,200)
            result = value
        }else{
            let dist = -value/*distanceToGoal*/
            velocity += (dist * spring)
            velocity *= springFriction
            value += velocity
            if(NumberAsserter.isNear(dist, 0, 1)){checkForStop()}
            result = value
        }
    }
    func applyBottomBoundry(){
        //Swift.print("")
        if(isDirectlyManipulating){
            //dont do anything here
        }else{
            let dist = maskRect.height - (value + itemRect.height)/*distanceToGoal*/
            velocity += (dist * spring)
            velocity *= springFriction
            value += velocity
            if(NumberAsserter.isNear(dist, 0, 1)){checkForStop()}
            result = value
        }
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