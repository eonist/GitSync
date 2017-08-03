import Cocoa
@testable import Utils
@testable import Element
/**
 * NOTE: this must be a view, if you want to be consistent between macOS and iOS
 * TODO: ⚠️️ Save the prefs in json, research how writing to json works
 * TODO: ⚠️️ make a reusable setUI,getUI method for the UnFold system
 * TODO: ⚠️️ make a reusable event handler that stores the state of the UI
 */
class PrefsView:Element {
    //TODO: ⚠️️ just use singlton instead of the bellow
    static var _prefs:Prefs? = nil
    static var prefs:Prefs = {/*Stores values in a singleton like data-container*/
        if _prefs == nil {
            let xml:XML = FileParser.xml(Config.Bundle.prefs.tildePath)/*Loads the xml*/
            let login = xml.firstNode(PrefsType.login)!.stringValue!
            let local = xml.firstNode(PrefsType.local)!.stringValue!
            let darkMode = xml.firstNode(PrefsType.darkMode)!.stringValue!.bool
            let w = xml.firstNode(PrefsType.w)!.stringValue!.cgFloat
            let h = xml.firstNode(PrefsType.h)!.stringValue!.cgFloat
            let x = xml.firstNode(PrefsType.x)!.stringValue!.cgFloat
            let y = xml.firstNode(PrefsType.y)!.stringValue!.cgFloat
            let rect:CGRect = CGRect(x,y,w,h)
            _prefs = (login:login,pass:"",local:local,darkMode:darkMode,rect:rect)
        }
        return _prefs!
    }()
    override func resolveSkin() {
        self.skin = SkinResolver.skin(self)
        UnFoldUtils.unFold(Config.Bundle.app,"prefsView",self)
        setPrefs(PrefsView.prefs)
    }
    override func onEvent(_ event:Event) {
        Swift.print("PrefsView.onEvent event.type: \(event.type)")
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
                
                StyleManager.reset()
                let themeStr:String = darkMode!.getChecked() ? "dark.css" : "light.css"
                
                StyleManager.addStylesByURL("~/Desktop/ElCapitan/styletest/" + themeStr,true)
                
                if let win:NSWindow = WinParser.focusedWindow(), let styleTestWin:NSWindow = win as? StyleTestWin, let styleTestView = styleTestWin.contentView as? StyleTestView{
                    Swift.print("refreshSkin init")
                    ElementModifier.refreshSkin(styleTestView)
                    Swift.print("refreshSkin completed")
                }
                
                
            default:
                Swift.print("no match")
                break;
            }
        }else{
            super.onEvent(event)/*forward other events*/
        }
    }
}
