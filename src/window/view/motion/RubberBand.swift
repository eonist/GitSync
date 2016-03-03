import Cocoa
/**
 * TODO: An idea would be to add custom easing behaviour as a argument method instead of overriding? 
 * TODO: You could even do a Selector type of scheme. If Mover.manipulation != nil then call maipulation with the value argument
 * TODO: Clean up the default values
 * NOTE: this rubberBand tween is cheating a bit. The perfect way to implement this would be to add a half circle easing curve
 */
class RubberBand:Mover{
    let epsilon:CGFloat = 0.15/*twips 20th of a pixel*/
    var result:CGFloat = 0/*output value*/ //TODO: move to mover?
    var maskRect:CGRect = CGRect(0,0,200,200)
    var itemRect:CGRect = CGRect(0,0,200,150*5)
    var hasStopped:Bool = true
    var isDirectlyManipulating:Bool = false
    var friction:CGFloat/*This value is the strength of the friction when the item is floating freely*/
    var springEasing:CGFloat
    var spring:CGFloat/*springStrength*/
    init(_ value:CGFloat = 0, _ frame:CGRect, _ velocity:CGFloat = 0, _ friction:CGFloat = 0.98, _ springEasing:CGFloat = 0.2,_ spring:CGFloat = 0.4){
        self.friction = friction
        self.springEasing = springEasing
        self.spring = spring
        super.init(value, velocity)
    }
    override func updatePosition() {
        applyBoundries()/*assert if the movement is close to stopping, if it is then stop it*/
    }
    func applyBoundries() {
        if(value > maskRect.y){applyTopBoundry()}/*the top of the item-container passed the mask-container top checkPoint*/
        else if((value + itemRect.height) < maskRect.height){applyBottomBoundry()}/*the bottom of the item-container passed the mask-container bottom checkPoint*/
        else{/*within the boundries*/
            velocity *= friction
            value += velocity
            checkForStop()
            result = value
        }
    }
    /**
     * You have to apply friction in both directions (Think of the friction as a half circle)
     */
    func applyTopBoundry(){
        //Swift.print("applyTopBoundry " + "\(velocity)")
        let distToGoal:CGFloat = value
        if(isDirectlyManipulating){
            //Swift.print("direct")
            result = CustomFriction.constraintValueWithLog(distToGoal,100)
        }else{
            velocity -= (distToGoal * spring)
            velocity *= springEasing//TODO: try to apply log10 instead of the regular easing
            value += velocity
            //Swift.print("initVel: "  + String(initVelocity) + " vel: " + String(velocity) + "value: " + String(value))
            if(NumberAsserter.isNear(value, 0, 1)){checkForStop()}
            result = value
        }
    }
    func applyBottomBoundry(){
        //Swift.print("")
        if(isDirectlyManipulating){
            let totHeight = (itemRect.height - maskRect.height)//(tot height of items - height of mask)
            let c:CGFloat = /*abs*/(totHeight + value)/*we need a posetive value to work with, 0 to 100*/
            result = -totHeight + CustomFriction.constraintValueWithLog(c,-100)
        }else{
            let dist = maskRect.height - (value + itemRect.height)/*distanceToGoal*/
            //Swift.print("dist: " + "\(dist)")
            velocity += (dist * spring)
            velocity *= springEasing
            value += velocity
            if(NumberAsserter.isNear(dist, 0, 1)){checkForStop()}/*checks if dist is near 0, with an epsilon of 1px*/
            result = value
        }
    }
    /*
     * When velocity is less than epsilon basically less than half of a twib 0.15. then set the hasStopped flag to true
     * NOTE: Basically stops listening for the onFrame event
     */
    func checkForStop() {
        //Swift.print( "\(value.toFixed(3))" + " checkForStop " + "\((lastValue).toFixed(3))")
        if(!isDirectlyManipulating && NumberAsserter.isNear(velocity, 0, epsilon)) {
            Swift.print("stop velocity: " + "\(velocity)")
            hasStopped = true
        }
    }
}
private class CustomFriction{//creates the displacement friction effect. Like you finger is slightly losing its grip
    /**
     * NOTE: the vertical limit is the point where the value almost doesnt move at all
     * NOTE: This metod also works with negative values. Just make sure that borth the value and the limit is negative.
     */
    class func constraintValueWithLog(value : CGFloat, _ limit:CGFloat) -> CGFloat {
        let multiplier = (log10(1.0 + value/limit))
        //Swift.print("multiplier: " + "\(multiplier)" + " yPosition: " + "\(yPosition)")
        return limit * multiplier
    }
    /**
     * NOTE: If you decrease the decimal variable you increase the friction effect
     */
    class func constraintValue(value : CGFloat, _ limit:CGFloat) -> CGFloat {
        let multiplier = (0.2 * (value/limit))
        return limit * multiplier
    }
}