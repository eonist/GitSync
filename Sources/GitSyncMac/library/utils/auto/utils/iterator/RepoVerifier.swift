import Foundation
@testable import Utils
/**
 * Verifies if git project exists locally, prompts a wizard if doesn't exist
 */
class RepoVerifier:ArrayIterator<RepoItem>{
    typealias AllCompleted = ()->Void
    let onAllComplete:AllCompleted
    var verifiedRepos:[RepoItem] = []
    init(array: Array<T>, onComplete:@escaping AllCompleted) {
        self.onAllComplete = onComplete
        super.init(array: array)
    }
    func iterate() {
//        Swift.print("self.hasNext(): " + "\(self.hasNext())")
        if self.hasNext() {
            let repoItem = self.next()
            self.verifyGitProject(repoItem)
        }else {
            self.onAllComplete()
        }
    }
    /**
     * Works as a onComplete handler, to facilitate canceling verification in "auto init dialog"
     */
    func verify(repoItem:RepoItem,verified:Bool){
        if verified {verifiedRepos.append(repoItem)}
        iterate()
    }
    /**
     * NOTE: verifies if a repo exists locally, if not a wizard initiated
     */
    private func verifyGitProject(_ repoItem:RepoItem){
//        Swift.print("verifyGitProject")
        let conflict = AutoInitConflict.init(repoItem)
        if conflict.areRemotesEqual {/*No need to init AutoInit dialog*/
            verify(repoItem: repoItem, verified: true)
        }else{
            main.async{/*Jump on the main thread*/
                Nav.setView(.dialog(.autoInit(conflict,self.verify)))
            }
        }
    }
}
