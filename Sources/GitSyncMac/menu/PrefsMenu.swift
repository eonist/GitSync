import Cocoa
@testable import Utils
@testable import Element

class PreferencesMenuItem:CustomMenuItem{
    init() {
        super.init(CustomAboutMenu.preferences, ",")
    }
    override func onSelect(event:AnyObject) {
        Swift.print("PreferencesMenuItem.onSelect")
        //Proxy.windows.append(WinUtils.buildWin(PreferencesWin.self))/*open the prefs window*/
    }
    /**
     * Return true if you want to enable the menu item, false will disable it
     */
    override func validateMenuItem(_ menuItem:NSMenuItem) -> Bool {
        //add assertion logic here
        return true
    }
    required init(coder decoder:NSCoder) {fatalError("init(coder:) has not been implemented")}
}
