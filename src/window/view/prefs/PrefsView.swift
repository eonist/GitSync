import Foundation

class PrefsView:Element {
    var keychainUserName:TextInput?
    var gitConfigUserName:TextInput?
    var gitEmailName:TextInput?
    override func resolveSkin() {
        self.skin = SkinResolver.skin(self)
        //keychain-user-name (TextInput)
        keychainUserName = addSubView(TextInput(width, 32, "keychain user name: ", "", self))
        //Git-Config-UserName
        gitConfigUserName = addSubView(TextInput(width, 32, "Git Config UserName: ", "", self))
        //Git-Config-EmailName
        gitEmailName = addSubView(TextInput(width, 32, "Git Config EmailName: ", "", self))
        //UI sounds [x]
    }
}
