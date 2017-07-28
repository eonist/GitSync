import Cocoa
@testable import Utils
@testable import Element
/**
 * This class makes it easier to work with Buttons that has ForceTouch capabilities
 * NOTE: Use ButtonEvent.down to listen for mouseDown events etc
 */
class ForceTouchButton:Button {
    var prevStage = 0
    override func pressureChange(with event: NSEvent) {
        let curStage:Int = event.stage
        if event.pressureBehavior == NSPressureBehavior.primaryDeepClick,prevStage != curStage {
            switch (curStage,prevStage){
                case (0,1):
                    super.onEvent(ForceTouchEvent(ForceTouchEvent.clickUp,prevStage,self,event))
                case (1,0):
                    super.onEvent(ForceTouchEvent(ForceTouchEvent.clickDown,prevStage,self,event))
                case (1,2):
                    super.onEvent(ForceTouchEvent(ForceTouchEvent.deepClickUp,prevStage,self,event))
                case (2,1):
                    super.onEvent(ForceTouchEvent(ForceTouchEvent.deepClickDown,prevStage,self,event))
                default: break;//isn't possible
            }
            super.onEvent(ForceTouchEvent(ForceTouchEvent.stageChange,prevStage,self,event))
            prevStage = curStage/*always set prevStage to curStage on stage change*/
        }
        super.onEvent(ForceTouchEvent(ForceTouchEvent.pressureChange,prevStage,self,event))
    }
    override func getClassType() -> String {
        return "\(Button.self)"
    }
}
