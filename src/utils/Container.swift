import Foundation
import Cocoa

class Container:FlippedView{
    init(_ width:Int = 300, _ height:Int = 30) {
        let frame = NSRect(x: 0, y: 0, width: width, height: height)
        super.init(frame: frame) 
    }
    /*
    * Required by super class
    */
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}