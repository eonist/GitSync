/*
 * Utility methods for parsing the the "git status message" 
 */
class CommitUtil{
	/*
	 * Returns a a text "commit message title" derived from @param status_list
	 * @param status_list: a list with records that contain staus type, file name and state
	 * NOTE: C,I,R seems to never be triggered, COPIED,IGNORED,REMOVED,
	 * NOTE: In place of Renamed, Git first deletes the file then says its untracked
    */
	func sequenceCommitMsgTitle(statusList)->String{
		var numOfNewFiles:Int = 0
		var numOfModifiedFiles:Int = 0
		var numOfDeletedFiles:Int = 0
		var numOfDeletedFiles:Int = 0
		for (statusItem in statusList){
		//	let cmd to cmd of status_item --TODO: rename to type or status_type
			if (statusItem["cmd"] = "M") {
				 numOfModifiedFiles +=  1
			}else if (statusItem["cmd"] = "D") {
				 numOfDeletedFiles +=  1
			}else if (statusItem["cmd"] = "A") {
				 numOfNewFiles +=  1
			}else if (statusItem["cmd"] = "R") {// --This command seems to never be triggered in git
				 numOfDeletedFiles +=  1
			}else if (statusItem["cmd"] = "??") {// --untracked files,
				 numOfNewFiles += 1
			}else if (statusItem["cmd"] = "UU") {// --unmerged files,
				 numOfModifiedFiles += 1
			}
		}
		set commitMessage:String to ""
		if (numOfNewFiles > 0) {
			commitMessage +=  "New files added: " + numOfNewFiles
		}
		if (numOfModifiedFiles > 0) {
			if (commitMessage.count > 0) {  commitMessage +=  ", " }//--append comma
			commitMessage = += "Files modified: " + numOfModifiedFiles
		}
		if (numOfDeletedFiles > 0) {
			if (commitMessage.count > 0) {  commitMessage += ", " }//--append comma
			commitMessage +=  "Files deleted: " + numOfDeletedFiles
		}
		if (numOfDeletedFiles > 0) {
			if (commitMessage.count > 0) {  commitMessage +=  ", "}// --append comma
			commitMessage +=  "Files renamed: " + numOfDeletedFiles
		}
		return commitMessage
	}
}






