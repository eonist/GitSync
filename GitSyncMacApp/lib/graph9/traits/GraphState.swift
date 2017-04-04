import Foundation

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
}
