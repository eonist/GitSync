import Foundation
import Cocoa
class TempTextInput:NSView{
    var title = ""
    var defaultInput = ""
    init(_ width:Int = 200, _ height:Int = 30, _ title:String = "", _ defaultInput:String = "") {
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
        self.addSubview(nameText)
        
        let spacing = 12
        let x = Int(nameText.frame.origin.x) + Int(nameText.frame.width) + spacing
        let y = Int(nameText.frame.origin.y)
        let nameInputText = NSTextField(frame: NSRect(x: x, y: y, width: 144, height: 24))
        nameInputText.stringValue = defaultInput
        nameInputText.editable = true
        nameInputText.bordered = true
        self.addSubview(nameInputText)
    }
    /*
     * required by super class
     */
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    /*
    * This makes sure that the view draws from top left corner
    */
    override var flipped:Bool {
        get {
            return true
        }
    }
    
    
}