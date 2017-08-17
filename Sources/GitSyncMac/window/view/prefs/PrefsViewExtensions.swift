import Cocoa
@testable import Utils
@testable import Element
/**
 * EventHandlers
 */
extension PrefsView{
    func onDarkThemeCheck(){
        PrefsView.prefs.darkMode = darkMode!.getChecked()
        StyleManager.reset()
        let themeStr:String = darkMode!.getChecked() ? "dark.css" : "light.css"
        StyleManager.addStylesByURL("~/Desktop/ElCapitan/styletest/" + themeStr,true)
        if let win:NSWindow = WinParser.focusedWindow(), let styleTestWin:NSWindow = win as? StyleTestWin, let styleTestView = styleTestWin.contentView as? StyleTestView{
            Swift.print("refreshSkin init")
            ElementModifier.refreshSkin(styleTestView)
            Swift.print("refreshSkin completed")
        }
    }
}
/**
 * Parsing
 */
extension PrefsView{
    /**
     * New
     */
    func setPrefs(_ prefs:PrefsData){
        login?.setInputText(prefs.login)
        let passStr = KeyChainParser.password("GitSyncApp") ?? ""
        pass?.setInputText(passStr)
        local?.textInput.setInputText(prefs.local)
        darkMode?.setChecked(prefs.darkMode)
        notification?.setChecked(prefs.notification)
    }
    static var xml:XML{
        get{
            let xml:XML = "<prefs></prefs>".xml
            let prefs = PrefsView.prefs
            xml.appendChild("<\(PrefsType.login)>\(prefs.login)</\(PrefsType.login)>".xml)
            xml.appendChild("<\(PrefsType.local)>\(prefs.local)</\(PrefsType.local)>".xml)
            xml.appendChild("<\(PrefsType.darkMode)>\(prefs.darkMode)</\(PrefsType.darkMode)>".xml)
            xml.appendChild("<\(PrefsType.notification)>\(prefs.notification)</\(PrefsType.notification)>".xml)
            let winSize:CGSize = WinParser.size(WinParser.focusedWindow() ?? NSApp.windows[0])
            let pos:CGPoint = WinParser.topLeft(WinParser.focusedWindow() ?? NSApp.windows[0])
            xml.appendChild("<\(PrefsType.w)>\(winSize.w.str)</\(PrefsType.w)>".xml)
            xml.appendChild("<\(PrefsType.h)>\(winSize.h.str)</\(PrefsType.h)>".xml)
            xml.appendChild("<\(PrefsType.x)>\(pos.x.str)</\(PrefsType.x)>".xml)
            xml.appendChild("<\(PrefsType.y)>\(pos.y.str)</\(PrefsType.y)>".xml)
            return xml
        }
    }
}
/**
 * Accessors
 * TODO: ⚠️️ Use the unfold utils instead maybe?
 */
extension PrefsView{
    static var prefs:PrefsData = PrefsType.createPrefs()//basically this is read 1 time and then reused
    /*UI*/
    var login:TextInput? {return self.element(PrefsType.login)}
    var pass:TextInput? {return self.element(PrefsType.pass)}
    var local:FilePicker? {return self.element(PrefsType.local)}
    var darkMode:CheckBoxButton? {return self.element(PrefsType.darkMode)}
    var notification:CheckBoxButton? {return self.element(PrefsType.notification)}
}
