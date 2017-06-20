import Cocoa
@testable import Utils
@testable import Element
/**
 * TODO: Maybe make mainView into a lazy static prop similar to RepoView
 */
class StyleTestView:CustomView{
    var main:Section?
    static var content:Section?
    static var currentView:Element?
    static var leftbar:LeftSideBar?
    
    override func resolveSkin(){
        Swift.print("StyleTestView")
        
        super.resolveSkin()
        main = self.addSubView(Section(NaN,NaN,self,"main"))
        
        StyleTestView.leftbar = main!.addSubView(LeftSideBar(NaN,NaN,main,"leftBar"))
        StyleTestView.content = main!.addSubView(Section(NaN,NaN,main,"content"))
        Nav.setView(Views2.dialog(.commit))/*⬅️️🚪*/
        //Nav.setView(.repoDetail([0,0,0]))
    }
    /**
     * NOTE: gets calls from Window.didResize
     */
    override func setSize(_ width:CGFloat,_ height:CGFloat){
        super.setSize(width, height)
        //Swift.print("StyleTestView.setSize w:\(width) h:\(height)")
        ElementModifier.refreshSize(main!)
    }
    /**
     *
     */
    static func toggleSideBar(_ hide:Bool){
        Swift.print("toggleSideBar: hide: " + "\(hide)")
        //remove leftSideBar
        guard let leftBar = StyleTestView.leftbar else{fatalError("must be avilabale")}
        guard let content = StyleTestView.content else{fatalError("must be avilabale")}
        if hide {
            leftBar.setSkinState("hidden")
            leftBar.setSkinState("full")
        }else {
            leftBar.setSkinState("")
            leftBar.setSkinState("")
        }
        ElementModifier.refreshSkin(leftBar)
        ElementModifier.refreshSkin(content)
        /*detailView.setSkinState(detailView.getSkinState())*/
        ElementModifier.float(leftBar)
        ElementModifier.float(content)
        //self.setSize(getWidth(),getHeight())
    }
}
