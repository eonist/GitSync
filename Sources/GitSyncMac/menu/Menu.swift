import Cocoa
@testable import Utils
@testable import Element
/**
 * //TODO: support tray menu
 * //TODO: create the Menu class and Customize the about menu, and remove the others, then add the missing items
 */
class Menu {
    init(){
        guard let mainMenu = NSApp.mainMenu else {fatalError("NSApp.mainMenu not accessible")}
        while(mainMenu.items.count > 1){
            mainMenu.removeItem(at: mainMenu.items.count-1)
        }
        _ = mainMenu.addMenuItem(ViewMenu())
        _ = CustomAboutMenu()
    }
}
