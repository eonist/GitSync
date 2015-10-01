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
	func sequenceCommitMsgTitle(statusList){
		set numOfNewFiles = 0
		set numOfModifiedFiles = 0
		set numOfDeletedFiles = 0
		set numOfDeletedFiles = 0
		for statusItem in statusList
		//	let cmd to cmd of status_item --TODO: rename to type or status_type
			if (statusItem["cmd"] = "M") {
				 numOfModifiedFiles to numOfModifiedFiles + 1
			}else if (statusItem["cmd"] = "D") {
				 numOfDeletedFiles to numOfDeletedFiles + 1
			}else if (statusItem["cmd"] = "A") {
				 numOfNewFiles to numOfNewFiles + 1
			}else if (statusItem["cmd"] = "R") {// --This command seems to never be triggered in git
				 numOfDeletedFiles to numOfDeletedFiles + 1
			}else if (statusItem["cmd"] = "??") {// --untracked files,
				 numOfNewFiles to numOfNewFiles + 1
			}else if (statusItem["cmd"] = "UU") {// --unmerged files,
				 numOfModifiedFiles to numOfModifiedFiles + 1
			}
		end repeat
		set commitMessage to ""
		if (numOfNewFiles > 0) {
			 commitMessage to commitMessage & "New files added: " & numOfNewFiles
		}
		if (numOfModifiedFiles > 0) {
			if (commitMessage.count > 0) then set commitMessage to commitMessage & ", " //--append comma
			 commitMessage to commitMessage & "Files modified: " & numOfModifiedFiles
		}
		if (numOfDeletedFiles > 0) {
			if (commitMessage.count > 0) { set commitMessage to commitMessage & ", " //--append comma
			 commitMessage to commitMessage & "Files deleted: " & numOfDeletedFiles
		}
		if (numOfDeletedFiles > 0) {
			if (commitMessage.count > 0) then set commitMessage to commitMessage & ", "// --append comma
			 commitMessage to commitMessage & "Files renamed: " & numOfDeletedFiles
		}
		return commitMessage
	}
}






