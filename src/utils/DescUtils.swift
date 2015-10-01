/*
 * Utility methods for generating the "Git Commit Message Description"
 */
class DescUtil{
	/*
	 * Returns a "Git Commit Message Description" derived from a "git status list" with "status items records"
	 */
	func sequenceDescription(statusList){
	
	
	
		//continue here
	
	
	
		set descText to ""
		set modifiedItems to {}
		set deletedItems to {}
		set addedItems to {}
		repeat with status_item in status_list
			if (cmd of status_item is "D") then set deletedItems to ListModifier's add_list(deletedItems, status_item) --add a record to a list
			if (cmd of status_item is "M") then set modifiedItems to ListModifier's add_list(modifiedItems, status_item) --add a record to a list
			if (cmd of status_item is "??") then set addedItems to ListModifier's add_list(addedItems, status_item) --add a record to a list
			if (cmd of status_item is "UU") then set modifiedItems to ListModifier's add_list(modifiedItems, status_item) --add a record to a list
		end repeat
		set descText to descText & description_paragraph(addedItems, "Added ") & return --add an extra line break at the end "paragraph like"
		set descText to descText & description_paragraph(deletedItems, "Deleted ") & return
		set descText to descText & description_paragraph(modifiedItems, "Modified ")
		return descText
	}
	/*
	 * Returns a paragraph with a detailed description for Deleted, added and modified files
	 */
	func description_paragraph(the_list, prefix_text){
		set descText to ""
		if (length of the_list > 0) {
			set the_suffix to " file"
			if (length of the_list > 1) then set the_suffix to the_suffix & "s" --multiple
			set descText to descText & prefix_text & length of the_list & the_suffix & ":" & return
			repeat with the_item in the_list
				set descText to descText & (file_name of the_item) & return
			end repeat
		}
		return descText
	}
}


