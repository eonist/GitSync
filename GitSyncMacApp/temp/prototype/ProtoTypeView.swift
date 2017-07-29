import Cocoa
@testable import Utils
@testable import Element

class ProtoTypeView:WindowView{
//    var main:Section?
//    static var content:Section?
//    static var currentView:Element?
    
    
    override func resolveSkin(){
        Swift.print("ProtoTypeView")
        
        super.resolveSkin()
        //main = self.addSubView(Section(NaN,NaN,self,"main"))
        
    }
    
    
}
