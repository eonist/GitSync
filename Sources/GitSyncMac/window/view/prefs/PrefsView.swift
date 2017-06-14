import Foundation
@testable import Utils
@testable import Element
/**
 * NOTE: this must be a view, if you want to be consistent between macOS and iOS
 * TODO: ⚠️️ Save the prefs in json, research how writing to json works
 * TODO: ⚠️️ make a reusable setUI,getUI method for the UnFold system
 * TODO: ⚠️️ make a reusable event handler that stores the state of the UI
 */

typealias Prefs = (login:String,pass:String,local:String,darkMode:Bool)
class PrefsView:Element {
    static var prefs:Prefs = (login:"",pass:"",local:"",darkMode:false)
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
                PrefsView.prefs.login = login!.inputText
            case event.isChildOf(pass):
                if let passStr:String = pass?.inputText {
                    Swift.print("passStr: " + "\(passStr)")
                    _ = KeyChainModifier.save("GitSyncApp", passStr.dataValue)
                }
            case event.isChildOf(local):
                PrefsView.prefs.local = local!.inputText
            default:
                break;
            }
        }else if event.type == CheckEvent.check{
            switch true{/*CheckButtons*/
            case event.isChildOf(darkMode)://TODO: <---use getChecked here
                PrefsView.prefs.darkMode = darkMode!.getChecked()
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
    func setPrefs(_ prefs:Prefs){
        login?.setInputText(prefs.login)
        let passStr = KeyChainParser.password("GitSyncApp") ?? ""
        pass?.setInputText(passStr)
        local?.setInputText(prefs.local)
        darkMode?.setChecked(prefs.darkMode)
    }
    static var xml:XML{
        get{
            let xml:XML = "<prefs></prefs>".xml
            xml.appendChild("<\(PrefsType.login.rawValue)>\(PrefsView.prefs.login)</\(PrefsType.login.rawValue)>".xml)
            xml.appendChild("<\(PrefsType.local.rawValue)>\(PrefsView.prefs.local)</\(PrefsType.local.rawValue)>".xml)
            xml.appendChild("<\(PrefsType.darkMode.rawValue)>\(PrefsView.prefs.darkMode)</\(PrefsType.darkMode.rawValue)>".xml)
            return xml
        }set{
            PrefsView.prefs.login = newValue.firstNode(PrefsType.login.rawValue)!.stringValue!
            PrefsView.prefs.local = newValue.firstNode(PrefsType.local.rawValue)!.stringValue!
            PrefsView.prefs.darkMode = newValue.firstNode(PrefsType.darkMode.rawValue)!.stringValue!.bool
        }
    }
}
extension PrefsView{
    var login:TextInput? {return self.element(PrefsType.login.rawValue)}
    var pass:TextInput? {return self.element(PrefsType.pass.rawValue)}
    var local:TextInput? {return self.element(PrefsType.local.rawValue)}
    var darkMode:CheckBoxButton? {return self.element(PrefsType.darkMode.rawValue)}
}
enum PrefsType:String {
    case login = "login"
    case pass = "pass"
    case local = "local"
    case darkMode = "darkMode"
}
