import Cocoa

extension AppDelegate {
   /**
    * MainView
    * Fixme: ⚠️️ Maybe use Spatial to set frame?
    */
   func createMainView() -> MainView {
      let contentRect = window.contentRect(forFrameRect: window.frame)/*size of win sans titlebar*/
      let view: MainView = .init(frame: contentRect)
      window.contentView = view
      view.layer?.backgroundColor = NSColor.white.cgColor
      return view
   }
}
