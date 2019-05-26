import Cocoa
@testable import Utils
@testable import Element
/**
 * TODO: Maybe make mainView into a lazy static prop similar to RepoView
 */
class StyleTestView:CustomView{
    lazy var main:Section = createMain()
    lazy var content:Section = createContent()
    lazy var leftBar:LeftSideBar = createLeftBar()
    var currentView:Element?/*attached to content*/
    var currentPrompt:Element?/*attached to content*/
    override func resolveSkin(){
        super.resolveSkin()
        _ = main
        _ = leftBar
        _ = content
    }
    /**
     * NOTE: gets calls from Window.didResize
     */
    override func setSize(_ width:CGFloat,_ height:CGFloat){
        super.setSize(width, height)
        ElementModifier.refreshSize(self.main)
    }
}
extension StyleTestView{
    func createMain() -> Section {
        return self.addSubView(Section.init(id:"main"))
    }
    func createLeftBar() -> LeftSideBar{
        return self.main.addSubView(LeftSideBar.init(id:"leftBar"))
    }
    func createContent() -> Section {
        return self.main.addSubView(Section.init(id:"content"))
    }
}

extension StyleTestView{
    /**
     * 1. make StyleTestWin have a static view 👈
     * 2. make then you can make this method a non-static one and use regular optionals
     * 3. Then continue making the hide sidebar when dialog etc
     * TODO: ⚠️️ Move to extension
     */
    func toggleSideBar(hide:Bool){
        Swift.print("toggleSideBar: hide: " + "\(hide)")
        //remove leftSideBar
        let mainView:StyleTestView = self
        let iconSection = mainView.iconSection
        if hide {
            iconSection.skinState = "hidden"/*hides the Min,Max,Close btns*/
            leftBar.skinState = "hidden"
            content.skinState = "full"
        }else{
            iconSection.skinState = ""/*default*/
            leftBar.skinState = ""/*default*/
            content.skinState = ""/*default*/
        }
        ElementModifier.refreshSkin(leftBar)
        ElementModifier.refreshSkin(content)
        /*detailView.setSkinState(detailView.getSkinState())*/
        ElementModifier.float(leftBar)
        ElementModifier.float(content)/**/
        //self.setSize(getWidth(),getHeight())
        Swift.print("toggle completed")
    }
}
