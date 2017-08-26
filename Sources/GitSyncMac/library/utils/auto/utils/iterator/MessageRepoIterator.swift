import Foundation
@testable import Utils

class MessageRepoIterator:ArrayIterator<RepoItem> {
    typealias Completed = ()->Void
    var complete:Completed
    init(array: Array<T>,onComplete:@escaping Completed) {
        self.complete = onComplete
        super.init(array: array)
    }
    /**
     * New
     */
    func iterate(){
        if hasNext() {
            let repoItem:RepoItem = next()
            if let commitMessage:CommitMessage = CommitMessageUtils.generateCommitMessage(repoItem.local) {/*if no commit msg is generated, then no commit is needed*/
                Nav.setView(.dialog(.commit(repoItem,commitMessage,{self.iterate()})))/*this view eventually calls initCommit*/
            }else {
                MergeUtils.manualMerge(repoItem){/*nothing to commit but  check if remote has updates*/
                    self.iterate()/*nothing to commit, iterate*/
                }
            }
        }else{/*aka completed manual-message-repos*/
            complete()
        }
    }
    
}
extension MessageRepoIterator{
    var isEmpty:Bool {return self.collection.isEmpty}
}


//
