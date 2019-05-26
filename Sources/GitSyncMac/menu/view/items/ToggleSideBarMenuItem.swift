import Cocoa
@testable import Utils
@testable import Element

class ToggleSideBarMenuItem:CustomMenuItem{
    init() {super.init("Show side bar", "m")}
    override func onSelect(event:AnyObject) {
        Swift.print("ShowSideBarMenuItem.onSelect()")
        guard let styleTestView = Proxy.styleTestView else {return}
        let toggle = styleTestView.leftBar.isLeftBarHidden
        styleTestView.toggleSideBar(hide: toggle)/*hiding logic*/
    }
    /**
     * Return true if you want to enable the menu item, false will disable it
     */
    override func validateMenuItem(_ menuItem:NSMenuItem) -> Bool {
        guard let styleTestView = Proxy.styleTestView else {return false}
        self.title = styleTestView.leftBar.isLeftBarHidden ? "Show side bar" : "Hide side bar"
        Swift.print("validateMenuItem")
        return true
    }
    required init(coder decoder: NSCoder) {fatalError("init(coder:) has not been implemented")}
}
