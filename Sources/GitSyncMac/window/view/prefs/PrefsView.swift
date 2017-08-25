import Cocoa
@testable import Utils
@testable import Element
/**
 * NOTE: this must be a view, if you want to be consistent between macOS and iOS
 * TODO: ⚠️️ Save the prefs in json, research how writing to json works
 * TODO: ⚠️️ make a reusable setUI,getUI method for the UnFold system
 * TODO: ⚠️️ make a reusable event handler that stores the state of the UI
 */
class PrefsView:Element,UnFoldable,Closable {
    override func resolveSkin() {
        super.resolveSkin()//self.skin = SkinResolver.skin(self)
        Unfold.unFold(fileURL: Config.Bundle.structure, path: "prefsView", parent: self)
        setPrefs(PrefsView.prefs)
    }
    /**
     * UI events from subComponents goes here
     */
    override func onEvent(_ event:Event) {
        Swift.print("PrefsView.onEvent event.type: \(event.type)")
        if let event = event as? TextFieldEvent{
            switch true{/*TextInput*/
            case event.isChildOf(parentID:Key.login):
                PrefsView.prefs.login = event.stringValue
            case event.isChildOf(parentID:Key.pass):
                let passStr:String = event.stringValue
                Swift.print("passStr: " + "\(passStr)")
                _ = KeyChainModifier.save("GitSyncApp", passStr.dataValue)
            case event.isChildOf(parentID:Key.local):
                PrefsView.prefs.local = event.stringValue
            default:
                break;
            }
        }else if let event = event as? CheckEvent /*event.assert(.check)*/{// event.assert(.check)
            switch true{/*CheckButtons*/
            case event.isChildOf(parentID:Key.darkMode)://TODO: <---use getChecked here
                self.onDarkThemeCheck()
            case event.isChildOf(parentID:Key.notification):
//                Swift.print("checked notification")
                PrefsView.prefs.notification = event.isChecked/*store the value*/
            default:
                break;
            }
        }else{
            super.onEvent(event)/*forward other events*/
        }
    }
}
