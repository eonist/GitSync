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
        //Nav.setView(Views2.main(.repo))
        Nav.setView(.repoDetail([0,0]))
    }
    /**
     * NOTE: gets calls from Window.didResize
     */
    override func setSize(_ width:CGFloat,_ height:CGFloat){
        super.setSize(width, height)
        //Swift.print("StyleTestView.setSize w:\(width) h:\(height)")
        ElementModifier.refreshSize(main!)
    }
}
