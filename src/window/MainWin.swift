import Foundation

class MainWin:Window {
    static var mainView:MainView?
    var visualEffectView:TranslucencyView?//we set the to the background 
    
    required init(_ docWidth:CGFloat,_ docHeight:CGFloat){
        super.init(docWidth, docHeight)
        WinModifier.align(self, Alignment.centerCenter, Alignment.centerCenter,CGPoint(6,0))/*aligns the window to the screen*/
    }
    override func resolveSkin() {
        /*self.contentView = FlippedView(frame: NSRect(0,0,frame.width,frame.height))
        visualEffectView = TranslucencyView(frame: NSRect(0,0,frame.width,frame.height))
        self.contentView?.addSubview(visualEffectView!)*/
        
        MainWin.mainView = MainView(frame.width,frame.height,"GitSync")/*Sets the mainview of the window*/
        self.contentView = MainWin.mainView//?.addSubView(MainWin.mainView!)
    }
    required init?(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}
}