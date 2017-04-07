import Cocoa
@testable import Element
@testable import Utils
/*CreateContent*/
extension Graph9{
    /**
     * Creates all the UI elements
     */
    func createUI(){
        dateIndicator = addSubView(DateIndicator(NaN,NaN,self))
        createTimeBar()
        createGraphArea()
        createValueBar()
        update()
    }
    /**
     * Creates the TimeBar
     */
    func createTimeBar(){
        //TODO: move TimeDP into TimeBar?
        let dp:TimeDP = TimeDPUtils.timeDP(curTimeType,range)
        timeBar = addSubView(TimeBar(w,24,24,dp,self,nil,.hor,100))//<-TODO: use const instead of 100?
        alignTimeBar()
    }
    /**
     * Creates the GraphArea
     */
    func createGraphArea(){
        let w:CGFloat = self.w - (leftMargin*2)
        let h:CGFloat = self.h - (topMargin*2)
        graphComponent = addSubView(GraphComponent(w,h,self))
        graphComponent!.point = CGPoint(leftMargin,topMargin)
    }
    /**
     * Creates the ValueBar
     */
    func createValueBar(){
        valueBar = addSubView(ValueBar(32,height,self))
        let objSize = CGSize(42,valueBar!.h)
        let canvasSize = CGSize(w,h)
        let p = Align.alignmentPoint(objSize, canvasSize, Alignment.topLeft, Alignment.topLeft, CGPoint())
        valueBar!.point = p/*aligns timeBar to bottom*/
    }
}
