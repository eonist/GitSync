import Cocoa
@testable import Element
@testable import Utils

class VibrantMainWin:TranslucentWin {
    convenience init(_ w:CGFloat,_ h:CGFloat){
        self.init(contentRect:NSRect(0,0,w,h), styleMask: [.borderless,.resizable], backing:NSBackingStoreType.buffered, defer: false)
    }
}
