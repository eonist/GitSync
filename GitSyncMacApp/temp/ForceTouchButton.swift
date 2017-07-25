import Cocoa
@testable import Utils
@testable import Element
/**
 * NOTE: Use ButtonEvent.down to listen for mouseDown events
 * NOTE: pressure just return 0 - 2 and then use min max to get stage 1 and stage 2 pressures, you can add this via extensions 👌
 * NOTE: stage 1 pressure 0-1
 * NOTE: stage 2 pressure 0-1
 */
class ForceTouchButton:Button {
    var prevState = 0
    override func pressureChange(with event: NSEvent) {
        let curState:Int = event.stage
        if event.pressureBehavior == NSPressureBehavior.primaryDeepClick {
            if prevState != curState {
                if curState == 0 {
                    if prevState == 1 {
                        super.onEvent(ForceTouchEvent(ForceTouchEvent.clickUp,self,event))
                    }
                }else if curState == 1 {
                    if prevState == 0 {
                        super.onEvent(ForceTouchEvent(ForceTouchEvent.clickDown,self,event))
                    }else if prevState == 2{
                        super.onEvent(ForceTouchEvent(ForceTouchEvent.deepClickUp,self,event))
                    }
                }else if curState == 2{
                    if prevState == 1{
                        super.onEvent(ForceTouchEvent(ForceTouchEvent.deepClickDown,self,event))
                    }
                }
                prevState = curState
            }
            super.onEvent(ForceTouchEvent(ForceTouchEvent.pressureChange,self,event))
        }
        
    }
    override func getClassType() -> String {
        return "\(Button.self)"
    }
}
