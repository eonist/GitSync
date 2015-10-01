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
			let cmd to cmd of status_item --TODO: rename to type or status_type
			if (cmd = "M") then
				set numOfModifiedFiles to numOfModifiedFiles + 1
			else if (cmd = "D") then
				set numOfDeletedFiles to numOfDeletedFiles + 1
			else if (cmd = "A") then
				set numOfNewFiles to numOfNewFiles + 1
			else if (cmd = "R") then --This command seems to never be triggered in git
				set numOfDeletedFiles to numOfDeletedFiles + 1
			else if (cmd = "??") then --untracked files,
				set numOfNewFiles to numOfNewFiles + 1
			else if (cmd = "UU") then --unmerged files,
				set numOfModifiedFiles to numOfModifiedFiles + 1
			end if
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