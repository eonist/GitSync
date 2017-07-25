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
    static var pressureChange:String = "forceTouchButtonPressureChange"//fires all the time when pressure is applied
    static var stageChange:String = "forceTouchButtonStageChange"//fires only when tranisitoning from 1 stage to the other
    
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
    /**
     * NOTE: calculates the entire range of the stage pressures so from stage 0 to 1 the pressure goes from 0 to 0.5
     * and from stage 1 to 2 the lienar pressure goes from 0.5 to 1
     * this makes it easier to scale things in a linear fashion from 0 to 1 in the entire stage range
     */
    var linearPressure:CGFloat{
        if stage == 1{
            return pressure / 2
        }else /*if stage == 2*/ {
            return 0.5 + (pressure / 2)
        }
    }
}
