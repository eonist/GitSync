import Foundation
import Cocoa
class TempTextInput:FlippedView{
    var title = ""
    var defaultInput = ""
    init(_ width:Int = 200, _ height:Int = 30, _ title:String = "test", _ defaultInput:String = "input text") {
        self.title = title
        self.defaultInput = defaultInput
        let frame = NSRect(x: 0, y: 0, width: width, height: height)
        super.init(frame: frame)
        createContent()
    }
    /**
     * 
     */
    func createContent(){
        let nameText = NSTextField(frame: NSRect(x: 0, y: 0, width: 144, height: 24))
        nameText.stringValue = title
        nameText.editable = false
        nameText.bordered = false
        nameText.selectable = true
        self.addSubview(nameText)
        
        let spacing = 12
        let x = Int(nameText.frame.origin.x) + Int(nameText.frame.width) + spacing
        let y = Int(nameText.frame.origin.y)
        let nameInputText = NSTextField(frame: NSRect(x: x, y: y, width: 144, height: 24))
        nameInputText.stringValue = defaultInput
        nameInputText.editable = true
        nameInputText.bordered = true
        nameInputText.selectable = true
        nameInputText.focusRingType = NSFocusRingType.None
        self.addSubview(nameInputText)
    }
    /**
     * required by super class
     */
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    /**
     *
     */
    override func hitTest(aPoint: NSPoint) -> NSView? {
        Swift.print("TempTextinput: hitTest()" + "\(aPoint)")
        return super.hitTest(aPoint)
    }
}

class CustomTextField:NSTextField{
    /**
     *
     */
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
    }

    required init?(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}
}