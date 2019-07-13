import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
   @IBOutlet weak var window: NSWindow!
   /**
    * Creates the view
    */
   lazy var mainView: MainView = createMainView()
   func applicationDidFinishLaunching(_ aNotification: Notification) {
      _ = mainView
   }
}
