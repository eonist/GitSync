import Cocoa
@testable import Utils
@testable import Element
/**
 * - NOTE: this must be a view, if you want to be consistent between macOS and iOS
 * - TODO: ⚠️️ Save the prefs in json, research how writing to json works
 * - TODO: ⚠️️ make a reusable setUI,getUI method for the UnFold system
 * - TODO: ⚠️️ make a reusable event handler that stores the state of the UI
 */
class PrefsView: Element, UnFoldable, PrefsViewClosable {
    override func resolveSkin() {
        super.resolveSkin()//self.skin = SkinResolver.skin(self)
        Unfold.unFold(fileURL: Config.Bundle.structure, path: "prefsView", parent: self)
        setPrefs(PrefsView.prefs)
    }
    /**
     * UI events from subComponents goes here
     */
    override func onEvent(_ event: Event) {
//        Swift.print("PrefsView.onEvent event.type: \(event.type)")
        switch true{
        case event.assert(Event.update, parentID: Key.login):
            PrefsView.prefs.login = (event as! TextFieldEvent).stringValue
        case event.assert(Event.update,parentID: Key.pass):
            _ = KeyChainModifier.save("GitSyncApp", (event as! TextFieldEvent).stringValue.dataValue)
        case event.assert(Event.update, parentID: Key.local):
            PrefsView.prefs.local = (event as! TextFieldEvent).stringValue
        case event.assert(CheckEvent.check, parentID: Key.darkMode):
            self.onDarkThemeCheck()
        case event.assert(CheckEvent.check, parentID: Key.notification):
            PrefsView.prefs.notification = (event as! CheckEvent).isChecked/*store the value*/
        default:
            super.onEvent(event)/*forward other events*/
            break;
        }
    }
}
