import Cocoa
@testable import Utils
@testable import Element

class CustomAboutMenu {
    static let about:String = "About"
    static let preferences:String = "Preferences…"
    static let appName:String = "GitSync"
    private var preferencesMenuItem:NSMenuItem?
    init(){
        let appMenuItem = NSApp.mainMenu!.item(at: 0)//ref to App.menu
        if(appMenuItem?.submenu?.item(withTitle:CustomAboutMenu.preferences) != nil){
            //Swift.print("prefs menu created")
            preferencesMenuItem = appMenuItem!.submenu!.item(withTitle:CustomAboutMenu.preferences)
            let index:Int = appMenuItem!.submenu!.index(of:preferencesMenuItem!)
            appMenuItem!.submenu!.removeItem(preferencesMenuItem!)
            preferencesMenuItem = PreferencesMenuItem()
            appMenuItem!.submenu!.insertItem(preferencesMenuItem!, at: index)
        }
    }
}

