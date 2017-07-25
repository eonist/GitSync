import Cocoa
@testable import Utils
@testable import Element
/**
 * PARAM: stageChange: it would be useful when chaning color of a button for instance
 */
class ForceTouchEvent:Event{
    static var clickDown:String = "forceTouchButtonClickDown"//from noStage to clickStage
    static var deepClickDown:String = "forceTouchButtonDeepClickDown"//from clickStage to deepClickStage
    static var clickUp:String = "forceTouchButtonClickUp"//from clickStage to noStage
    static var deepClickUp:String = "forceTouchButtonDeepClickUp"//from deepStage to clickStage
    /**/
    static var pressureChange:String = "forceTouchButtonPressureChange"/*Stage 2 - forceTouch click*/
    static var stageChange:String = "forceTouchButtonStageChange"
    
    weak var event:NSEvent?
    init(_ type:String = "", _ origin:AnyObject,_ event:NSEvent){
        self.event = event
        super.init(type, origin)
    }
}
extension ForceTouchEvent {
    var pressure:CGFloat {
        return event!.pressure.cgFloat
    }
    var stage:Int {
        return event!.stage
    }
    var linearPressure:CGFloat{
        
        return 0
    }
}

//maybe create something called linearPressure?
    //which calculates the entire range of the stage pressures so from stage 0 to 1 the pressure goes from 0 to 0.5 
    //and from stage 1 to 2 the lienar pressure goes from 0.5 to 1
    //this makes it easier to scale things in a linear fashion

//maybe do clickDown, clickUp, deepClickDown, deepClickUp


/*
 
if event.type == ForcTouchEvent.clickDown {//from noStage to clickStage
 
}else if event.type == ForcTouchEvent.deepClickDown {//from clickStage to deepClickStage
 
}else if event.type == ForcTouchEvent.clickUp {//from clickStage to noStage

}else if event.type == ForcTouchEvent.deepClickUp {//from deepStage to clickStage
 
}
*/
