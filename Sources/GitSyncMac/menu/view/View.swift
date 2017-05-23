import Cocoa
@testable import Utils
@testable import Element

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
        //add hiding logic here
        if let view = MainWin.mainView as? RepositoryView {
            
        }
    }
    /**
     * Return true if you want to enable the menu item, false will disable it
     */
    override func validateMenuItem(_ menuItem:NSMenuItem) -> Bool {
        self.title = ShowSideBarMenuItem.isSideMenuHidden ? "Show side bar" : "Hide side bar"
        ShowSideBarMenuItem.isSideMenuHidden = !ShowSideBarMenuItem.isSideMenuHidden//toggle
        Swift.print("validateMenuItem")
        return true
    }
    required init(coder decoder: NSCoder) {fatalError("init(coder:) has not been implemented")}
}
