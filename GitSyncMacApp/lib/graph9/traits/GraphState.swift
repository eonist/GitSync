import Foundation
import GitSyncMac
@testable import Utils
@testable import Element

extension Graph9 {
    var hasZoomChanged:Bool{
        let hasZoomChanged:Bool = prevZoom != nil && prevZoom != curZoom
        prevZoom = curZoom
        return hasZoomChanged
    }
    var hasPanningChanged:Bool {
        let hasPanningChanged:Bool = prevRange != nil && prevRange != curRange
        prevRange = curRange
        return hasPanningChanged
    }
    var curTimeType:TimeType {return TimeType(rawValue: curZoom)! }
    var prevTimeType:TimeType {return TimeType(rawValue: curZoom)! }
    var curRange:Range<Int> {return timeBar!.visibleItemRange}
}
