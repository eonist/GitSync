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
	func sequenceCommitMsgTitle(statusList:Array)->String{
		var numOfNewFiles:Int = 0
		var numOfModifiedFiles:Int = 0
		var numOfDeletedFiles:Int = 0
		var numOfDeletedFiles:Int = 0
		for (statusItem in statusList){
		//	let cmd to cmd of status_item --TODO: rename to type or status_type
			switch variable{
				case "M"
					numOfModifiedFiles +=  1
				case "D"
					numOfDeletedFiles +=  1
				case "A"
					numOfNewFiles +=  1
				case "R" // --This command seems to never be triggered in git
					numOfDeletedFiles +=  1
				case "??"// --untracked files,
					numOfNewFiles += 1
				case "UU"// --unmerged files,
					numOfModifiedFiles += 1
				default
					//throw error
					break;
			}
		}
		var commitMessage:String = ""
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