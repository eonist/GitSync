import Foundation

class DebugView:Element{
    override func resolveSkin() {
        Swift.print("DebugView.resolveSkin()")
        super.resolveSkin()
        
        //add ProgressIndicator
        //add a progressSlider
        //add a start button
        //add a stop button
        
    }
    required init?(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}
}