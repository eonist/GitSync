import Foundation

class PrefsView:Element {
    override func resolveSkin() {
        self.skin = SkinResolver.skin(self)
        //keychain-user-name (TextInput)
        //Git-Config-UserName
        //Git-Config-EmailName
        //UI sounds [x]
    }
}
