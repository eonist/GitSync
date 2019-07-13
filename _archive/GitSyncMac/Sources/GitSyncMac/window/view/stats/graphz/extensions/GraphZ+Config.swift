import Foundation
@testable import Utils

/*Config*/
extension GraphZ{
    var vCount:Int {return 7}//⚠️️ this should be calulated by measuring the width of the graphArea etc
    var maxZoom:Int {return GraphZ.config.maxZoom}
    /*Config*/
    struct Config {
        var vCount:Int/*value count*/
        var margin:CGSize
        var maxZoom:Int/*num of zoom levels. 0 = year, 1 = month, 2 = day*/
        var itemSize:CGSize
    }
    //TODO: ⚠️️ move the bellow to a regular var in GraphX, also add itemSize maybe?
    static let config:GraphZ.Config = GraphZ.Config.init(vCount: 7, margin: CGSize(50,50), maxZoom: 3, itemSize:CGSize(100,100))/*We store config in a static var so that outside classes canuse props*/
}
extension GraphZ.Config{
    var leftMargin:CGFloat {return GraphZ.config.margin.width}
    var topMargin:CGFloat {return GraphZ.config.margin.height}
}
