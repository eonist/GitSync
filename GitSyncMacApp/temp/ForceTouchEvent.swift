import Cocoa
@testable import Utils
@testable import Element

class ForceTouchEvent:Event{
    static var click:String = "forceTouchButtonClick"/*Stage 1 - forceTouch click*/
    static var deepClick:String = "forceTouchButtonDeepClick"/*Stage 2 - forceTouch click*/
    static var pressureChange:String = "forceTouchButtonPressureChangek"/*Stage 2 - forceTouch click*/
    
    weak var event:NSEvent?
    init(_ type:String = "", _ origin:AnyObject,_ event:NSEvent){
        self.event = event
        super.init(type, origin)
    }
    var pressure:CGFloat {
        return event!.pressure.cgFloat
    }
}

//event.stage

//maybe create stageChange event ¯\_(ツ)_/¯

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
