/*
 * Utility methods for generating the "Git Commit Message Description"
 */
class DescUtil{
	/*
	 * Returns a "Git Commit Message Description" derived from a "git status list" with "status items records"
	 */
	func sequenceDescription(statusList){
		var descText:String = ""
		var modifiedItems:Array = []
		var deletedItems:Array = []
		var addedItems:Array = []
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
		var descText to ""
		if (theList.count > 0) {
			set theSuffix to " file"
			if (theList.count > 1) { theSuffix += "s" }//--multiple
			descText += prefixText + theList.count + theSuffix + ":" & "\n"
			for (theItem in theList){
				descText += theItem["fileName"] + "\n"
			}
		}
		return descText
	}
}


