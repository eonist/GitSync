import Cocoa
@testable import Utils
@testable import Element
/**
 * EventHandlers
 */
extension PrefsView{
    /**
     * When darkmode check button is clicked
     */
    func onDarkThemeCheck(){
        guard let darkMode:CheckBoxButton = self.element(Key.darkMode) else {fatalError("darkModeBtn not available")}
        PrefsView.prefs.darkMode = darkMode.getChecked()
        StyleManager.reset()
        let themeStr:String = darkMode.getChecked() ? "dark.css" : "light.css"
        StyleManager.addStylesByURL("~/Desktop/ElCapitan/styletest/" + themeStr,true)
        if let win:NSWindow = WinParser.focusedWindow(), let styleTestWin:NSWindow = win as? StyleTestWin, let styleTestView = styleTestWin.contentView as? StyleTestView{
            Swift.print("refreshSkin init")
            ElementModifier.refreshSkin(styleTestView)
            Swift.print("refreshSkin completed")
        }
    }
}
/**
 * Parsing
 */
extension PrefsView{
    static var prefs:PrefsData = {
        return PrefsData.prefsData//basically this is read 1 time and then reused aka not regenerated everytime its called
    }()
    /**
     * Applies prefsData to the PrefsView
     */
    func setPrefs(_ prefs:PrefsData){
        self.apply([Key.login,TextInput.Key.inputText],prefs.login)
        let passStr = KeyChainParser.password("GitSyncApp") ?? ""
        self.apply([Key.pass,TextInput.Key.inputText],passStr)
        self.apply([Key.local,TextInput.Key.inputText],prefs.local)
        self.apply(["darkModeGroup",Key.darkMode],prefs.darkMode)
        self.apply([Section.Key.group,Key.notification],prefs.notification)
    }
}
