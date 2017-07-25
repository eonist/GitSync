import Cocoa
@testable import Utils
@testable import Element

class ForceTouchButton {
    /**
     * NOTE: Use ButtonEvent.down to listen for mouseDown events
     * NOTE: pressure just return 0 - 2 and then use min max to get stage 1 and stage 2 pressures, you can add this via extensions 👌
     * NOTE: stage 1 pressure 0-1
     * NOTE: stage 2 pressure 0-1
     */
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
    class ForceTouchButton:Button{
        var prevState = 0
        override func pressureChange(with event: NSEvent) {
            let curState:Int = event.stage
            if event.pressureBehavior == NSPressureBehavior.primaryDeepClick {
                if prevState != curState {
                    if curState == 1 {
                        super.onEvent(ForceTouchButtonEvent(ForceTouchButtonEvent.click,self,event))
                    }else if curState == 2{
                        super.onEvent(ForceTouchButtonEvent(ForceTouchButtonEvent.deepClick,self,event))
                    }
                    prevState = curState
                }
                super.onEvent(ForceTouchButtonEvent(ForceTouchButtonEvent.pressureChange,self,event))
            }
            
        }
        override func getClassType() -> String {
            return "\(Button.self)"
        }
    }
}
