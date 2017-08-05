import Cocoa
@testable import Utils
@testable import Element

class ToggleSideBarMenuItem:CustomMenuItem{
    static var isSideMenuHidden:Bool = false
    init() {super.init("Show side bar", "m")}
    
    override func onSelect(event:AnyObject) {
        Swift.print("ShowSideBarMenuItem.onSelect()")
        let hidden:Bool = !ToggleSideBarMenuItem.isSideMenuHidden
        ToggleSideBarMenuItem.isSideMenuHidden = hidden/*toggle*/
        guard let styleTestView:StyleTestView = NSApp.mainWindow?.contentView as? StyleTestView else {fatalError("not avilable")}
        styleTestView.toggleSideBar(hide: hidden)/*hiding logic*/
    }
    /**
     * Return true if you want to enable the menu item, false will disable it
     */
    override func validateMenuItem(_ menuItem:NSMenuItem) -> Bool {
        self.title = ToggleSideBarMenuItem.isSideMenuHidden ? "Show side bar" : "Hide side bar"
        Swift.print("validateMenuItem")
        return true
    }
    required init(coder decoder: NSCoder) {fatalError("init(coder:) has not been implemented")}
}
