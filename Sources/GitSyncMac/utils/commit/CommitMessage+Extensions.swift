import Foundation
@testable import Utils

extension CommitMessage{
    /**
     * New
     */
    init(statusList:[[String:String]]){
        let title:String = CommitMessageUtils.sequenceCommitMsgTitle(statusList) //sequence commit msg title for the commit
        let desc:String = CommitDescUtils.sequenceDescription(statusList)//sequence commit msg description for the commit
        self.init(title, desc)
    }
    /**
     * New
     */
    static func autoCommitMessage(repoItem:RepoItem,  commitMessage:CommitMessage?) -> CommitMessage?{
        let autoMessage:CommitMessage? = CommitMessageUtils.generateCommitMessage(repoItem.localPath)
        if var autoMessage = autoMessage, !repoItem.template.isEmpty {
            autoMessage.title = repoItem.template/*Add template as title if it exists*/
        }
        return autoMessage
    }
}

