import Foundation
protocol IAnimatable:class {
    func onFrame()
}
class AnimatableView:CustomView,IAnimatable {
    func onFrame(){
        //Swift.print("drawSomething")
        if(rect.graphic.frame.x < 100){//animate a square 100 pixel to the right then stop the frame anim
            rect.graphic.frame.x += 1
        }else{
            CVDisplayLinkStop(displayLink);
        }
        
        CATransaction.flush()//if you dont flush your animation wont animate and you get this message: CoreAnimation: warning, deleted thread with uncommitted CATransaction; set CA_DEBUG_TRANSACTIONS=1 in environment to log backtraces.
    }
}
