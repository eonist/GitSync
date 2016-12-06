import Foundation
//Continue here:
    //center-align the input views (in progress)
    //add the Date Text UI Element to StatsView
    //write about the mc2/bump idea (design logo)
    //prepare 3 blog posts about FastList,ProgressIndicator,LineGraph for stylekit
    //attempt to add the switch skin functionality in a small isolated test (w/ styles from generic.css, just switching a few parms)

class MainWin:Window {
    static var mainView:MainView?
    required init(_ docWidth:CGFloat,_ docHeight:CGFloat){
        super.init(docWidth, docHeight)
        WinModifier.align(self, Alignment.centerCenter, Alignment.centerCenter,CGPoint(6,0))/*aligns the window to the screen*/
    }
    override func resolveSkin() {
        MainWin.mainView = MainView(frame.width,frame.height,"")/*Sets the mainview of the window*/
        self.contentView = MainWin.mainView!
    }
    required init?(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}
}