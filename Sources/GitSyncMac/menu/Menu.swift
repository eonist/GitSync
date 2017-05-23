import Cocoa
@testable import Utils
@testable import Element
/**
 * //TODO: support tray menu
 * //TODO: create the Menu class and Customize the about menu, and remove the others, then add the missing items
 */
class Menu {
    init(){
        while(NSApp.mainMenu!.items.count > 1){
            NSApp.mainMenu!.removeItem(at: NSApp.mainMenu!.items.count-1)
        }
        /*NSApp.mainMenu!.addMenuItem(FileMenu())
         NSApp.mainMenu!.addMenuItem(EditMenu())*/
        _ = NSApp.mainMenu!.addMenuItem(ViewMenu())
        /*NSApp.mainMenu!.addMenuItem(ToolsMenu())
         NSApp.mainMenu!.addMenuItem(WindowMenu())*/
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
        _ = appMenuItem
        /*
         Swift.print("appMenuItem?.submenu?.itemAtIndex(0): " + "\(appMenuItem?.submenu?.itemAtIndex(0))")
         Swift.print("appMenuItem?.submenu?.itemAtIndex(2): " + "\(appMenuItem?.submenu?.itemAtIndex(2))")
         Swift.print("appMenuItem?.submenu?.itemAtIndex(2).title: " + "\(appMenuItem?.submenu?.itemAtIndex(2)!.title)")
         */
        //appMenuItem?.submenu?.removeItemAtIndex(0)//remove the old aboutMenuItem
        //let aboutMenuItem = appMenuItem?.submenu?.addMenuItem(NSMenuItem())
        //aboutMenuItem?.title = "About"
        
        /*let prefsMenuItem = appMenuItem?.submenu?.addMenuItem(NSMenuItem())
         prefsMenuItem?.title = "Prefs"*/
        //Swift.print("appMenuItem?.submenu?.itemWithTitle(CustomAboutMenu.preferences): " + "\(appMenuItem?.submenu?.itemWithTitle(CustomAboutMenu.preferences))")
        
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
class ViewMenu:CustomMenuItem {
    init(){
        super.init("View", "")
        submenu = NSMenu(title: "View")
        //submenu!.addMenuItem(ShowRulerMenuItem())
        _ = submenu!.addMenuItem(ShowSideBarMenuItem())
        //submenu!.addMenuItem(CustomMenuItem("Fullscreen",""))
    }
    override func onSelect(event sender: AnyObject){
        Swift.print("ViewMenu.onSelect() " + "\(sender)")
    }
    required init(coder decoder: NSCoder) {fatalError("init(coder:) has not been implemented")}
}
class ShowSideBarMenuItem:CustomMenuItem{
    static var isSideMenuHidden:Bool = false
    init() {super.init("Show side bar", "l")}
    
    override func onSelect(event:AnyObject) {
        Swift.print("ShowGridMenuItem.onSelect()")
        //Proxy.page!.gridLayer!.hidden = !Proxy.page!.gridLayer!.hidden
    }
    /**
     * Return true if you want to enable the menu item, false will disable it
     */
    override func validateMenuItem(_ menuItem: NSMenuItem) -> Bool {
        self.title = ShowSideBarMenuItem.isSideMenuHidden ? "Show side bar" : "Hide side bar"
        ShowSideBarMenuItem.isSideMenuHidden = !ShowSideBarMenuItem.isSideMenuHidden//toggle
        Swift.print("validateMenuItem")
        return true
    }
    required init(coder decoder: NSCoder) {fatalError("init(coder:) has not been implemented")}
    
}
