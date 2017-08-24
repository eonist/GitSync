import Cocoa
@testable import Utils
@testable import Element
/**
 * NOTE: override maskSize and contentSize in subclasses if you need customization
 */
class ContainerView2:Element,Containable2 {
    var maskSize:CGSize {return CGSize(super.skinSize.w,super.skinSize.h)}/*represents the visible part of the content *///TODO: could be ranmed to maskRect, say if you need x and y aswell
    var contentSize:CGSize {return CGSize(super.skinSize.w,super.skinSize.h)}
    var contentContainer:Element?
    /*item size is not relevant other than in*/var itemSize:CGSize {fatalError("must be overriden in subClass")}//override this for custom value
    var interval:CGFloat{return floor(contentSize.w - maskSize.w)/itemSize.width}
    var progress:CGFloat{return SliderParser.progress(contentContainer!.x, maskSize.w, contentSize.w)}
    override init(_ width: CGFloat, _ height: CGFloat, _ parent: ElementKind? = nil, _ id: String? = nil) {
        //maskSize = CGSize(width,height)
        //contentSize = CGSize(width,height)
        super.init(width, height)
    }
    override func resolveSkin() {
        super.resolveSkin()
        contentContainer = addSubView(Container(skinSize.w,skinSize.h,self,"lable"))//was content, but we want to use old css, TODO: ⚠️️ should be spelled: label
        layer!.masksToBounds = true/*Masks the children to the frame, I don't think this works, seem to work now 👍*/
    }
    required init(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}
}
extension ContainerView2:Scrollable2{
    override open func scrollWheel(with event: NSEvent) {
        //Swift.print("ContainerView2.scrollWheel")
        scroll(event)
        super.scrollWheel(with: event)
    }
}
extension ContainerView2{
    @objc func onScrollWheelEnter(){/*Swift.print("ContainerView2.must be overriden")*//*fatalError("must be overriden")*/}
    @objc func onScrollWheelExit(){/*Swift.print("ContainerView2.must be overriden")*//*fatalError("must be overriden")*/}
    @objc func onScrollWheelChange(_ event:NSEvent){/*Swift.print("ContainerView2.must be overriden")*//*fatalError("must be overriden")*/}
}
