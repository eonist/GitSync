import Cocoa
@testable import Utils
@testable import Element
//Animation
extension GraphScrollView5{
    /**
     * Initiates the animation sequence
     * NOTE: this method can be called in quick sucession as it stops any ongoing animation before it is started
     */
    func initAnim(){
//        Swift.print("initAnim")
//        Swift.print("curPts: " + "\(curPts)")
        let minY:CGFloat = GraphZUtils.minY(pts: curPts)
//        Swift.print("minY: " + "\(minY)")
        let ratio:CGFloat = GraphScrollerHandler3.Utils.calcRatio(minY: minY, height: height)
//        Swift.print("ratio: " + "\(ratio)")
        animator.targetValue = ratio
        if animator.stopped {animator.start()}
    }
    /**
     * Interpolates between 0 and 1 while the duration of the animation
     * NOTE: ReCalc the hValue indicators (each graph range has a different max hValue etc)
     * TODO: ⚠️️ You only really need to scale .y
     */
    func interpolateVal(_ val:CGFloat){
//      Swift.print("interpolave")
        let scaledPts:[CGPoint] = GraphScrollerHandler3.Utils.calcScaledPoints(points: curPts, ratio: val, height: height)
        graphArea.updateGraph(pts: scaledPts)
    }
    var index:Int {
        let x = self.contentContainer.layer!.position.x.clip(-(contentSize.w-width), 0)//we use the x value as if elastic doesn't exist 👌
        let idx:Int = GraphZUtils.index(x: x, width: contentSize.width, totCount: graphArea.count)//get from list
        return idx
    }
}
