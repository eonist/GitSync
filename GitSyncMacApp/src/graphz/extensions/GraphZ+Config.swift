import Foundation
@testable import Utils
/*Update*/
extension GraphZ{
    /**
     * Updates components in the Graph
     * NOTE: Gets it's call from the tick method in graphArea on every 100px threshold
     */
    func update(maxValue:Int) {
//        Swift.print("GraphZ.update: maxValue:\(maxValue)")
        valueBar.update(maxValue: maxValue)
    }
}

/*Config*/
extension GraphZ{
    var vCount:Int {return 7}//⚠️️ this should be calulated by measuring the width of the graphArea etc
    /*Config*/
    struct Config {
        var vCount:Int/*value count*/
        var margin:CGSize
        var zoomCount:Int/*num of zoom levels. 0 = year, 1 = month, 2 = day*/
        var itemSize:CGSize
    }
    //TODO: ⚠️️ move the bellow to a regular var in GraphX, also add itemSize maybe?
    static let config:GraphZ.Config = GraphZ.Config.init(vCount: 7, margin: CGSize(50,24), zoomCount: 3, itemSize:CGSize(100,100))/*We store config in a static var so that outside classes canuse props*/
}
extension GraphZ.Config{
    var leftMargin:CGFloat {return GraphX.config.margin.width}
    var topMargin:CGFloat {return GraphX.config.margin.height}
}
