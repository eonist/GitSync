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
	func sequence_commit_msg_title(status_list){
		set num_of_new_files to 0
		set num_of_modified_files to 0
		set num_of_deleted_files to 0
		set num_of_renamed_files to 0
		repeat with status_item in status_list
			set cmd to cmd of status_item --TODO: rename to type or status_type
			if (cmd = "M") then
				set num_of_modified_files to num_of_modified_files + 1
			else if (cmd = "D") then
				set num_of_deleted_files to num_of_deleted_files + 1
			else if (cmd = "A") then
				set num_of_new_files to num_of_new_files + 1
			else if (cmd = "R") then --This command seems to never be triggered in git
				set num_of_renamed_files to num_of_renamed_files + 1
			else if (cmd = "??") then --untracked files,
				set num_of_new_files to num_of_new_files + 1
			else if (cmd = "UU") then --unmerged files,
				set num_of_modified_files to num_of_modified_files + 1
			end if
		end repeat
		set commit_msg to ""
		if (num_of_new_files > 0) then
			set commit_msg to commit_msg & "New files added: " & num_of_new_files
		end if
		if (num_of_modified_files > 0) then
			if (length of commit_msg > 0) then set commit_msg to commit_msg & ", " --append comma
			set commit_msg to commit_msg & "Files modified: " & num_of_modified_files
		end if
		if (num_of_deleted_files > 0) then
			if (length of commit_msg > 0) then set commit_msg to commit_msg & ", " --append comma
			set commit_msg to commit_msg & "Files deleted: " & num_of_deleted_files
		end if
		if (num_of_renamed_files > 0) then
			if (length of commit_msg > 0) then set commit_msg to commit_msg & ", " --append comma
			set commit_msg to commit_msg & "Files renamed: " & num_of_renamed_files
		end if
		return commit_msg
	}
}