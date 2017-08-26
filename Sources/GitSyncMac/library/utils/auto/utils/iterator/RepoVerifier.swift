import Foundation
@testable import Utils

class RepoVerifier:ArrayIterator<RepoItem>{
    typealias Complete = ()->Void
    let onComplete:Complete
    init(array: Array<T>, onComplete:@escaping Complete) {
        self.onComplete = onComplete
        super.init(array: array)
    }
    func iterateAll() {
        if self.hasNext() {
            let repoItem = self.next()
            self.verifyGitProject(repoItem,iterateAll)
        }else {
            self.onComplete()
        }
    }    
    /**
     * New
     * NOTE: verifies if a repo exists locally, if not a wizard initiated
     */
    private func verifyGitProject(_ repoItem:RepoItem, _ onComplete:@escaping AutoInitView.Complete){
        let conflict = AutoInitConflict.init(repoItem)
        if conflict.areRemotesEqual {//No need to init AutoInit dialog
            onComplete()
        }else{
            main.async{
                Nav.setView(.dialog(.autoInit(conflict,onComplete)))
            }
        }
    }
}
