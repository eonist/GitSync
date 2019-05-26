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
//            Swift.print("iterator.hasNext")
            let repoItem:RepoItem = next()
//            Swift.print("repoItem: " + "\(repoItem)")
            if var commitMessage:CommitMessage = CommitMessageUtils.generateCommitMessage(repoItem.local) {/*if no commit msg is generated, then no commit is needed*/
//                Swift.print("has commit message")
                if !repoItem.template.isEmpty {commitMessage.title = repoItem.template}//add template as title if it exists
                Nav.setView(.dialog(.commit(repoItem,commitMessage,{self.iterate()})))/*this view eventually calls initCommit*/
            }else {
//                Swift.print("has no commit message")
                MergeUtils.manualMerge(repoItem){/*nothing to commit but check if remote has updates*/
//                    Swift.print("nothing to commit, iterate")
                    self.iterate()/*nothing to commit, iterate*/
                }
            }
        }else{/*aka completed manual-message-repos*/
//            Swift.print("interator.complete")
            complete()
        }
    }
    
}
extension MessageRepoIterator{
    var isEmpty:Bool {return self.collection.isEmpty}
}


//
