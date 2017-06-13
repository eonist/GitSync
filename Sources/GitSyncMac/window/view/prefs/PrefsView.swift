import Foundation
@testable import Utils
@testable import Element
/**
 * NOTE: this must be a view, if you want to be consistent between macOS and iOS
 */

//Continue here: 🏀
    //make the json for the UI
    //improve the event handling
    //github login, github pass, local-path, darkmode
    //research password mode in textfield
    //research writing keychain item

class PrefsView:Element {
    override func resolveSkin() {
        self.skin = SkinResolver.skin(self)
        UnFoldUtils.unFold("~/Desktop/gitsync.json","prefsView",self)
    }
    override func onEvent(_ event: Event) {
        Swift.print("PrefsView.onEvent")
    }
}
extension PrefsView{
    var login:TextInput? {return self.element("login")}
    var pass:TextInput? {return self.element("pass")}
    var local:TextInput? {return self.element("local")}
    var darkMode:CheckBoxButton? {return self.element("darkMode")}
}
