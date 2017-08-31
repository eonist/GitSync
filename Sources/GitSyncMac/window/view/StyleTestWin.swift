import Cocoa
@testable import Element
@testable import Utils

class StyleTestWin:Window {
    required init(_ docWidth:CGFloat,_ docHeight:CGFloat){
        super.init(docWidth, docHeight)
        WinModifier.align(self, Alignment.centerCenter, Alignment.centerCenter,CGPoint(6,0))/*aligns the window to the screen*/
        self.minSize = CGSize(250,250)
        self.maxSize = CGSize(600,800)
    }
    override func resolveSkin() {
        let styleTestView = StyleTestView(frame.size.width,frame.size.height)/*⬅️️🚪*/
        self.contentView = styleTestView

//        Nav.setView(.main(.commit))/*⬅️️🚪*///
//        Nav.setView(.main(.commit),styleTestView:styleTestView)/*⬅️️🚪*///
//        Nav.setView(.dialog(.commit(RepoItem.dummyData, CommitMessage.dummyData)))
//        Nav.setView(.dialog(.conflict(MergeConflict.dummyData)))
//        let repoItem = RepoItem(local: "~/dev/demo",branch: "master",title: "demo",remote: "https://github.com/gitsync/demo2.git")
//        Nav.setView(.dialog(.autoInit(AutoInitConflict(repoItem),{})))
//        Nav.setView(.detail(.repo([0,1,0])))
        Nav.setView(.main(.repo))
//        Nav.setView(.main(.prefs))
    }
    required init?(coder:NSCoder) {fatalError("init(coder:) has not been implemented")}
}
