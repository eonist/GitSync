import Cocoa
@testable import Utils

class Proxy {
    /**
     * New
     */
    static var styleTestView:StyleTestView?{
        guard let win:NSWindow = WinParser.focusedWindow() ?? NSApp.windows[safe:0] else {return nil}
        return win.contentView as? StyleTestView
    }
}
