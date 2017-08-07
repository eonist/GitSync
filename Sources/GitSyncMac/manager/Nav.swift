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
        Swift.print("setView: \(viewType)")
        StyleTestView.shared.leftBar.menuContainer?.selectButton(viewType)/*Selects the correct menu icon*/
        
        switch viewType{
        case .dialog(_):
            //add View above everything
            StyleTestView.shared.currentPrompt = {
                let view = getView(viewType,StyleTestView.shared.main)
                return StyleTestView.shared.main.addSubView(view)
            }()
        case .main(_),.detail(_):
            StyleTestView.shared.currentView = {
                Swift.print()
                if let curPrompt = StyleTestView.shared.currentPrompt {curPrompt.removeFromSuperview()}/*Remove the old prompt view*/
                if let curView = StyleTestView.shared.currentView {curView.removeFromSuperview()}/*Remove the old view*/
                let view = getView(viewType,StyleTestView.shared.content)
                return StyleTestView.shared.content.addSubView(view)
            }()
        }
    }
    private static func getView(_ view:ViewType,_ parentView:Element)->Element{
        switch view{
        /*Main*/
        case .main(let viewType):/*Main*/
            switch viewType {
            case .commit:
                return CommitView(NaN,NaN,parentView)
            case .repo:
                return RepoView(NaN,NaN,parentView)//RepoView2
            case .prefs:
                return PrefsView(NaN,NaN,parentView)
            }
        /*Detail*/
        case .detail(let viewType):/*Main*/
            switch viewType {
            case .commit(let commitData):/*CommitDetail*/
                let view:CommitDetailView = CommitDetailView(NaN,NaN,parentView)
                view.setCommitData(commitData)
                return view
            //fatalError("not implemented yet")
            case .repo(let idx3d):/*RepoDetail*/
                let view:RepoDetailView = RepoDetailView(NaN,NaN,parentView)
                view.setRepoData(idx3d)
                return view
                //fatalError("not implemented yet")
            }
        /*Dialog*/
        case .dialog(let dialog):/*Dialogs*/
            _ = dialog
            switch dialog{
            case .commit(let repoItem, let commitMessage):
                let view = CommitDialogView(NaN,NaN,parentView)
                view.setData(repoItem, commitMessage)
                return view
            case .conflict(let mergeConflict):
                let view = MergeConflictView(NaN,NaN,parentView)
                view.setData(mergeConflict)
                return view
            }
        }
    }
}
