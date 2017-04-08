import Cocoa
@testable import Utils
@testable import Element

protocol Progressable3:Containable3{
    var progress:CGFloat {get}
    var interval:CGFloat {get}
    //setProgress
    func setProgress(_ progress:CGFloat,_ dir:Dir)
    var dir:Dir {get}
}

extension Progressable3{
    /**
     * ⚠️️ You might want to have one setProgress in scroll and one in slider and use protocol ambiguity to differentiate, but then you cant have this method in base like it is now
     * PARAM value: is the final y value for the lableContainer
     * PARAM: progress: 0-1
     * Moves the itemContainer.y up and down
     * TODO: Try to use a preCalculated itemsHeight, as this can be heavy to calculate for lengthy lists
     */
    func setProgress(_ progress:CGFloat){
        print("🖼️ moving lableContainer up and down progress: \(progress)")
        //Swift.print("IScrollable.setProgress() progress: \(progress)")
        
        //Swift.print("progressValue: " + "\(progressValue)")
        /*Sets the target item to correct y, according to the current scrollBar progress*/
    }
    /**
     * PARAM: progress: 0-1
     */
    func setProgress(_ progress:CGFloat,_ dir:Dir){
        let progressValue = self.contentSize[dir] < maskSize[dir] ? 0 : progress/*pins the lableContainer to the top if itemsHeight is less than height*/
        ScrollableUtils.scrollTo(self,progressValue,dir)
        //contentContainer!.point[dir] = value
    }
    /*func setProgress(_ point:CGPoint){
        setProgress(point.x,.hor)
        setProgress(point.y,.ver)
    }*/
}
