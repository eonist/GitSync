import Foundation
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
    var keychainUserNameTextInput:TextInput?
    var gitConfigUserNameTextInput:TextInput?
    var gitEmailNameTextInput:TextInput?
    var defaultLocalPathTextInput:TextInput?
    var uiSoundsCheckBoxButton:CheckBoxButton?
    var darkModeCheckBoxButton:CheckBoxButton?
    
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
    }
    override func onEvent(event: Event) {
        Swift.print("PrefsView.onEvent")
        //Continue here: use immediate to assert not origin on the bellow
        if(event.type == Event.update && event.immediate === keychainUserNameTextInput){
            PrefsView.keychainUserName = (event as! TextFieldEvent).stringValue
            Swift.print("stores to keychainUserName")
        }else if(event.type == Event.update && event.immediate === gitConfigUserNameTextInput){
            PrefsView.gitConfigUserName = (event as! TextFieldEvent).stringValue
        }else if(event.type == Event.update && event.immediate === gitEmailNameTextInput){
            PrefsView.gitEmailNameText = (event as! TextFieldEvent).stringValue
        }else if(event.type == CheckEvent.check && event.immediate === uiSoundsCheckBoxButton){
            PrefsView.uiSounds = (event as! CheckEvent).isChecked
        }
    }
}