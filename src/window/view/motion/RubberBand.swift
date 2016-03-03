import Cocoa
/**
 * TODO: An idea would be to add custom easing behaviour as a argument method instead of overriding? 
 * TODO: You could even do a Selector type of scheme. If Mover.manipulation != nil then call maipulation with the value argument
 * TODO: Clean up the default values
 */
class RubberBand:Mover{
    //values
    var result:CGFloat = 0/*output value*/
    //props
    var maskRect:CGRect = CGRect(0,0,200,200)
    var itemRect:CGRect = CGRect(0,0,200,150*5)
    //flags
    var hasStopped:Bool = true
    var isDirectlyManipulating:Bool = false
    //Physic settings
    var freeFloatFriction:CGFloat = 0.98/*This value is the strength of the friction*/
    let springFriction:CGFloat = 0.50;
    let epsilon:CGFloat = 0.15/*twips 20th of a pixel*/
    var spring:CGFloat = 0.4
    init(_ target:NSView, _ value:CGFloat, _ velocity:CGFloat = 0, _ frictionStrength:CGFloat = 0.98){
        self.freeFloatFriction = frictionStrength
        super.init(target, value, velocity)
    }
    override func updatePosition() {
        //Swift.print("updatePosition()")
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
            velocity *= freeFloatFriction
            super.updatePosition()
            checkForStop()
            result = value
        }
    }
    /**
     * You have to apply friction in both directions (Think of the friction as a half circle)
     */
    func applyTopBoundry(){
        //Swift.print("applyTopBoundry " + "\(velocity)")
        if(isDirectlyManipulating){
            Swift.print("direct")
            result = CustomFriction.logConstraintValueForYPoisition(value,100)
        }else{
            //Swift.print("negative velocity: " + "\(velocity)" + " dist: " + "\(dist)")
            let newDist:CGFloat = -value
            let easing:CGFloat = 0.2
            let spring:CGFloat = 0.4
            //let initVelocity = velocity
            velocity += (newDist * spring)
            velocity *= easing//TODO: try to apply log10 instead of the regular easing
            
            //velocity *= springFriction
            value += velocity//200-CustomFriction.logConstraintValueForYPoisition(200-value,200)
            //Swift.print("initVel: "  + String(initVelocity) + " vel: " + String(velocity) + "value: " + String(value))
            if(NumberAsserter.isNear(value, 0, 1)){checkForStop()}
            result = value
        }
    }
    func applyBottomBoundry(){
        //Swift.print("")
        if(isDirectlyManipulating){
            result = value
        }else{
            let dist = maskRect.height - (value + itemRect.height)/*distanceToGoal*/
            velocity += (dist * spring)
            value += velocity
            velocity *= springFriction
           // value = CustomFriction.logConstraintValueForYPoisition(value,100)
            
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



private class CustomFriction{
    /**
     *
     */
    class func constrainValue(value:CGFloat,_ from:CGFloat,_ to:CGFloat){
        
        
        //let dist:CGFloat = -100
        
        //from value
        
        //to value
        
        //apply more friction the closer it gets to the "to" value
    }
    /**
     * NOTE: the vertical limit is the point where the value almost doesnt move at all.
     */
    class func logConstraintValueForYPoisition(yPosition : CGFloat, _ verticalLimit:CGFloat) -> CGFloat {
        let multiplier = (log10(1.0 + yPosition/verticalLimit))
        //Swift.print("multiplier: " + "\(multiplier)" + " yPosition: " + "\(yPosition)")
        return verticalLimit * multiplier
    }
    class func constraintValueForYPoisition(yPosition : CGFloat, _ verticalLimit:CGFloat) -> CGFloat {
        let multiplier = (0.5 * (yPosition/verticalLimit))
        return verticalLimit * multiplier
    }
}