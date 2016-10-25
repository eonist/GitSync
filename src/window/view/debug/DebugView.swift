import Foundation

class DebugView:TitleView{
    override init(_ width: CGFloat, _ height: CGFloat, _ parent: IElement? = nil, _ id: String? = "") {
        super.init(width, height, parent, "debugView")
    }
    override func resolveSkin() {
        Swift.print("DebugView.resolveSkin()")
        super.resolveSkin()
        
        //add ProgressIndicator
        //add a progressSlider
        //add a start button
        //add a stop button
        
    }
}