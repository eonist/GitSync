import Foundation
/**
 * NOTE: this must be a view, if you wan't to be consistent between macOS and iOS
 */
class PrefsView:Element {
    var keychainUserNameTextinput:TextInput?
    var gitConfigUserNameTextinput:TextInput?
    var gitEmailNameTextinput:TextInput?
    var uiSoundsCheckBoxButton:CheckBoxButton?
    override func resolveSkin() {
        self.skin = SkinResolver.skin(self)
        //keychain-user-name (TextInput)
        keychainUserNameTextinput = addSubView(TextInput(width, 32, "keychain user: ", "", self))
        //Git-Config-UserName
        gitConfigUserNameTextinput = addSubView(TextInput(width, 32, "Git Config User: ", "", self))
        //Git-Config-EmailName
        gitEmailNameTextinput = addSubView(TextInput(width, 32, "Git Config Email: ", "", self))
        //UI sounds [x]
        uiSoundsCheckBoxButton = addSubView(CheckBoxButton(width, 32, "UI sounds:", true, self))
    }
}
