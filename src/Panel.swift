import Foundation
import Cocoa

class Panel:NSView {
    static var leftPadding = 12
    static var rightPadding = 12
    init() {
        let x = Table.width+Panel.leftPadding
        let y = Win.topPadding
        let width = Win.width-Table.width-Panel.leftPadding-Panel.rightPadding
        let height = Win.height-Win.topPadding-EditMenu.height
        let rect:NSRect = NSRect(x:x, y: y, width: width,height:height)//view.bounds
        super.init(frame:rect)
        createContent()
    }
    /**
    *
    */
    func createContent(){
        //Name: text inputfield
        let nameText = NSTextField(frame: NSRect(x: Win.leftPadding, y: Win.topPadding, width: 100, height: 20))
        nameText.stringValue = "Name: "
        nameText.editable = false
        nameText.bordered = false
        self.addSubview(nameText)
        
        let nameInputText = NSTextField(frame: NSRect(x: Win.leftPadding, y: Win.topPadding, width: 100, height: 20))
        nameInputText.stringValue = "Name: "
        nameInputText.editable = false
        nameInputText.bordered = false
        self.addSubview(nameInputText)
        
        
        //Local Path: text input field and browse button
        //Remote path: text input field
        //Auto subscription: checkBoxButton
        //Auto broadcast: checkBoxButton
        //Active: checkBoxButton
        //Relay: checkBoxButton (early beta function for servers, always uses theirs update and forgoes the conflict resolution dialog)
        
    }
    required init?(coder: NSCoder) {//try to get rid of this
        fatalError("init(coder:) has not been implemented")
    }
    /*
    * Draws the background
    */
    override func drawRect(dirtyRect: NSRect) {
        let pathRect = NSInsetRect(self.bounds, 1, 1);
        let path = NSBezierPath(roundedRect:pathRect, xRadius:0, yRadius:0);
        path.lineWidth = 1
        NSColor.whiteColor().setFill();
        NSColor.grayColor().setStroke();
        path.fill()
        path.stroke()
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