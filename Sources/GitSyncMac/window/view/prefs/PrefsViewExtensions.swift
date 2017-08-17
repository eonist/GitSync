import Cocoa
@testable import Utils
@testable import Element

extension PrefsView{
    /**
     * New
     */
    func setPrefs(_ prefs:Prefs){
        login?.setInputText(prefs.login)
        let passStr = KeyChainParser.password("GitSyncApp") ?? ""
        pass?.setInputText(passStr)
        local?.textInput.setInputText(prefs.local)
        darkMode?.setChecked(prefs.darkMode)
    }
    static var xml:XML{
        get{
            let xml:XML = "<prefs></prefs>".xml
            xml.appendChild("<\(PrefsType.login)>\(PrefsView.prefs.login)</\(PrefsType.login)>".xml)
            xml.appendChild("<\(PrefsType.local)>\(PrefsView.prefs.local)</\(PrefsType.local)>".xml)
            xml.appendChild("<\(PrefsType.darkMode)>\(PrefsView.prefs.darkMode)</\(PrefsType.darkMode)>".xml)
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
extension PrefsView{
    var login:TextInput? {return self.element(PrefsType.login)}
    var pass:TextInput? {return self.element(PrefsType.pass)}
    var local:FilePicker? {return self.element(PrefsType.local)}
    var darkMode:CheckBoxButton? {return self.element(PrefsType.darkMode)}
    var notification:CheckBoxButton? {return self.element("notification")}
}
