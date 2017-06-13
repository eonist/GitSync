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
    /*static var keychainUserName:String?
     static var gitConfigUserName:String?
     static var gitEmailNameText:String?
     static var defaultLocalPath:String = "~/Documents/"
     static var uiSounds:Bool?
     static var darkMode:Bool = true
     static var autoSyncInterval:CGFloat = 30.0
     */
    override func resolveSkin() {
        self.skin = SkinResolver.skin(self)
        
        let xml:XML = FileParser.xml("~/Desktop/gitsyncprefs.xml".tildePath)/*Loads the xml*/
        _ = xml
        //PrefsView.gitConfigUserName = xml.firstNode("gitConfigUserName")!.stringValue
        UnFoldUtils.unFold("~/Desktop/gitsync.json","prefsView",self)
    }
    override func onEvent(_ event: Event) {
        //Swift.print("PrefsView.onEvent")
        //Continue here: use immediate to assert not origin on the bellow
    }
}
extension PrefsView{
    var login:TextInput? {return self.element("login")}
    var pass:TextInput? {return self.element("pass")}
    var local:TextInput? {return self.element("local")}
    var darkMode:CheckBoxButton? {return self.element("darkMode")}
}
extension PrefsView{
    
}
