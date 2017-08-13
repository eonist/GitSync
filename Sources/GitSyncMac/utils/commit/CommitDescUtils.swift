import Foundation
@testable import Utils
/**
 * Utility methods for generating the "Git Commit Message Description"
 */
class CommitDescUtils{
	/**
	 * Returns a "Git Commit Message Description" derived from a "git status list" with "status items records"
	 */
	class func sequenceDescription(_ statusList:[[String:String]])->String{
		var descText:String = ""
		var modifiedItems:[[String:String]] = []
		var deletedItems:[[String:String]] = []
        var renamedItems:[[String:String]] = []
        var addedItems:[[String:String]] = []
        for statusItem:[String:String] in statusList{
            let cmd:String = statusItem["cmd"]!
			switch GitCMD(rawValue:cmd){
            case .D?:
                deletedItems.append(statusItem) //--add a record to a list
            case .R?://new and experimental
                renamedItems.append(statusItem) //--add a record to a list
            case .RM?://new and experimental
                renamedItems.append(statusItem) //--add a record to a list
            case .A?:
                addedItems.append(statusItem)//--add a record to a list
            case .M?:
                modifiedItems.append(statusItem)//--add a record to a list
            case .MM?://new and experimental
                modifiedItems.append(statusItem)//--add a record to a list
            case .AA?://new beta
                addedItems.append(statusItem)//--add a record to a list
            case .AM?://new beta
                addedItems.append(statusItem)//--add a record to a list
            case .QQ?:
                addedItems.append(statusItem)//--add a record to a list
            case .UU?:
                modifiedItems.append(statusItem)//--add a record to a list
            case .UA?:
                addedItems.append(statusItem)//--add a record to a list
            default:
                /*throw error*/
                fatalError("cmd: " + "\(cmd)" + " Not supported")
                break;
			}
		}
		descText += descriptionParagraph(addedItems, prefix: "Added ")
		descText += descriptionParagraph(deletedItems, prefix: "Deleted ")
        descText += descriptionParagraph(renamedItems, prefix: "Renamed ")
		descText += descriptionParagraph(modifiedItems, prefix: "Modified ")
        //descText = StringParser.decode(descText)!
        return descText.trimRight("\n")//remove the last newLine if it exists
	}
	/**
	 * Returns a paragraph with a detailed description for Deleted, added and modified files
	 */
    class func descriptionParagraph(_ theList:[[String:String]], prefix prefixText:String)->String{
        if !theList.isEmpty {
            var theSuffix:String = " file"
            if theList.count > 1 { theSuffix += "s" }/*multiple*/
            let descText:String = prefixText + "\(theList.count)" + theSuffix + ":" + "\n"
            return theList.reduce(descText) {
                $0 + $1["fileName"]! + "\n" /*adds an extra line break at the end "paragraph like"*/
            } + "\n"
        }else{
            return ""
        }
	}
}
