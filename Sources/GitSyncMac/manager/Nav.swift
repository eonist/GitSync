import Cocoa
@testable import Utils
@testable import Element

class Nav {
    /**
     * Navigate between views
     * EXAMPLE: Nav.setView(.main(.prefs))
     * EXAMPLE: Nav.setView(.dialog(.commit))
     */
    static func setView(_ viewType:ViewType){
        //Navigation.activeView = view
        StyleTestView.shared.leftBar.menuContainer?.selectButton(viewType)/*Selects the correct menu icon*/
        if let curView = StyleTestView.currentView {curView.removeFromSuperview()}
        let mainView = StyleTestView.shared.content
        let view = getView(viewType,mainView/*size*/)
        StyleTestView.currentView = mainView.addSubView(view)
    }
    private static func getView(_ view:ViewType,_ mainView:Element)->Element{
        switch view{
        case .main(let viewType):/*Main*/
            switch viewType {
            case .commit:
                return CommitView(NaN,NaN,mainView)
            case .repo:
                return RepoView(NaN,NaN,mainView)//RepoView2
            case .prefs:
                return PrefsView(NaN,NaN,mainView)
            }
        case .commitDetail(let commitData):/*CommitDetail*/
             let view:CommitDetailView = CommitDetailView(NaN,NaN,mainView)
             view.setCommitData(commitData)
             return view
            //fatalError("not implemented yet")
        case .repoDetail(let idx3d):/*RepoDetail*/
             _ = idx3d
             let view:RepoDetailView = RepoDetailView(NaN,NaN,mainView)
             view.setRepoData(idx3d)
             return view
            //fatalError("not implemented yet")
        case .dialog(let dialog):/*Dialogs*/
            _ = dialog
            switch dialog{
            case .commit:
                /*if !ToggleSideBarMenuItem.isSideMenuHidden {
                    guard let styleTestView:StyleTestView = NSApp.mainWindow?.contentView as? StyleTestView else {fatalError("not avilable")}
                    styleTestView.toggleSideBar(true)/*true means hide*/
                }*/
                let view:CommitDialogView = CommitDialogView(NaN,NaN,mainView)
                return view
                //fatalError("not implemented yet")
            case .conflict:
                //return ConflictDialogView(w,h,mainView)
                fatalError("not implemented yet")
            }
        }
    }
}
