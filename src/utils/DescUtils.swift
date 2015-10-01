/*
 * Utility methods for generating the "Git Commit Message Description"
 */
class DescUtil{
	/*
	 * Returns a "Git Commit Message Description" derived from a "git status list" with "status items records"
	 */
	func sequence_description(status_list){
	
	
	
		//continue here
	
	
	
		set desc_text to ""
		set modified_items to {}
		set deleted_items to {}
		set added_items to {}
		repeat with status_item in status_list
			if (cmd of status_item is "D") then set deleted_items to ListModifier's add_list(deleted_items, status_item) --add a record to a list
			if (cmd of status_item is "M") then set modified_items to ListModifier's add_list(modified_items, status_item) --add a record to a list
			if (cmd of status_item is "??") then set added_items to ListModifier's add_list(added_items, status_item) --add a record to a list
			if (cmd of status_item is "UU") then set modified_items to ListModifier's add_list(modified_items, status_item) --add a record to a list
		end repeat
		set desc_text to desc_text & description_paragraph(added_items, "Added ") & return --add an extra line break at the end "paragraph like"
		set desc_text to desc_text & description_paragraph(deleted_items, "Deleted ") & return
		set desc_text to desc_text & description_paragraph(modified_items, "Modified ")
		return desc_text
	}
	/*
	 * Returns a paragraph with a detailed description for Deleted, added and modified files
	 */
	func description_paragraph(the_list, prefix_text){
		set desc_text to ""
		if (length of the_list > 0) {
			set the_suffix to " file"
			if (length of the_list > 1) then set the_suffix to the_suffix & "s" --multiple
			set desc_text to desc_text & prefix_text & length of the_list & the_suffix & ":" & return
			repeat with the_item in the_list
				set desc_text to desc_text & (file_name of the_item) & return
			end repeat
		}
		return desc_text
	}
}


