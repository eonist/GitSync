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
    /*Components*/
    var timeBar:TimeBarX?
    var valueBar:ValueBarX?
    var graphArea:GraphAreaX?
    /**/
    var leftMargin:CGFloat {return 50}
    var topMargin:CGFloat {return 50}
    var vCount:Int {return 5}
    var tCount:Int {return 7}
    
    override func resolveSkin() {
        super.resolveSkin()
        Swift.print("GraphX.resolveSkin()")
        //createUI()
    }
    /**
     * Creates the UI Components
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
        timeBar = addSubView(TimeBarX(w,24,self))
    }
    /**
     * Creates the GraphArea
     */
    func createGraphArea(){
        let w:CGFloat = self.w - (leftMargin*2)
        let h:CGFloat = self.h - (topMargin*2)
        graphArea = addSubView(GraphAreaX(w,h,self))
        graphArea!.point = CGPoint(leftMargin,topMargin)/*Manually aligned*/
    }
    /**
     * Creates the ValueBar
     */
    func createValueBar(){
        valueBar = addSubView(ValueBarX(32,height,self))
        let objSize = CGSize(42,valueBar!.h)
        let canvasSize = CGSize(w,h)
        let p = Align.alignmentPoint(objSize, canvasSize, Alignment.topLeft, Alignment.topLeft, CGPoint())/*Manually aligned*/
        valueBar!.point = p/*aligns timeBar to bottom*/
    }
}
