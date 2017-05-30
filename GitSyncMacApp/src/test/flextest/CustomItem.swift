import Foundation
@testable import Element
@testable import Utils


class CustomItem:Element,FlexBoxItemKind{
    var initRect:CGRect {return CGRect(self.frame.origin.x,self.frame.origin.y,self.w,self.h)}
    var flexible:Flexible {return self}
    var grow:CGFloat = 1
    var shrink:CGFloat = 0
    var basis:CGFloat? = nil
    var text:String
    lazy var textButton:TextButton = {
        return self.addSubView(TextButton(NaN,self.h,self.text,self,nil))
    }()
    init(_ width: CGFloat, _ height: CGFloat, _ text: String, _ grow:CGFloat = 1,_ parent: IElement?, _ id: String?) {
        self.grow = grow
        self.text = text
        super.init(width, height, parent, id)
    }
    override func resolveSkin() {
        super.resolveSkin()
        _ = textButton
    }
    override func setSize(_ width: CGFloat, _ height: CGFloat) {
        super.setSize(width, height)
        textButton.setSize(textButton.getWidth(), textButton.getHeight())
        //ElementModifier.refreshSkin(textButton)//<-- may not be needed
    }
    required init(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}
}

extension CustomItem:IPositional{
    public func setPosition(_ position:CGPoint){
        self.frame.origin = position
    }
    public func getPosition() -> CGPoint{
        return self.frame.origin
    }
}
extension CustomItem:ISizeable{
    override open var size:CGSize {get{return CGSize(width,height)} set{setSizeValue(newValue)}}
    public func setSizeValue(_ size:CGSize){
        self.setSize(size.width, size.height)
        ElementModifier.refreshSkin(self)//<-- may not be needed
    }
}
