import Foundation
@testable import Utils
@testable import Element

extension Graph9 {/*Convenience*/
    typealias GraphConfig = (valueBarCount:Int,timeBarCount:Int,margin:CGSize,maxZoom:Int)
    static var config:GraphConfig = (5,7,CGSize(50,50),3)
    var leftMargin:CGFloat {return Graph9.config.margin.width}
    var topMargin:CGFloat {return Graph9.config.margin.height}
    var vCount:Int {return Graph9.config.valueBarCount}
    var tCount:Int {return Graph9.config.timeBarCount}
    var maxZoom:Int {return Graph9.config.maxZoom}
}
