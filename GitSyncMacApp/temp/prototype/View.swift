import Cocoa
@testable import Utils
@testable import Element

class ProtoTypeView:WindowView{
    static let shared = ProtoTypeView(ProtoTypeView.WinRect.size.w,ProtoTypeView.WinRect.size.h)
    /*UI*/
    lazy var firstButton:ModalButton = self.createModalButton(1)
    lazy var secondButton:ModalButton = self.createModalButton(2)
    lazy var thirdButton:ModalButton = self.createModalButton(3)
    lazy var promptBtn:TextButton = self.createPromptButton()
    /*Animation*/
    lazy var promptBtnAnimator:Easer5<CGPoint> = Easer5<CGPoint>(AnimState.PromptButton.initial, DefaultEasing.point,self.promptButtonAnim)
    
    /*Values*/
    var modalStayMode:Bool = false/*This is set to true if modal is released above a sertion threshold (modal.y < 30) threshold*/
    var curModal:ModalButton?//the active modal
    
    override func resolveSkin(){
        StyleManager.addStyle(Styles.window)//padding-top:24px;
        super.resolveSkin()
        createUI()
        addEventHandlers()
    }
    /**
     * Create the UI
     */
    func createUI(){
        _ = firstButton
        _ = secondButton
        _ = thirdButton
        _ = promptBtn
    }
    /**
     * Adds eventHandlers to UI
     */
    func addEventHandlers(){
        promptBtn.addHandler(type:ButtonEvent.upInside,promptButtonClickHandler)
    }
    /**
     * New
     */
//    func indexOfModal(_ modal:NSView?)->Int{
//        if modal === modalBtn {
//            return 1
//        }else{
//            fatalError("add more buttons")
//        }
//    }
}

//Continue here 🏀
    //Use SF font?
    //Use ligthning svg
    //add more Modal buttons to window 
        //move forceTouch handler into a ModalButton Class
            //roll back to working mode ✅
            //move forcetouchhandler into modalbutton ✅
            //move modal animator into MOdalButton class ✅
                //figure out how ✅
            //move LeftMOuseDrag into ModalBUtton class ✅
        //refactor enum constants to support more buttons ✅
        //add svg and 
        //add correct colors
        //add a defocus mode for other buttons when clickMode on active button
    //create the fullScreenMode
    //add the pan left and right gesture handler
    //pinch out back into initial mode
    //swipe in buttons
        //swipe out buttons



