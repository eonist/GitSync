import Cocoa
@testable import Utils

typealias Prefs = (login:String,pass:String,local:String,darkMode:Bool,rect:CGRect)

struct PrefsType {
    static var prefs = "prefs"
    static var login = "login"
    static var pass = "pass"
    static var local = "local"
    static var darkMode = "darkMode"
    static var w = "width"
    static var h = "height"
    static var x = "x"
    static var y = "y"
}

extension PrefsType{
    /**
     *
     */
    static func createPrefs() -> Prefs{/*Stores values in a singleton like data-container*/
        let xml:XML = FileParser.xml(Config.Bundle.prefs.tildePath)/*Loads the xml*/
        let login = xml.firstNode(PrefsType.login)!.stringValue!
        let local = xml.firstNode(PrefsType.local)!.stringValue!
        let darkMode = xml.firstNode(PrefsType.darkMode)!.stringValue!.bool
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
        return (login:login,pass:"",local:local,darkMode:darkMode,rect:rect)
    }
}
