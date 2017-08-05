import Cocoa
@testable import Utils
@testable import Element

class ToggleSideBarMenuItem:CustomMenuItem{
    init() {super.init("Show side bar", "m")}
    override func onSelect(event:AnyObject) {
        Swift.print("ShowSideBarMenuItem.onSelect()")
        let toggle = !StyleTestView.shared.leftBar.isLeftBarHidden
        StyleTestView.shared.toggleSideBar(hide: toggle)/*hiding logic*/
    }
    /**
     * Return true if you want to enable the menu item, false will disable it
     */
    override func validateMenuItem(_ menuItem:NSMenuItem) -> Bool {
        self.title = StyleTestView.shared.leftBar.isLeftBarHidden ? "Show side bar" : "Hide side bar"
        Swift.print("validateMenuItem")
        return true
    }
    required init(coder decoder: NSCoder) {fatalError("init(coder:) has not been implemented")}
}
