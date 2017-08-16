import Cocoa
@testable import Utils
@testable import Element

class ViewMenu:CustomMenuItem {
    init(){
        super.init("View", "")
        submenu = NSMenu(title: "View")
        _ = submenu?.addMenuItem(ToggleSideBarMenuItem())
        _ = submenu?.addMenuItem(PagesMenu())
        _ = submenu?.addMenuItem(ExportReposMenu("Export repos", "e"))
        _ = submenu?.addMenuItem(ImportReposMenu("Import repos", "i"))  
    }
    override func onSelect(event sender: AnyObject){
        Swift.print("ViewMenu.onSelect() " + "\(sender)")
    }
    required init(coder decoder:NSCoder) {fatalError("init(coder:) has not been implemented")}
}
class ExportReposMenu:CustomMenuItem{
    override func onSelect(event: AnyObject) {
        //grab the xml
        let xml = RepoView.treeDP.tree.xml
        //prompt the file viewer
        let dialog:NSSavePanel = NSSavePanel.initialize(["xml"], "Export repos", true)
        dialog.directoryURL = "~/Desktop/".tildePath.url
        let respons = dialog.runModal()
        
        if let url = dialog.url,respons == NSApplication.ModalResponse.OK{/*Make sure that a path was chosen*/
             _ = xml.xmlString.write(filePath:url.path.tildePath)
        }
    }
}
class ImportReposMenu:CustomMenuItem{
    override func onSelect(event: AnyObject) {
        //grab the xml
        
        //prompt the file viewer
        let dialog:NSOpenPanel = NSOpenPanel()
        dialog.directoryURL = "~/Desktop/".tildePath.url
        let respons = dialog.runModal()
        //let thePath:String? = dialog.url?.path /*Get the path to the file chosen in the NSOpenPanel*/
        
        //TODO: use two guards on the bellow instead
       
        if let url = dialog.url,respons == NSApplication.ModalResponse.OK{/*Make sure that a path was chosen*/
            if let xml = url.path.tildePath.content?.xml{
                RepoView._treeDP = TreeDP(xml)
            }
        }
    }
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
