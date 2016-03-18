import Cocoa
@NSApplicationMain/*<-required by the application*/
/*
 * The class for the application
 */
class AppDelegate: NSObject, NSApplicationDelegate{
    /**
     * Initializes your application
     */
    func applicationDidFinishLaunching(aNotification: NSNotification) {
        Swift.print("applicationDidFinishLaunching")
    }
    /*
     * When the application closes
     * NOTE: Insert code here to tear down your application
     */
    func applicationWillTerminate(aNotification: NSNotification) {
        print("Good-bye")
    }
}

