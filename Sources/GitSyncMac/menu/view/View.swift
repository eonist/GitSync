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
        
        _ = submenu?.addMenuItem(LogMenu( "Log", "L"))
        _ = submenu?.addMenuItem(RepoMenu("Repos","R"))
        _ = submenu?.addMenuItem(PrefsMenu("Prefs","S"))
    }
    override func onSelect(event sender:AnyObject){
        Swift.print("PagesMenu.onSelect() " + "\(sender)")
    }
    required init(coder decoder:NSCoder) {fatalError("init(coder:) has not been implemented")}
}

class LogMenu:CustomMenuItem{
    override func onSelect(event: AnyObject) {
        Nav.setView(Views2.main(.commit))
    }
}
class RepoMenu:CustomMenuItem{
    override func onSelect(event: AnyObject) {
        Nav.setView(Views2.main(.repo))
    }
}
class PrefsMenu:CustomMenuItem{
    override func onSelect(event: AnyObject) {
        Nav.setView(Views2.main(.prefs))
    }
}
