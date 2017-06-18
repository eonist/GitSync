import Foundation

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
