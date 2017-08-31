import Cocoa
@testable import Utils
@testable import Element

class Nav {
    /**
     * Navigate between views
     * EXAMPLE: Nav.setView(.main(.prefs))
     * EXAMPLE: Nav.setView(.dialog(.commit))
     */
    static func setView(_ viewType:ViewType,styleTestView:StyleTestView! = nil){
//        Swift.print("setView: \(viewType)")
        guard let styleTestView = Proxy.styleTestView else {fatalError("Main window not present")}
        styleTestView.leftBar.menuContainer?.selectButton(viewType)/*Selects the correct menu icon*/
        
        switch viewType{
        case .dialog(_):
            //add View above everything
            styleTestView.currentPrompt = {
                let view = getView(viewType,styleTestView.main)
                return view
            }()
        case .main(_),.detail(_):
            styleTestView.currentView = {
                (styleTestView.currentPrompt as? Closable)?.close()/*Remove the old prompt view*/
                (styleTestView.currentView as? Closable)?.close()/*Remove the old view*/
                let view = getView(viewType,styleTestView.content)
//                Swift.print("before retVal")
                
//                Swift.print("after retVal")
                return view
            }()
//            Swift.print("after set curView")
        }
    }
    private static func getView(_ view:ViewType,_ parentView:Element)->Element{
        switch view{
        case .main(let viewType):/*Main*/
            switch viewType {
            case .commit:
                return parentView.addSubView(CommitView())
            case .repo:
                return parentView.addSubView(RepoView())//RepoView2
            case .prefs:
                return parentView.addSubView(PrefsView())
            }
        case .detail(let viewType):/*Detail*/
            switch viewType {
            case .commit(let commitData):/*CommitDetail*/
                let view:CommitDetailView = parentView.addSubView(CommitDetailView())
                view.setCommitData(commitData)/*Updates the UI elements with the selected commit item*/
                return view
            case .repo(let idx3d):/*RepoDetail*/
                RepoView.selectedListItemIndex = idx3d
                let repoItem = RepoItem.repoItem(treeDP: RepoView.treeDP, idx3d: idx3d)
                let isFolder = TreeDPAsserter.hasChildren(RepoView.treeDP, idx3d)
                let view:RepoDetailView = parentView.addSubView(RepoDetailView(isFolder:isFolder))
                view.setRepoData(repoItem:repoItem)
                return view
            }
        case .dialog(let dialog):/*Dialogs*/
            _ = dialog
            switch dialog{
            case .commit(let repoItem, let commitMessage, let onComplete):
                let view = CommitDialogView()
                parentView.addSubview(view)
                Swift.print("onComplete: " + "\(onComplete)")
                view.setData(repoItem, commitMessage, onComplete)
                return view
            case .conflict(let mergeConflict):
                let view = MergeConflictView()
                parentView.addSubview(view)
                view.setData(mergeConflict)
                return view
            case .autoInit(let autoInitConflict,let onComplete):
                let view = AutoInitView()
                parentView.addSubview(view)
                view.setData(autoInitConflict,onComplete)
                return view
            }
        }
    }
}
