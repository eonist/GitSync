import Foundation
@testable import Utils
@testable import Element

/**
 * TODO: ⚠️️ Focus now should be to render the graphics with some debug colors 👈
 * TODO: ⚠️️ Then draw the graphics to screen
 * TODO: ⚠️️ Then try to add gestures that manipulates the graph content
 * TODO: ⚠️️ Then try to anim the graph at trigger integers
 */
class GraphX:Element{
    var timeBar:TimeBarX?
    var valueBar:ValueBarX?
    var graphComponent:GraphAreaX?
    
    override func resolveSkin() {
        super.resolveSkin()
        createUI()
    }
    /**
     *
     */
    func createUI(){
        createTimeBar()
        createGraphArea()
        createValueBar()
    }
    /**
     * Creates the TimeBar
     */
    func createTimeBar(){
        timeBar = addSubView(TimeBarX(w,24,24,self))
    }
    /**
     * Creates the GraphArea
     */
    func createGraphArea(){
        let w:CGFloat = self.w - (leftMargin*2)
        let h:CGFloat = self.h - (topMargin*2)
        graphComponent = addSubView(GraphAreaX(w,h,self))
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
