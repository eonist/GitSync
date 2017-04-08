import Cocoa
@testable import Utils
@testable import Element

protocol Elastic3 {
    var moverGroup:MoverGroup? {get}
    var iterimScrollGroup:IterimScrollGroup? {get}
}
protocol Scrollable3:Progressable3 {
    func onScrollWheelChange(_ event:NSEvent)
    func onScrollWheelEnter()
    func onScrollWheelExit()
}
protocol Progressable3:Containable3{
    var progress:CGFloat {get}
    var interval:CGFloat {get}
    //setProgress
}

protocol Containable3{
    var maskSize:CGSize{get}
    var contentSize:CGSize{get}
    var itemSize:CGSize{get}
    var contentContainer:Element? {get}
}
