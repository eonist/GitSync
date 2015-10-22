import Foundation
import Cocoa

class TempWin:NSWindow{
    var view:FlippedView = FlippedView(frame: NSRect(x: 0, y: 0, width: AppDelegate.width, height: AppDelegate.height))
    
    override init(contentRect: NSRect, styleMask aStyle: Int, backing bufferingType: NSBackingStoreType, `defer` flag: Bool) {
        let winRect = NSMakeRect(0, 0, NSScreen.mainScreen()!.frame.width/2, NSScreen.mainScreen()!.frame.height/2)
        
        
        
        super.init(contentRect: winRect, styleMask: NSTitledWindowMask|NSResizableWindowMask|NSMiniaturizableWindowMask|NSClosableWindowMask, backing: NSBackingStoreType.Buffered, `defer`: false)
        
        self.makeKeyAndOrderFront(nil)//moves the window to the front
        self.center()
        createContent()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    /**
    *
    */
    func createContent(){
        createButtons()
    }
    /*
    *
    */
    func createButtons(){
        let buttonX:Int = 0
        let buttonY:Int = 40//Int(window.frame.size.height)-30-20
        //print("buttonY: " + String(buttonY))
        let button = NSButton(frame: NSRect(x: buttonX, y: buttonY, width: 100, height: 30))
        //button.highlight(true)
        let buttonCell:NSButtonCell = button.cell! as! NSButtonCell
        buttonCell.bezelStyle = NSBezelStyle.SmallSquareBezelStyle//NSBezelStyle.RoundedBezelStyle
        
        view.addSubview(button)//Add button to view
        button.target = self
        button.action = "myAction:"
    }
}
