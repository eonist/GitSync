@testable import Utils
@testable import Element

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    @IBOutlet weak var window: NSWindow!


    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
        Swift.print(StringParser.sansSuffix("Blue"))
        
        //continue here: 
            //copy the GitSync code into the project
            //start making debug rects for testing your new fastlit theory
        
        
        StyleManager.addStyle("Button{fill:blue;}")
        let btn = Button(100,20)
        window.contentView!.addSubview(btn)
        func onClick(event:Event){
            if(event.type == ButtonEvent.upInside){Swift.print("hello world")}
        }
        btn.event = onClick
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }


}

