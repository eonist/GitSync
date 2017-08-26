import Cocoa
@testable import Utils

struct PrefsData {
    var login:String
    var pass:String
    var local:String
    var darkMode:Bool
    var notification:Bool
    var rect:CGRect
}
extension PrefsData{
    typealias Key = PrefsView.Key
    static var xml:XML{
        /**
         * Grabs data from prefs, which is garantued to hold data regardless if PrefsView was ever created
         */
        get{
            let xml:XML = "<prefs></prefs>".xml
            let prefs = PrefsView.prefs
            xml.appendChild("<\(Key.login)>\(prefs.login)</\(Key.login)>".xml)
            xml.appendChild("<\(Key.local)>\(prefs.local)</\(Key.local)>".xml)
            xml.appendChild("<\(Key.darkMode)>\(prefs.darkMode)</\(Key.darkMode)>".xml)
            xml.appendChild("<\(Key.notification)>\(prefs.notification)</\(Key.notification)>".xml)
            let winSize:CGSize = WinParser.size(WinParser.focusedWindow() ?? NSApp.windows[0])
            let pos:CGPoint = WinParser.topLeft(WinParser.focusedWindow() ?? NSApp.windows[0])
            xml.appendChild("<\(Key.w)>\(winSize.w.str)</\(Key.w)>".xml)
            xml.appendChild("<\(Key.h)>\(winSize.h.str)</\(Key.h)>".xml)
            xml.appendChild("<\(Key.x)>\(pos.x.str)</\(Key.x)>".xml)
            xml.appendChild("<\(Key.y)>\(pos.y.str)</\(Key.y)>".xml)
            return xml
        }
    }
    /**
     * NOTE: this is re-generated on every call
     * TODO: ⚠️️ Use the unfold utils instead maybe?
     */
    static func createPrefsData() -> PrefsData{
        let xml:XML = FileParser.xml(Config.Bundle.prefsURL.tildePath)/*Loads the xml*/
        let login = xml.firstNode(Key.login)!.stringValue!
        let local = xml.firstNode(Key.local)!.stringValue!
        let darkMode = xml.firstNode(Key.darkMode)!.stringValue!.bool
        let notification = xml.firstNode(Key.notification)!.stringValue!.bool
        let w = xml.firstNode(Key.w)!.stringValue!.cgFloat
        let h = xml.firstNode(Key.h)!.stringValue!.cgFloat
        let x:CGFloat = {//TODO: ⚠️️ refactor this when you have time
            if let xSTR:String = xml.firstNode(Key.x)?.stringValue,!xSTR.isEmpty {
                return xSTR.cgFloat
            } else {
                return NaN
            }
        }()
        let y:CGFloat = {//TODO: ⚠️️ refactor this when you have time
            if let ySTR:String = xml.firstNode(Key.y)?.stringValue,!ySTR.isEmpty {
                return ySTR.cgFloat
            } else {
                return NaN
            }
        }()
        let rect:CGRect = CGRect(x,y,w,h)
        return .init(login:login,pass:"",local:local,darkMode:darkMode,notification:notification,rect:rect)
    }
}
