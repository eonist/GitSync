import Cocoa
@testable import Utils

struct PrefsType {//keys
    static var prefs = "prefs"
    static var login = "login"
    static var pass = "pass"
    static var local = "local"
    static var darkMode = "darkMode"
    static var notification = "notification"
    static var w = "width"
    static var h = "height"
    static var x = "x"
    static var y = "y"
}

extension PrefsType{
    /**
     * NOTE: this is re-generated on every call
     */
    static func createPrefs() -> PrefsData{
        let xml:XML = FileParser.xml(Config.Bundle.prefs.tildePath)/*Loads the xml*/
        let login = xml.firstNode(PrefsType.login)!.stringValue!
        let local = xml.firstNode(PrefsType.local)!.stringValue!
        let darkMode = xml.firstNode(PrefsType.darkMode)!.stringValue!.bool
        let notification = xml.firstNode(PrefsType.notification)!.stringValue!.bool
        let w = xml.firstNode(PrefsType.w)!.stringValue!.cgFloat
        let h = xml.firstNode(PrefsType.h)!.stringValue!.cgFloat
        let x:CGFloat = {//TODO: ⚠️️ refactor this when you have time
            if let xSTR:String = xml.firstNode(PrefsType.x)?.stringValue,!xSTR.isEmpty {
                return xSTR.cgFloat
            } else {
                return NaN
            }
        }()
        let y:CGFloat = {//TODO: ⚠️️ refactor this when you have time
            if let ySTR:String = xml.firstNode(PrefsType.y)?.stringValue,!ySTR.isEmpty {
                return ySTR.cgFloat
            } else {
                return NaN
            }
        }()
        let rect:CGRect = CGRect(x,y,w,h)
        return .init(login:login,pass:"",local:local,darkMode:darkMode,notification:notification,rect:rect)
    }
}
