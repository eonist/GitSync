import Cocoa
@testable import Utils
@testable import Element

class StyleTestView:CustomView{
    var main:Section?
    static var content:Section?
    static var currentView:Element?
    
    
    override func resolveSkin(){
        Swift.print("StyleTestView")
        
        super.resolveSkin()
        main = self.addSubView(Section(NaN,NaN,self,"main"))
        
    }
}
