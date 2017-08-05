import Cocoa
@testable import Utils
@testable import Element

class ViewMenu:CustomMenuItem {
    init(){
        super.init("View", "")
        submenu = NSMenu(title: "View")
        _ = submenu?.addMenuItem(ToggleSideBarMenuItem())
        _ = submenu?.addMenuItem(PagesMenu())
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
        
        _ = submenu?.addMenuItem(LogMenu( "Log", "l"))
        _ = submenu?.addMenuItem(RepoMenu("Repos","r"))
        _ = submenu?.addMenuItem(PrefsMenu("Prefs","s"))
    }
    override func onSelect(event sender:AnyObject){
        Swift.print("PagesMenu.onSelect() " + "\(sender)")
    }
    required init(coder decoder:NSCoder) {fatalError("init(coder:) has not been implemented")}
}

class LogMenu:CustomMenuItem{
    override func onSelect(event: AnyObject) {
        Nav.setView(.main(.commit))
    }
}
class RepoMenu:CustomMenuItem{
    override func onSelect(event: AnyObject) {
        Nav.setView(.main(.repo))
    }
}
class PrefsMenu:CustomMenuItem{
    override func onSelect(event: AnyObject) {
        Nav.setView(.main(.prefs))
    }
}
