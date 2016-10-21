import Foundation
/**
 * NOTE: this must be a view, if you wan't to be consistent between macOS and iOS
 */
class PrefsView:Element {
    static var keychainUserName:String?
    static var gitConfigUserName:String?
    static var gitEmailNameText:String?
    static var defaultLocalPath:String = "~/Documents/"
    static var uiSoundsCheck:Bool?
    var keychainUserNameTextInput:TextInput?
    var gitConfigUserNameTextInput:TextInput?
    var gitEmailNameTextInput:TextInput?
    var uiSoundsCheckBoxButton:CheckBoxButton?
    var defaultLocalPathTextInput:CheckBoxButton?
    
    override func resolveSkin() {
        self.skin = SkinResolver.skin(self)
        
        let xml:XML = FileParser.xml("~/Desktop/gitsyncprefs.xml".tildePath)
        PrefsView.keychainUserName = xml.firstNode("keychainUserName")!.stringValue
        PrefsView.gitConfigUserName = xml.firstNode("gitConfigUserName")!.stringValue
        PrefsView.gitEmailNameText = xml.firstNode("gitEmailName")!.stringValue
        PrefsView.uiSoundsCheck = xml.firstNode("uiSounds")!.stringValue!.bool
        
        //keychain-user-name (TextInput)
        keychainUserNameTextInput = addSubView(TextInput(width, 32, "keychain user: ", PrefsView.keychainUserName!, self))
        //Git-Config-UserName
        gitConfigUserNameTextInput = addSubView(TextInput(width, 32, "Git Config User: ", PrefsView.gitConfigUserName!, self))
        //Git-Config-EmailName
        gitEmailNameTextInput = addSubView(TextInput(width, 32, "Git Config Email: ", PrefsView.gitEmailNameText!, self))
        //defaultLocalPath
        defaultLocalPathTextInput = addSubView(TextInput(width, 32, "Default local path: ", PrefsView.gitEmailNameText!, self))
        //UI sounds [x]
        uiSoundsCheckBoxButton = addSubView(CheckBoxButton(width, 32, "UI sounds: ", PrefsView.uiSoundsCheck!, self))
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
            PrefsView.uiSoundsCheck = (event as! CheckEvent).isChecked
        }
    }
}
