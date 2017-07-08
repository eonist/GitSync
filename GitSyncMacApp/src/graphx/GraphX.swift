import Foundation
@testable import Utils
@testable import Element

/**
 * TODO: ⚠️️ Focus now should be to render the graphics with some debug colors ✅
 * TODO: ⚠️️ Then draw the graphics to screen
 * TODO: ⚠️️ Then try to add gestures that manipulates the graph content
 * TODO: ⚠️️ Then try to anim the graph at trigger integers
 */
class GraphX:Element{
    /*Components*/
    var timeBar:TimeBarX?
    var valueBar:ValueBarX?
    var graphArea:GraphAreaX?
    /*Config*/
    typealias GraphConfig = (vCount:Int,tCount:Int,margin:CGSize,maxZoom:Int)
    static var config:GraphConfig = (5,7,CGSize(50,50),3)/*We store config in a static var so that outside classes canuse props*/
    var leftMargin:CGFloat {return GraphX.config.margin.width}/*We then store static vars inside local vars so that local methods can easily refer to the values with less verbosity*/
    var topMargin:CGFloat {return GraphX.config.margin.height}
    var vCount:Int {return GraphX.config.vCount}
    var tCount:Int {return GraphX.config.tCount}
    
    override func resolveSkin() {
        super.resolveSkin()
        Swift.print("GraphX.resolveSkin()")
        createUI()
        update()
    }
    /**
     *
     */
    func update(){
        let vValues:[CGFloat] = 
        graphArea!.updateGraph(vValues)
    }
    /**
     * Creates the UI Components
     */
    func createUI(){
        createValueBar()
        createGraphArea()
        createTimeBar()
    }
    /**
     * Creates the ValueBar
     */
    func createValueBar(){
        valueBar = addSubView(ValueBarX(NaN,NaN,self))
        //let objSize = CGSize(42,valueBar!.h)
        //let canvasSize = CGSize(w,h)
        //let p = Align.alignmentPoint(objSize, canvasSize, Alignment.topLeft, Alignment.topLeft, CGPoint())/*Manually aligned*/
        //valueBar!.point = p/*aligns timeBar to bottom*/
    }
    /**
     * Creates the GraphArea
     */
    func createGraphArea(){
        /*let w:CGFloat = self.w - (leftMargin*2)
         let h:CGFloat = self.h - (topMargin*2)*/
        graphArea = addSubView(GraphAreaX(NaN,NaN,self))
        //graphArea!.point = CGPoint(leftMargin,topMargin)/*Manually aligned*/
    }
    /**
     * Creates the TimeBar
     */
    func createTimeBar(){
        timeBar = addSubView(TimeBarX(NaN,NaN,self))
    }
}
