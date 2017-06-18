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
    static var _prefs:Prefs? = nil
    static var prefs:Prefs = {
        if _prefs == nil {
            let xml:XML = FileParser.xml(Config.prefs.tildePath)/*Loads the xml*/
            let login = xml.firstNode(PrefsType.login)!.stringValue!
            let local = xml.firstNode(PrefsType.local)!.stringValue!
            let darkMode = xml.firstNode(PrefsType.darkMode)!.stringValue!.bool
            _prefs = (login:login,pass:"",local:local,darkMode:darkMode)
        }
        return _prefs!
    }()
    override func resolveSkin() {
        self.skin = SkinResolver.skin(self)
        UnFoldUtils.unFold(Config.app,"prefsView",self)
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
            xml.appendChild("<\(PrefsType.login)>\(PrefsView.prefs.login)</\(PrefsType.login)>".xml)
            xml.appendChild("<\(PrefsType.local)>\(PrefsView.prefs.local)</\(PrefsType.local)>".xml)
            xml.appendChild("<\(PrefsType.darkMode)>\(PrefsView.prefs.darkMode)</\(PrefsType.darkMode)>".xml)
            xml.appendChild("<\(PrefsType.width)>\(PrefsView.prefs.winW.str)</\(PrefsType.width)>".xml)
            xml.appendChild("<\(PrefsType.height)>\(PrefsView.prefs.winH.str)</\(PrefsType.height)>".xml)
            return xml
        }
    }
}
extension PrefsView{
    var login:TextInput? {return self.element(PrefsType.login)}
    var pass:TextInput? {return self.element(PrefsType.pass)}
    var local:TextInput? {return self.element(PrefsType.local)}
    var darkMode:CheckBoxButton? {return self.element(PrefsType.darkMode)}
    var winW:CGFloat {return WinParser.width(self.window!)}
    var winH:CGFloat {return WinParser.height(self.window!)}
}
struct PrefsType {
    static var prefs = "prefs"
    static var login = "login"
    static var pass = "pass"
    static var local = "local"
    static var darkMode = "darkMode"
    static var width = "width"
    static var height = "height"
    static var x = "x"
    static var y = "y"
}
