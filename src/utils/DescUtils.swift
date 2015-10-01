/*
 * Utility methods for generating the "Git Commit Message Description"
 */
class DescUtil{
	/*
	 * Returns a "Git Commit Message Description" derived from a "git status list" with "status items records"
	 */
	func sequenceDescription(statusList){
	
	
	
		//continue here
	
	
	
		set descText:String = ""
		set modifiedItems:Array = []
		set deletedItems:Array = []
		set addedItems:Array = []
		for statusItem in statusList{
			if (statusItem["cmd"] == "D") { deletedItems.append(statusItem) }//--add a record to a list
			if (statusItem["cmd"] == "M") { modifiedItems.append( statusItem) }//--add a record to a list
			if (statusItem["cmd"] == "??") { addedItems.append(statusItem) }//--add a record to a list
			if (statusItem["cmd"] == "UU") { modifiedItems.append( statusItem) }//--add a record to a list
		}
		descText += descriptionParagraph(addedItems, "Added ") + "\n" //--add an extra line break at the end "paragraph like"
		descText += descriptionParagraph(deletedItems, "Deleted ") + "\n"
		descText += descriptionParagraph(modifiedItems, "Modified ")
		return descText
	}
	/*
	 * Returns a paragraph with a detailed description for Deleted, added and modified files
	 */
	func descriptionParagraph(theList, prefixText){
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


