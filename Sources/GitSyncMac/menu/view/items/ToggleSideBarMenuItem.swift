import Cocoa
@testable import Utils
@testable import Element

class ToggleSideBarMenuItem:CustomMenuItem{
    static var isSideMenuHidden:Bool = false
    init() {super.init("Show side bar", "l")}
    
    override func onSelect(event:AnyObject) {
        Swift.print("ShowSideBarMenuItem.onSelect()")
        //add hiding logic here
        /*let toggle:Bool = !ToggleSideBarMenuItem.isSideMenuHidden
         ToggleSideBarMenuItem.isSideMenuHidden = toggle//toggle
         if let view = MainWin.mainView?.currentView as? RepositoryView {
         view.toggleSideBar(toggle)
         }*/
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
