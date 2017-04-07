import Foundation
@testable import Utils
@testable import Element

class MoverGroup{
    var xMover:RubberBand
    var yMover:RubberBand
    init(_ setProgress: _ maskSize:CGSize,_ contentSize:CGSize){
        self.xMover = RubberBand(Animation.sharedInstance,{val in self.setProgress(val,.hor)}/*👈important*/,(0,maskSize.width),(0,contentSize.width))
        self.yMover = RubberBand(Animation.sharedInstance,{val in self.setProgress(val,.ver)}/*👈important*/,(0,maskSize.height),(0,contentSize.height))
    }
    var hasStopped:Bool{
        get{fatalError("get is not supported")}
        set{
            xMover.hasStopped = newValue
            yMover.hasStopped = newValue
        }
    }
    var isDirectlyManipulating:Bool{
        get{fatalError("get is not supported")}
        set{
            xMover.isDirectlyManipulating = newValue
            yMover.isDirectlyManipulating = newValue
        }
    }
    var value:CGPoint{
        get{return CGPoint(xMover.value,yMover.value)}
        set{
            xMover.value = newValue.x
            yMover.value = newValue.y
        }
    }
    var result:CGPoint{
        get{return CGPoint(xMover.result,yMover.result)}
        set{
            xMover.result = newValue.x
            yMover.result = newValue.y
        }
    }
    var velocity:CGPoint{
        get{fatalError("get is not supported")}
        set{
            xMover.velocity = newValue.x
            yMover.velocity = newValue.y
        }
    }
    func start(){
        xMover.start()
        yMover.start()
    }
    func stop(){
        xMover.stop()
        yMover.stop()
    }
    func updatePosition(){
        xMover.updatePosition()
        yMover.updatePosition()
    }
}
