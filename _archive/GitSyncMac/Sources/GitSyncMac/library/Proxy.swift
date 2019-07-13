import Cocoa
@testable import Utils

class Proxy {
    enum ProxyError: Error {
        case windowNotAvailable
        case styleTestViewNotAvailable
    }
    /**
     * New
     */
    static var styleTestView: StyleTestView? {
        do {
            return try getStyleTestView()
        } catch let error as NSError {
            print ("Error: \(error.domain)")
            return nil
        }
    }
    /**
     * New
     */
    private static func getStyleTestView() throws -> StyleTestView {
        guard let win: NSWindow = WinParser.focusedWindow() ?? NSApp.windows[safe: 0] else { throw ProxyError.windowNotAvailable }
        guard let styleTestView = win.contentView as? StyleTestView else { throw ProxyError.styleTestViewNotAvailable }
        return styleTestView
    }
}
