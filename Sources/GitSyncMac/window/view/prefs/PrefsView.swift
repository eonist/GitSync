import Foundation
@testable import Utils
@testable import Element
/**
 * NOTE: this must be a view, if you want to be consistent between macOS and iOS
 */
class PrefsView:Element {
    static var keychainUserName:String?
    static var gitConfigUserName:String?
    static var gitEmailNameText:String?
    static var defaultLocalPath:String = "~/Documents/"
    static var uiSounds:Bool?
    static var darkMode:Bool = true
    static var autoSyncInterval:CGFloat = 30.0
    var keychainUserNameTextInput:TextInput?
    var gitConfigUserNameTextInput:TextInput?
    var gitEmailNameTextInput:TextInput?
    var defaultLocalPathTextInput:TextInput?
    var uiSoundsCheckBoxButton:CheckBoxButton?
    var darkModeCheckBoxButton:CheckBoxButton?
    var autoSyncIntervalLeverSpinner:LeverSpinner?
    
    override func resolveSkin() {
        self.skin = SkinResolver.skin(self)
        
        let xml:XML = FileParser.xml("~/Desktop/gitsyncprefs.xml".tildePath)/*Loads the xml*/
        PrefsView.keychainUserName = xml.firstNode("keychainUserName")!.stringValue
        PrefsView.gitConfigUserName = xml.firstNode("gitConfigUserName")!.stringValue
        PrefsView.gitEmailNameText = xml.firstNode("gitEmailName")!.stringValue
        PrefsView.uiSounds = xml.firstNode("uiSounds")!.stringValue!.bool
        
        //keychain-user-name (TextInput)
        keychainUserNameTextInput = addSubView(TextInput(width, NaN, "keychain user: ", PrefsView.keychainUserName!, self))
        //Git-Config-UserName
        gitConfigUserNameTextInput = addSubView(TextInput(width, NaN, "Git Config User: ", PrefsView.gitConfigUserName!, self))
        //Git-Config-EmailName
        gitEmailNameTextInput = addSubView(TextInput(width, NaN, "Git Config Email: ", PrefsView.gitEmailNameText!, self))
        //defaultLocalPath
        defaultLocalPathTextInput = addSubView(TextInput(width, NaN, "Default local path: ", PrefsView.defaultLocalPath, self))
        //UI sounds [x]
        uiSoundsCheckBoxButton = addSubView(CheckBoxButton(width, NaN, "UI sounds: ", PrefsView.uiSounds!, self))
        //Dark mode:
        darkModeCheckBoxButton = addSubView(CheckBoxButton(width, NaN, "Dark mode: ", PrefsView.darkMode, self))
        //Auto-Sync interval:
        autoSyncIntervalLeverSpinner = addSubView(LeverSpinner(width, 32, "Sync-Interval: ", 30, 1, Int.min.cgFloat, Int.max.cgFloat, 0, 100, 200, self))//autoSyncIntervall needs to be a time setter: Day,Hour,Min,Seconds,0 means do not sync on an interval, the min setting is 30 sec, anything bellow this will be clamped to 30 sec
    }
    override func onEvent(_ event: Event) {
        //Swift.print("PrefsView.onEvent")
        //Continue here: use immediate to assert not origin on the bellow
        if(event.type == Event.update && event.immediate === keychainUserNameTextInput){
            PrefsView.keychainUserName = (event as! TextFieldEvent).stringValue
            //Swift.print("stores to keychainUserName")
        }else if(event.type == Event.update && event.immediate === gitConfigUserNameTextInput){
            PrefsView.gitConfigUserName = (event as! TextFieldEvent).stringValue
        }else if(event.type == Event.update && event.immediate === gitEmailNameTextInput){
            PrefsView.gitEmailNameText = (event as! TextFieldEvent).stringValue
        }else if(event.type == CheckEvent.check && event.immediate === uiSoundsCheckBoxButton){
            PrefsView.uiSounds = (event as! CheckEvent).isChecked
        }
    }
}
extension PrefsView{
    static var xml:XML{
        let xml:XML = "<prefs></prefs>".xml
        xml.appendChild("<keychainUserName>\(PrefsView.keychainUserName!)</keychainUserName>".xml)
        xml.appendChild("<gitConfigUserName>\(PrefsView.gitConfigUserName!)</gitConfigUserName>".xml)
        xml.appendChild("<gitEmailName>\(PrefsView.gitEmailNameText!)</gitEmailName>".xml)
        xml.appendChild("<uiSounds>\(String(PrefsView.uiSounds!))</uiSounds>".xml)
        return xml
    }
}
