import Foundation

class PrefsView:Element {
    var keychainUserNameTextinput:TextInput?
    var gitConfigUserNameTextinput:TextInput?
    var gitEmailNameTextinput:TextInput?
    var uiSoundsCheckBoxButton:CheckBoxButton?
    override func resolveSkin() {
        self.skin = SkinResolver.skin(self)
        //keychain-user-name (TextInput)
        keychainUserNameTextinput = addSubView(TextInput(width, 32, "keychain user name: ", "", self))
        //Git-Config-UserName
        gitConfigUserNameTextinput = addSubView(TextInput(width, 32, "Git Config UserName: ", "", self))
        //Git-Config-EmailName
        gitEmailNameTextinput = addSubView(TextInput(width, 32, "Git Config EmailName: ", "", self))
        //UI sounds [x]
        uiSoundsCheckBoxButton = addSubView(CheckBoxButton(width, 32, "UI sounds:", true, self))
    }
}
