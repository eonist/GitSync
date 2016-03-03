import Foundation
/**
 * NOTE: You forward the scrollWheel events here
 */
class RBScrollController {
    var frame:CGRect/*represents the visible part of the content*/
    var itemRect:CGRect/*represents the total size of the content*/

    init(_ frame:CGRect, _ itemRect:CGRect){
        self.frame = frame
        self.itemRect = itemRect
    }
}
