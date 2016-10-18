import Foundation

class PrefsView:Element {
    var keychainUserName:TextInput?
    override func resolveSkin() {
        self.skin = SkinResolver.skin(self)
        //keychain-user-name (TextInput)
        keychainUserName = addSubView(TextInput(width, 32, "Name: ", "", self))
        //Git-Config-UserName
        //Git-Config-EmailName
        //UI sounds [x]
    }
}
