import Cocoa
@testable import Utils
@testable import Element

class ViewMenu:CustomMenuItem {
    init(){
        super.init("View", "")
        submenu = NSMenu(title: "View")
        //submenu!.addMenuItem(ShowRulerMenuItem())
        _ = submenu?.addMenuItem(ToggleSideBarMenuItem())
        _ = submenu?.addMenuItem(PagesMenu())
        //_ = submenu?.addMenuItem(ToggleMenuBarMenuItem())
        //submenu!.addMenuItem(CustomMenuItem("Fullscreen",""))
    }
    override func onSelect(event sender: AnyObject){
        Swift.print("ViewMenu.onSelect() " + "\(sender)")
    }
    required init(coder decoder:NSCoder) {fatalError("init(coder:) has not been implemented")}
}

class PagesMenu:CustomMenuItem{
    init(){
        super.init("Pages", "")
        submenu = NSMenu(title: "Pages")
        //_ = submenu?.addMenuItem(ToggleSideBarMenuItem())
        //_ = submenu?.addMenuItem(ToggleMenuBarMenuItem())
        let log = submenu?.addMenuItem(CustomMenuItem( "Log", "L", #selector(self.onSelect)))
        //let repos = submenu?.addMenuItem(NSMenuItem("Repos","R"))
        //let settings = submenu?.addMenuItem(NSMenuItem("Settings","S"))
    }
    override func onSelect(event sender: AnyObject){
        Swift.print("PagesMenu.onSelect() " + "\(sender)")
    }
    required init(coder decoder:NSCoder) {fatalError("init(coder:) has not been implemented")}
}
