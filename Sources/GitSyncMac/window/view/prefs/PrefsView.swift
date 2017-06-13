import Foundation
@testable import Utils
@testable import Element
/**
 * NOTE: this must be a view, if you want to be consistent between macOS and iOS
 */

//Continue here: 🏀
    //make the json for the UI ✅
    //improve the event handling ✅
    //github login, github pass, local-path, darkmode ✅
    //research password mode in textfield
    //research writing keychain item
    //save to xml

class PrefsView:Element {
    override func resolveSkin() {
        self.skin = SkinResolver.skin(self)
        UnFoldUtils.unFold("~/Desktop/gitsync.json","prefsView",self)
    }
    override func onEvent(_ event: Event) {
        Swift.print("PrefsView.onEvent")
        var attrib:[String:String] = [:]
        if event.type == Event.update {
            switch true{/*TextInput*/
            case event.isChildOf(login):
                attrib["login"] = login?.inputText
            case event.isChildOf(pass):
                attrib["pass"] = pass?.inputText
            case event.isChildOf(local):
                attrib["localPath"] = local?.inputText
            default:
                break;
            }
        }else if event.type == CheckEvent.check{
            switch true{/*CheckButtons*/
            case event.isChildOf(darkMode)://TODO: <---use getChecked here
                attrib["darkMode"] = darkMode?.getChecked().str
            default:
                break;
            }
        }else{
            super.onEvent(event)//forward other events
        }
        if(event.type == CheckEvent.check || event.type == Event.update){
            Swift.print("✨ Update dp with: attrib: " + "\(attrib)")
        }
    }
}
extension PrefsView{
    static var xml:XML{
        let xml:XML = "<prefs></prefs>".xml
        xml.appendChild("<login>\(login?.inputText)</login>".xml)
        xml.appendChild("<pass>\(pass?.inputText)</pass>".xml)
        xml.appendChild("<darkMode>\(String(PrefsView.uiSounds!))</darkMode>".xml)
        return xml
    }
}
extension PrefsView{
    var login:TextInput? {return self.element("login")}
    var pass:TextInput? {return self.element("pass")}
    var local:TextInput? {return self.element("local")}
    var darkMode:CheckBoxButton? {return self.element("darkMode")}
}
