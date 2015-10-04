/*
 * Utility methods for generating the "Git Commit Message Description"
 */
class DescUtil{
	/*
	 * Returns a "Git Commit Message Description" derived from a "git status list" with "status items records"
	 */
	func sequenceDescription(statusList:Array)->String{
		var descText:String = ""
		var modifiedItems:Array = []
		var deletedItems:Array = []
		var addedItems:Array = []
		for statusItem in statusList as! [Dictionary]{
			switch statusItem["cmd"]{
				case "D" deletedItems.append(statusItem) //--add a record to a list
				case "M" modifiedItems.append(statusItem)//--add a record to a list
				case "??" addedItems.append(statusItem)//--add a record to a list
				case "UU" modifiedItems.append(statusItem)//--add a record to a list
				default
					//throw error
					break;
			}
		}
		descText += descriptionParagraph(addedItems, "Added ") + "\n" //--add an extra line break at the end "paragraph like"
		descText += descriptionParagraph(deletedItems, "Deleted ") + "\n"
		descText += descriptionParagraph(modifiedItems, "Modified ")
		return descText
	}
	/*
	 * Returns a paragraph with a detailed description for Deleted, added and modified files
	 */
	func descriptionParagraph(theList:Array, _ prefixText:String)->String{
		var descText:String = ""
		if (theList.count > 0) {
			set theSuffix:String = " file"
			if (theList.count > 1) { theSuffix += "s" }//--multiple
			descText += prefixText + theList.count + theSuffix + ":" + "\n"
			for (theItem in theList as! [Dictionary]){
				descText += theItem["fileName"] + "\n"
			}
		}
		return descText
	}
}