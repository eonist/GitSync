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
    func onDarkThemeCheck() {
        guard let darkMode: CheckBoxButton = try? UnfoldParser.unfoldable(parent: self, path: ["darkModeGroup", Key.darkMode]) else { fatalError("darkModeBtn not available") }
        PrefsView.prefs.darkMode = darkMode.getChecked()
        StyleManager.reset()//clear the old styles
        let themeStr: String = darkMode.getChecked() ? "dark.css" : "light.css"
        let styleFilePath: String = Config.Bundle.styles + "styles/styletest/" + themeStr
        StyleManager.addStyle(url: styleFilePath, liveEdit: false)
        if let win: NSWindow = WinParser.focusedWindow(), let styleTestWin: NSWindow = win as? StyleTestWin, let styleTestView = styleTestWin.contentView as? StyleTestView {
            Swift.print("refreshSkin init")
            ElementModifier.refreshSkin(styleTestView)//TODO: ⚠️️ time this, does it take long?
            Swift.print("refreshSkin completed")
        }
    }
}


//you need both dark and ligth stored as cached json
//when you switch theme you use the cached json and replace the stylemanager .styles arr



/**
 * Parsing
 */
extension PrefsView {
    static var prefs: PrefsData = {
        return PrefsData.prefsData//basically this is read 1 time and then reused aka not regenerated everytime its called
    }()
    /**
     * Applies prefsData to the PrefsView
     */
    func setPrefs(_ prefs: PrefsData){
        self.apply([Key.login, TextInput.Key.inputText], prefs.login)
        let passStr = KeyChainParser.password("GitSyncApp") ?? ""
        self.apply([Key.pass, TextInput.Key.inputText], passStr)
        self.apply([Key.local, TextInput.Key.inputText], prefs.local)
        self.apply(["darkModeGroup", Key.darkMode], prefs.darkMode)
        self.apply([Section.Key.group, Key.notification], prefs.notification)
    }
}
