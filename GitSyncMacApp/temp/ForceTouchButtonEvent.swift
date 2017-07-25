import Cocoa
@testable import Utils
@testable import Element

class ForceTouchButtonEvent:Event{
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

//maybe create stageChange event

//maybe create 
