import Cocoa
@testable import Utils
@testable import Element
/**
 * NOTE: this must be a view, if you want to be consistent between macOS and iOS
 * TODO: ⚠️️ Save the prefs in json, research how writing to json works
 * TODO: ⚠️️ make a reusable setUI,getUI method for the UnFold system
 * TODO: ⚠️️ make a reusable event handler that stores the state of the UI
 */
class PrefsView:Element,Closable {
    
    override func resolveSkin() {
        self.skin = SkinResolver.skin(self)
        UnFoldUtils.unFold(Config.Bundle.app,"prefsView",self)
        setPrefs(PrefsView.prefs)
    }
    /**
     * UI events from subComponents goes here
     */
    override func onEvent(_ event:Event) {
        Swift.print("PrefsView.onEvent event.type: \(event.type)")
        if event.assert(.update){
            switch true{/*TextInput*/
            case event.isChildOf(login):
                PrefsView.prefs.login = login!.inputText
            case event.isChildOf(pass):
                if let passStr:String = pass?.inputText {
                    Swift.print("passStr: " + "\(passStr)")
                    _ = KeyChainModifier.save("GitSyncApp", passStr.dataValue)
                }
            case event.isChildOf(local):
                PrefsView.prefs.local = local!.textInput.inputText
            default:
                break;
            }
        }else if event.assert(.check){// event.assert(.check)
            switch true{/*CheckButtons*/
            case event.isChildOf(darkMode)://TODO: <---use getChecked here
                self.onDarkThemeCheck()
            case event.isChildOf(notification):
                Swift.print("checked notification")
                PrefsView.prefs.notification = notification!.getChecked()/*store the value*/
            default:
                Swift.print("no match")
                break;
            }
        }else{
            super.onEvent(event)/*forward other events*/
        }
    }
}
