import Foundation
@testable import Utils
@testable import Element
/**
 * NOTE: this must be a view, if you want to be consistent between macOS and iOS
 * TODO: ⚠️️ Save the prefs in json, research how writing to json works
 * TODO: ⚠️️ make a reusable setUI,getUI method for the UnFold system
 * TODO: ⚠️️ make a reusable event handler that stores the state of the UI
 */
enum PrefsType:String {
    case login = "login"
    case pass = "pass"
    case local = "local"
    case darkMode = "darkMode"
}
class PrefsView:Element {
    static var prefs:[String:String] = [:]
    override func resolveSkin() {
        self.skin = SkinResolver.skin(self)
        UnFoldUtils.unFold(Config.app,"prefsView",self)
        let xml:XML = FileParser.xml(Config.prefs.tildePath)/*Loads the xml*/
        PrefsView.xml = xml
        setPrefs(PrefsView.prefs)
    }
    override func onEvent(_ event:Event) {
        Swift.print("PrefsView.onEvent")
        if event.type == Event.update {
            switch true{/*TextInput*/
            case event.isChildOf(login):
                PrefsView.prefs["login"] = login?.inputText
            case event.isChildOf(pass):
                if let passStr:String = pass?.inputText {
                    Swift.print("passStr: " + "\(passStr)")
                    _ = KeyChainModifier.save("GitSyncApp", passStr.dataValue)
                }
            case event.isChildOf(local):
                PrefsView.prefs["local"] = local?.inputText
            default:
                break;
            }
        }else if event.type == CheckEvent.check{
            switch true{/*CheckButtons*/
            case event.isChildOf(darkMode)://TODO: <---use getChecked here
                PrefsView.prefs["darkMode"] = darkMode?.getChecked().str
            default:
                break;
            }
        }else{
            super.onEvent(event)/*forward other events*/
        }
    }
}
extension PrefsView{
    /**
     * New
     */
    func setPrefs(_ dict:[String:String]){
        login?.setInputText(dict["login"] ?? "")
        let passStr = KeyChainParser.password("GitSyncApp") ?? ""
        pass?.setInputText(passStr)
        local?.setInputText(dict["local"] ?? "")
        darkMode?.setChecked((dict["darkMode"] ?? "false").bool)
    }
    static var xml:XML{
        get{
            let xml:XML = "<prefs></prefs>".xml
            xml.appendChild("<login>\(PrefsView.prefs["login"] ?? "")</login>".xml)
            xml.appendChild("<local>\(PrefsView.prefs["local"] ?? "")</local>".xml)
            xml.appendChild("<darkMode>\(PrefsView.prefs["darkMode"] ?? "")</darkMode>".xml)
            return xml
        }set{
            PrefsView.prefs["login"] = newValue.firstNode("login")!.stringValue
            PrefsView.prefs["local"] = newValue.firstNode("local")!.stringValue
            PrefsView.prefs["darkMode"] = newValue.firstNode("darkMode")!.stringValue
        }
    }
}
extension PrefsView{
    var login:TextInput? {return self.element("login")}
    var pass:TextInput? {return self.element("pass")}
    var local:TextInput? {return self.element("local")}
    var darkMode:CheckBoxButton? {return self.element("darkMode")}
}
