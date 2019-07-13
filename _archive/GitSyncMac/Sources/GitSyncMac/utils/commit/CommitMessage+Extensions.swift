import Foundation
@testable import Utils

extension CommitMessage{
    /**
     * Creates a commit message based on statusList
     */
    init(statusList: [[String: String]]) {
        let title: String = CommitMessageUtils.sequenceCommitMsgTitle(statusList) //sequence commit msg title for the commit
        let desc: String = CommitDescUtils.sequenceDescription(statusList)//sequence commit msg description for the commit
        self.init(title, desc)
    }
    /**
     * Creates a commit message based on statusList
     */
    static func autoCommitMessage(repoItem: RepoItem, commitMessage: CommitMessage?) -> CommitMessage? {
        var autoMessage: CommitMessage? = CommitMessageUtils.generateCommitMessage(repoItem.localPath)
//        Swift.print("repoItem.title: " + "\(repoItem.title)")
//        Swift.print("repoItem.template: " + "\(repoItem.template)")
        if autoMessage != nil, !repoItem.template.isEmpty {
//            Swift.print("set template 🍏")
            autoMessage?.title = repoItem.template/*Add template as title if it exists*/
        }
//        Swift.print("autoMessage.title: " + "\(autoMessage?.title)")
        return autoMessage
    }
}
