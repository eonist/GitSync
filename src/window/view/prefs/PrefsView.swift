import Foundation
/**
 * NOTE: this must be a view, if you wan't to be consistent between macOS and iOS
 */
class PrefsView:Element {
    static var keychainUserName:String = "John"
    static var gitConfigUserName:String = "John"
    static var gitEmailNameText:String = "user@hotmail.com"
    static var uiSoundsCheck:Bool = true
    var keychainUserNameTextInput:TextInput?
    var gitConfigUserNameTextInput:TextInput?
    var gitEmailNameTextInput:TextInput?
    var uiSoundsCheckBoxButton:CheckBoxButton?
    override func resolveSkin() {
        self.skin = SkinResolver.skin(self)
        //keychain-user-name (TextInput)
        keychainUserNameTextInput = addSubView(TextInput(width, 32, "keychain user: ", PrefsView.keychainUserName, self))
        //Git-Config-UserName
        gitConfigUserNameTextInput = addSubView(TextInput(width, 32, "Git Config User: ", PrefsView.gitConfigUserName, self))
        //Git-Config-EmailName
        gitEmailNameTextInput = addSubView(TextInput(width, 32, "Git Config Email: ", PrefsView.gitEmailNameText, self))
        //UI sounds [x]
        uiSoundsCheckBoxButton = addSubView(CheckBoxButton(width, 32, "UI sounds: ", PrefsView.uiSoundsCheck, self))
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
