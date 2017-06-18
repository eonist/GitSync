import Foundation

typealias Prefs = (login:String,pass:String,local:String,darkMode:Bool,_ rect:CGRect)

struct PrefsType {
    static var prefs = "prefs"
    static var login = "login"
    static var pass = "pass"
    static var local = "local"
    static var darkMode = "darkMode"
    static var width = "width"
    static var height = "height"
    static var x = "x"
    static var y = "y"
}
