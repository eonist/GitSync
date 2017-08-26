import Cocoa
@testable import Utils
@testable import Element
/**
 * EventHandlers
 */
extension PrefsView{
    /**
     * When darkmode check button is clicked
     */
    func onDarkThemeCheck(){
        guard let darkMode:CheckBoxButton = self.element(Key.darkMode) else {fatalError("darkModeBtn not available")}
        PrefsView.prefs.darkMode = darkMode.getChecked()
        StyleManager.reset()
        let themeStr:String = darkMode.getChecked() ? "dark.css" : "light.css"
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
//        Swift.print("setPrefs")
        self.apply([Key.login,TextInput.Key.inputText],prefs.login)
        let passStr = KeyChainParser.password("GitSyncApp") ?? ""
        self.apply([Key.pass,TextInput.Key.inputText],passStr)
//        Swift.print("prefs.local: " + "\(prefs.local)")
        self.apply([Key.local,TextInput.Key.inputText],prefs.local)
        self.apply(["darkModeGroup",Key.darkMode],prefs.darkMode)
//        Swift.print("prefs.notification: " + "\(prefs.notification)")
        self.apply([Section.Key.group,Key.notification],prefs.notification)
    }
    static var xml:XML{
        get{
            let xml:XML = "<prefs></prefs>".xml
            let prefs = PrefsView.prefs
            xml.appendChild("<\(Key.login)>\(prefs.login)</\(Key.login)>".xml)
            xml.appendChild("<\(Key.local)>\(prefs.local)</\(Key.local)>".xml)
            xml.appendChild("<\(Key.darkMode)>\(prefs.darkMode)</\(Key.darkMode)>".xml)
            xml.appendChild("<\(Key.notification)>\(prefs.notification)</\(Key.notification)>".xml)
            let winSize:CGSize = WinParser.size(WinParser.focusedWindow() ?? NSApp.windows[0])
            let pos:CGPoint = WinParser.topLeft(WinParser.focusedWindow() ?? NSApp.windows[0])
            xml.appendChild("<\(Key.w)>\(winSize.w.str)</\(Key.w)>".xml)
            xml.appendChild("<\(Key.h)>\(winSize.h.str)</\(Key.h)>".xml)
            xml.appendChild("<\(Key.x)>\(pos.x.str)</\(Key.x)>".xml)
            xml.appendChild("<\(Key.y)>\(pos.y.str)</\(Key.y)>".xml)
            return xml
        }
    }
}
/**
 * Accessors
 * TODO: ⚠️️ Use the unfold utils instead maybe?
 */
extension PrefsView{
    static var prefs:PrefsData = PrefsView.createPrefsData()//basically this is read 1 time and then reused, ⚠️️ I dont think it is! Since its inside an extension ⚠️️
    /**
     * NOTE: this is re-generated on every call
     */
    static func createPrefsData() -> PrefsData{
        let xml:XML = FileParser.xml(Config.Bundle.prefsURL.tildePath)/*Loads the xml*/
        let login = xml.firstNode(Key.login)!.stringValue!
        let local = xml.firstNode(Key.local)!.stringValue!
        let darkMode = xml.firstNode(Key.darkMode)!.stringValue!.bool
        let notification = xml.firstNode(Key.notification)!.stringValue!.bool
        let w = xml.firstNode(Key.w)!.stringValue!.cgFloat
        let h = xml.firstNode(Key.h)!.stringValue!.cgFloat
        let x:CGFloat = {//TODO: ⚠️️ refactor this when you have time
            if let xSTR:String = xml.firstNode(Key.x)?.stringValue,!xSTR.isEmpty {
                return xSTR.cgFloat
            } else {
                return NaN
            }
        }()
        let y:CGFloat = {//TODO: ⚠️️ refactor this when you have time
            if let ySTR:String = xml.firstNode(Key.y)?.stringValue,!ySTR.isEmpty {
                return ySTR.cgFloat
            } else {
                return NaN
            }
        }()
        let rect:CGRect = CGRect(x,y,w,h)
        return .init(login:login,pass:"",local:local,darkMode:darkMode,notification:notification,rect:rect)
    }
}

