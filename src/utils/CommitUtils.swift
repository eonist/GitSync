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
				set numOfModifiedFiles to numOfModifiedFiles + 1
			}else if (statusItem["cmd"] = "D") {
				set numOfDeletedFiles to numOfDeletedFiles + 1
			}else if (statusItem["cmd"] = "A") {
				set numOfNewFiles to numOfNewFiles + 1
			}else if (statusItem["cmd"] = "R") {// --This command seems to never be triggered in git
				set numOfDeletedFiles to numOfDeletedFiles + 1
			}else if (statusItem["cmd"] = "??") {// --untracked files,
				set numOfNewFiles to numOfNewFiles + 1
			}else if (statusItem["cmd"] = "UU") {// --unmerged files,
				set numOfModifiedFiles to numOfModifiedFiles + 1
			}
		end repeat
		set commit_msg to ""
		if (numOfNewFiles > 0) then
			set commit_msg to commit_msg & "New files added: " & numOfNewFiles
		end if
		if (numOfModifiedFiles > 0) then
			if (length of commit_msg > 0) then set commit_msg to commit_msg & ", " --append comma
			set commit_msg to commit_msg & "Files modified: " & numOfModifiedFiles
		end if
		if (numOfDeletedFiles > 0) then
			if (length of commit_msg > 0) then set commit_msg to commit_msg & ", " --append comma
			set commit_msg to commit_msg & "Files deleted: " & numOfDeletedFiles
		end if
		if (numOfDeletedFiles > 0) then
			if (length of commit_msg > 0) then set commit_msg to commit_msg & ", " --append comma
			set commit_msg to commit_msg & "Files renamed: " & numOfDeletedFiles
		end if
		return commit_msg
	}
}