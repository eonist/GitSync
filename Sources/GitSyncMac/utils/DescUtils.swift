import Foundation
@testable import Utils
/**
 * Utility methods for generating the "Git Commit Message Description"
 */
class DescUtils{
	/*
	 * Returns a "Git Commit Message Description" derived from a "git status list" with "status items records"
	 */
	class func sequenceDescription(_ statusList:[Dictionary<String,String>])->String{
		var descText:String = ""
		var modifiedItems:[Dictionary<String,String>] = []
		var deletedItems:[Dictionary<String,String>] = []
		var addedItems:[Dictionary<String,String>] = []
        for statusItem:Dictionary<String,String> in statusList{
            let cmd:String = statusItem["cmd"]!
			switch cmd{
				case "D": deletedItems.append(statusItem) //--add a record to a list
				case "M": modifiedItems.append(statusItem)//--add a record to a list
				case "??": addedItems.append(statusItem)//--add a record to a list
				case "UU": modifiedItems.append(statusItem)//--add a record to a list
				default:
					//throw error
					break;
			}
		}
		descText += descriptionParagraph(addedItems, "Added ") + "\n" //--add an extra line break at the end "paragraph like"
		descText += descriptionParagraph(deletedItems, "Deleted ") + "\n"
		descText += descriptionParagraph(modifiedItems, "Modified ")
		
        //descText = StringParser.decode(descText)!
        
        return descText
	}
	/*
	 * Returns a paragraph with a detailed description for Deleted, added and modified files
	 */
    class func descriptionParagraph(_ theList:[[String:String]], _ prefixText:String)->String{
		var descText:String = ""
		if (theList.count > 0) {
			var theSuffix:String = " file"
			if (theList.count > 1) { theSuffix += "s" }//--multiple
			descText += prefixText + "\(theList.count)" + theSuffix + ":" + "\n"
            for theItem:Dictionary<String,String> in theList {
				descText += theItem["fileName"]! + "\n"
			}
		}
		return descText
	}
}
