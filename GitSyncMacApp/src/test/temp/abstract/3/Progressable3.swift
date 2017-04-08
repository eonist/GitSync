import Cocoa
@testable import Utils
@testable import Element

protocol Progressable3:Containable3{
    var progress:CGFloat {get}
    var interval:CGFloat {get}
    //setProgress
    func setProgress(_ progress:CGFloat)
    var dir:Dir {get}
}

extension Progressable3{
    func setProgress(_ value:CGFloat,_ dir:Dir){
        contentContainer!.point[dir] = value
    }
    func setProgress(_ point:CGPoint){
        contentContainer!.point = point
    }
}
