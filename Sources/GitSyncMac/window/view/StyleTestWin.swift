import Cocoa
@testable import Element
@testable import Utils

class StyleTestWin:Window {
    
    required init(_ docWidth:CGFloat,_ docHeight:CGFloat){
        Swift.print("StyleTestWin.init")
        super.init(docWidth, docHeight)
        WinModifier.align(self, Alignment.centerCenter, Alignment.centerCenter,CGPoint(6,0))/*aligns the window to the screen*/
        self.minSize = CGSize(250,250)
        self.maxSize = CGSize(600,800)
    }
    override func resolveSkin() {
        self.contentView = StyleTestView.shared
//        Nav.setView(.main(.commit))/*⬅️️🚪*///
//        Nav.setView(.dialog(.commit(RepoItem.init(local: "user file path",branch: "master",title: "Element iOS"), CommitMessage("Fixed bug","Lots of bugs"))))
        Nav.setView(.dialog(.conflict(MergeConflict.dummyData)))

        //Nav.setView(.repoDetail([0,0,0]))
    }
    required init?(coder:NSCoder) {fatalError("init(coder:) has not been implemented")}
}
