import Foundation
@testable import Utils
@testable import Element

class IterimScrollGroup{
    var iterimScrollX:InterimScroll
    var iterimScrollY:InterimScroll
    init(){
        self.iterimScrollX = InterimScroll()
        self.iterimScrollY = InterimScroll()
    }
    var prevScrollingDelta:CGFloat {
        get{fatalError("get not supported")}
        set{iterimScrollX.prevScrollingDelta = newValue;iterimScrollY.prevScrollingDelta = newValue}
    }
    var velocities:[CGPoint]{
        get{return zip(iterimScrollX.velocities,iterimScrollY.velocities).map{CGPoint($0.0,$0.1)}}
        set{iterimScrollX.velocities = newValue.map{$0.x};iterimScrollY.velocities = newValue.map{$0.y}}
    }
    func iterimScroll(_ dir:Dir) -> InterimScroll{
        return dir == .hor ? iterimScrollX : iterimScrollY
    }
}
