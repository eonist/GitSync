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
    var prevStage = 0
    override func pressureChange(with event: NSEvent) {
        let curStage:Int = event.stage
        if event.pressureBehavior == NSPressureBehavior.primaryDeepClick {
            if prevStage != curStage {
                if curStage == 0 && prevStage == 1 {
                    super.onEvent(ForceTouchEvent(ForceTouchEvent.clickUp,self,event))
                }else if curStage == 1 && prevStage == 0{
                    super.onEvent(ForceTouchEvent(ForceTouchEvent.clickDown,self,event))
                }else if curStage == 1 && prevStage == 2 {
                    super.onEvent(ForceTouchEvent(ForceTouchEvent.deepClickUp,self,event))
                }else if curStage == 2 && prevStage == 1{
                    super.onEvent(ForceTouchEvent(ForceTouchEvent.deepClickDown,self,event))
                }
                super.onEvent(ForceTouchEvent(ForceTouchEvent.stageChange,self,event))
                prevStage = curStage//always set prevStage to curStage on stage change
            }
        }
        super.onEvent(ForceTouchEvent(ForceTouchEvent.pressureChange,self,event))
    }
    override func getClassType() -> String {
        return "\(Button.self)"
    }
}