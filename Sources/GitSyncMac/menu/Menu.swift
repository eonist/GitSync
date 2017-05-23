import Cocoa
@testable import Utils
@testable import Element
/**
 * //TODO: support tray menu
 * //TODO: create the Menu class and Customize the about menu, and remove the others, then add the missing items
 */
class Menu {
    init(){
        while(NSApp.mainMenu?.items.count > 1){
            NSApp.mainMenu!.removeItem(at: NSApp.mainMenu!.items.count-1)
        }
        _ = NSApp.mainMenu!.addMenuItem(ViewMenu())
        let customAboutMenu = CustomAboutMenu()
        _ = customAboutMenu
    }
}
class CustomAboutMenu {
    static let about:String = "About"
    static let preferences:String = "Preferences…"
    static let appName:String = "GitSync"
    private var preferencesMenuItem:NSMenuItem?
    init(){
        let appMenuItem = NSApp.mainMenu!.item(at: 0)//ref to App.menu
        if(appMenuItem?.submenu?.item(withTitle: CustomAboutMenu.preferences) != nil){
            //Swift.print("prefs menu created")
            preferencesMenuItem = appMenuItem!.submenu!.item(withTitle: CustomAboutMenu.preferences)
            let index:Int = appMenuItem!.submenu!.index(of: preferencesMenuItem!)
            appMenuItem!.submenu!.removeItem(preferencesMenuItem!)
            preferencesMenuItem = PreferencesMenuItem()
            appMenuItem!.submenu!.insertItem(preferencesMenuItem!, at: index)
        }
    }
}
class PreferencesMenuItem:CustomMenuItem{
    init() {
        super.init(CustomAboutMenu.preferences, ",")
    }
    override func onSelect(event : AnyObject) {
        Swift.print("PreferencesMenuItem.onSelect")
        //Proxy.windows.append(WinUtils.buildWin(PreferencesWin.self))/*open the prefs window*/
    }
    /**
     * Return true if you want to enable the menu item, false will disable it
     */
    override func validateMenuItem(_ menuItem: NSMenuItem) -> Bool {
        //add assertion logic here
        return true
    }
    required init(coder decoder: NSCoder) {fatalError("init(coder:) has not been implemented")}
}

