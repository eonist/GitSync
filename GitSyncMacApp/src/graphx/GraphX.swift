import Foundation
@testable import Utils
@testable import Element

/**
 * TODO: ⚠️️ Account for next and prev point when calculating min and max 🤔 🚫 nopp transition to new state when a point enters visible view, not before
 * TODO: ⚠️️ Animate the graph in an isolated test with random data points that range modulate
 * TODO: ⚠️️ Add the range modulate code to GraphX 👈
 * TODO: ⚠️️ Range modulate only the points in the visible field. smoother anim 👌
 */
class GraphX:Element{
    /*Components*/
    lazy var timeBar:TimeBarX = TimeBarX(0,0,self)/*Creates the TimeBar*/
    lazy var valueBar:ValueBarX = ValueBarX(0,0,self)/*Creates the ValueBar*/
    lazy var graphArea:GraphAreaX = GraphAreaX(0,0,self)

    override func resolveSkin() {
        super.resolveSkin()
//        Swift.print("GraphX.resolveSkin()")
        /*Creates the UI Components*/
        addSubview(valueBar)
        addSubview(graphArea)
        addSubview(timeBar)
//        update()
    }
    /**
     * Used to set the initial state of the graph
     */
//    func update(){
//        let vValues:[CGFloat] = GraphUtils.randomVerticalValues(GraphX.config.totCount)
//        graphArea.updateGraph(vValues)
//    }
}

extension GraphX{
    /*Config*/
    struct GraphConfig {var vCount:Int,totCount:Int,margin:CGSize,maxZoom:Int }
    //TODO: ⚠️️ move the bellow to a regular var in GraphX, also add itemSize maybe?
    static var config:GraphConfig = GraphConfig.init(vCount: 7, totCount: 80, margin: CGSize(50,50), maxZoom: 3)/*We store config in a static var so that outside classes canuse props*/
    //
    var leftMargin:CGFloat {return GraphX.config.margin.width}/*We then store static vars inside local vars so that local methods can easily refer to the values with less verbosity, ehh 🤔*/
    var topMargin:CGFloat {return GraphX.config.margin.height}
    var vCount:Int {return GraphX.config.vCount}
    var tCount:Int {return GraphX.config.totCount}
   
}
