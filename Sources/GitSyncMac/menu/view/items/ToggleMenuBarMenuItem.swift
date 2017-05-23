import Cocoa
@testable import Utils
@testable import Element

class ToggleMenuBarMenuItem:CustomMenuItem {
    static var isMenuBarHidden:Bool = false
    init() {super.init("Show menu bar", "m")}
    
    override func onSelect(event:AnyObject) {
        Swift.print("ToggleMenuBarMenuItem.onSelect()")
        let toggle:Bool = !ToggleMenuBarMenuItem.isMenuBarHidden
        ToggleMenuBarMenuItem.isMenuBarHidden = toggle//toggle
        if let view = MainWin.mainView {
            view.toggleMenuBar(toggle)
        }
    }
    /**
     * Return true if you want to enable the menu item, false will disable it
     */
    override func validateMenuItem(_ menuItem:NSMenuItem) -> Bool {
        self.title = ShowSideBarMenuItem.isSideMenuHidden ?  "Hide menu bar" : "Show menu bar"
        Swift.print("validateMenuItem")
        return true
    }
    required init(coder decoder: NSCoder) {fatalError("init(coder:) has not been implemented")}
}
