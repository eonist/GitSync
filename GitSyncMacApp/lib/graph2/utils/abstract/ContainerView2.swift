import Cocoa
@testable import Utils
@testable import Element

class ContainerView2:Element,Containable2 {
    var maskSize:CGSize = CGSize()
    var contentSize:CGSize = CGSize()
    var contentContainer:Element?
    var itemSize:CGSize {fatalError("must be overriden in subClass")}//override this for custom value
    var interval:CGFloat{fatalError("must be overriden in subClass")}
    var progress:CGFloat{fatalError("must be overriden in subClass")}
    override func resolveSkin() {
        super.resolveSkin()
        contentContainer = addSubView(Container(width,height,self,"content"))
    }
}
/*extension ContainerView2:Scrollable2{
    override open func scrollWheel(with event: NSEvent) {
        Swift.print("ContainerView2.scrollWheel")
        scroll(event)
        super.scrollWheel(with: event)
    }
}
extension ContainerView2{
    func onScrollWheelEnter(){/*fatalError("must be overriden")*/}
    func onScrollWheelExit(){/*fatalError("must be overriden")*/}
    func onScrollWheelChange(_ event:NSEvent){/*fatalError("must be overriden")*/}
}
*/
