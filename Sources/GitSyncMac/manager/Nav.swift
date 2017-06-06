import Foundation
@testable import Utils
@testable import Element

enum Views2{
    enum Main:String{
        case commits = "commit"
        case repos = "repo"
        case prefs = "prefs"
    }
    case main(Main)
    case commitDetail([String:String])
    case repoDetail([Int])
    case dialog(Dialog)
    enum Dialog{
        case conflict
        case commit
    }
}
class Nav {
    /**
     * Navigate between views
     */
    static func setView(_ viewType:Views2){
        //Navigation.activeView = view
        guard let mainView:Element = StyleTestView.main else{fatalError("mainView is nil")}
         /*let size:CGSize = CGSize(MainView.w,MainView.h - MenuView.h)
         
         MainWin.mainView?.menuView?.selectButton(viewType)/*Selects the correct menu icon*/
         mainView.currentView = mainView.addSubView(getView(viewType,mainView,size))*/
        
        if let curView = StyleTestView.currentView {curView.removeFromSuperview()}
        let view = getView(viewType,mainView/*,size*/)
        StyleTestView.currentView = mainView.addSubView(view)
        
    }
    private static func getView(_ view:Views2,_ mainView:Element/*,_ size:CGSize*/)->Element{
        /*let w:CGFloat = size.w/*Convenience*/
         _ = w
         let h:CGFloat = size.h
         _ = h*/
        switch view{
        case .main(let viewType):/*Main*/
            switch viewType {
            case .commits:
                //return CommitsView(w,h,mainView)
                fatalError("not implemented yet")
            case .repos:
                //return RepoView(w,h,mainView)
                fatalError("not implemented yet")
            case .prefs:
                //return PrefsView(w,h,mainView)
                fatalError("not implemented yet")
            }
        case .commitDetail(let commitData):/*CommitDetail*/
            _ = commitData
            /*let view:CommitDetailView = CommitDetailView(w,h,mainView)
             view.setCommitData(commitData)
             return view*/
            fatalError("not implemented yet")
        case .repoDetail(let idx3d):/*RepoDetail*/
            _ = idx3d
            /*let view:RepoDetailView = RepoDetailView(w,h,mainView)
             view.setRepoData(idx3d)
             return view*/
            fatalError("not implemented yet")
        case .dialog(let dialog):/*Dialogs*/
            _ = dialog
            switch dialog{
            case .commit:
                fatalError("not implemented yet")
            case .conflict:
                //return ConflictDialogView(w,h,mainView)
                fatalError("not implemented yet")
            }
        }
    }
}
