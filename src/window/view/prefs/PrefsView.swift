import Foundation
/**
 * NOTE: this must be a view, if you wan't to be consistent between macOS and iOS
 */
class PrefsView:Element {
    static var keychainUserName:String = "John"
    static var gitConfigUserName:String = "John"
    static var gitEmailNameText:String = "user@hotmail.com"
    static var uiSoundsCheck:Bool = true
    var keychainUserNameTextinput:TextInput?
    var gitConfigUserNameTextinput:TextInput?
    var gitEmailNameTextinput:TextInput?
    var uiSoundsCheckBoxButton:CheckBoxButton?
    override func resolveSkin() {
        self.skin = SkinResolver.skin(self)
        //keychain-user-name (TextInput)
        keychainUserNameTextinput = addSubView(TextInput(width, 32, "keychain user: ", PrefsView.keychainUserName, self))
        //Git-Config-UserName
        gitConfigUserNameTextinput = addSubView(TextInput(width, 32, "Git Config User: ", PrefsView.gitConfigUserName, self))
        //Git-Config-EmailName
        gitEmailNameTextinput = addSubView(TextInput(width, 32, "Git Config Email: ", PrefsView.gitEmailNameText, self))
        //UI sounds [x]
        uiSoundsCheckBoxButton = addSubView(CheckBoxButton(width, 32, "UI sounds:", PrefsView.uiSoundsCheck, self))
    }
    override func onEvent(event: Event) {
        if(event.assert(Event.update, keychainUserNameTextinput)){
            PrefsView.keychainUserName = (event as! TextFieldEvent).stringValue
        }
    }
}
