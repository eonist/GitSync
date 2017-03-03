import Foundation
@testable import Utils
/**
 * Utility methods for parsing the the "git status message" 
 */
class CommitUtils{
	/**
	 * Returns a a text "commit message title" derived from @param status_list
	 * PARAM: status_list: a list with records that contain staus type, file name and state
	 * NOTE: C,I,R seems to never be triggered, COPIED,IGNORED,REMOVED,
	 * NOTE: In place of Renamed, Git first deletes the file then says its untracked
     */
    static func sequenceCommitMsgTitle(_ statusList:[[String:String]])->String{
		var numOfNewFiles:Int = 0
		var numOfModifiedFiles:Int = 0
		var numOfDeletedFiles:Int = 0
		var numOfRenamedFiles:Int = 0
		for statusItem in statusList{
			let cmd = statusItem["cmd"]!/*TODO: rename to type or status_type*/
			switch cmd{
				case "M":
					numOfModifiedFiles +=  1
				case "D":
					numOfDeletedFiles +=  1
				case "A":
					numOfNewFiles +=  1
				case "R": /*This command seems to never be triggered in git*/
					numOfRenamedFiles +=  1
				case "??": /*untracked files*/
					numOfNewFiles += 1
				case "UU": /*unmerged files*/
					numOfModifiedFiles += 1
				default:
					fatalError("cmd: " + "\(cmd)" + " Not supported")
					break;
			}
		}
		var commitMessage:String = ""
		if (numOfNewFiles > 0) {
			commitMessage +=  "New files added: " + "\(numOfNewFiles)"
		}
		if (numOfModifiedFiles > 0) {
			if (commitMessage.characters.count > 0) {  commitMessage +=  ", " }//--append comma
			commitMessage +=  "Files modified: " + "\(numOfModifiedFiles)"
		}
		if (numOfDeletedFiles > 0) {
			if (commitMessage.characters.count > 0) {  commitMessage += ", " }//--append comma
			commitMessage +=  "Files deleted: " + "\(numOfDeletedFiles)"
		}
		if (numOfRenamedFiles > 0) {
			if (commitMessage.characters.count > 0) {  commitMessage +=  ", "}// --append comma
			commitMessage +=  "Files renamed: " + "\(numOfRenamedFiles)"
		}
        //commitMessage = StringParser.decode(commitMessage)!
		return commitMessage
	}
}
