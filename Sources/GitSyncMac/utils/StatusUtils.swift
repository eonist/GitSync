import Foundation
@testable import Utils
/*
 * Utils for paraing the git status list
 */
class StatusUtils{
	/*
	 * Returns a descriptive status list of the current git changes
	 * NOTE: you may use short status, but you must interpret the message if the state has an empty space infront of it
	 */
	class func generateStatusList(_ localRepoPath:String)->[Dictionary<String,String>]{
		let theStatus:String = GitParser.status(localRepoPath, "-s") //-- the -s stands for short message, and returns a short version of the status message, the short stauslist is used because it is easier to parse than the long status list
		//Swift.print("theStatus: " + "\(theStatus)")
		let theStatusList:Array = StringParser.paragraphs(theStatus) //--store each line as items in a list
		var transformedList:[Dictionary<String,String>] = []
		if (theStatusList.count > 0) {
			transformedList = transformStatusList(theStatusList)
		}else{
			//Swift.print("nothing to commit, working directory clean")// --this is the status msg if there has happened nothing new since last, but also if you have commits that are ready for push to origin
		}
        //Swift.print("transformedList.count: " + "\(transformedList.count)")
		//Swift.print("transformedList: " + "\(transformedList)")
        
		return transformedList
	}
	/*
 	 * Transforms the "compact git status list" by adding more context to each item (a list with acociative lists, aka records)
 	 * Returns a list with records that contain staus type, file name and state
 	 * NOTE: the short status msg format is like: "M" " M", "A", " A", "R", " R" etc
 	 * NOTE: the space infront of the capetalized char indicates Changes not staged for commit:
 	 * NOTE: Returns = renamed, M = modified, A = addedto index, D = deleted, ?? = untracked file
	 * NOTE: the state can be:  "Changes not staged for commit" , "Untracked files" , "Changes to be committed"
	 * @Param: theStatusList is a list with status messages like: {"?? test.txt"," M index.html","A home.html"}
	 * NOTE: can also be "UU" unmerged paths
 	 */
    class func transformStatusList(_ theStatusList:[String])->[[String:String]]{
        //Swift.print("transformStatusList()")
        var transformedList:[[String:String]] = []
        for theStatusItem:String in theStatusList {
			//Swift.print("theStatusItem: " + "\(theStatusItem)")
            
            //Continue here: do an isloated test with: "?? a.txt"
            
            let matches:[NSTextCheckingResult] = RegExp.matches(theStatusItem, "^( )*([MARDU?]{1,2}) (.+)$") //--returns 3 capturing groups,
            let theStatusParts:NSTextCheckingResult = matches[0]
            enum StatusParts:Int{ case first = 0, second , third, fourth}
            let second:String = theStatusParts.rangeAt(StatusParts.second.rawValue).length > 0 ? RegExp.value(theStatusItem,theStatusParts,StatusParts.second.rawValue) : ""
            //Swift.print("second: " + "\(second)")
            let third:String = RegExp.value(theStatusItem,theStatusParts,StatusParts.third.rawValue)
            //Swift.print("third: " + "\(third)")
            let fourth:String = RegExp.value(theStatusItem,theStatusParts,StatusParts.fourth.rawValue)
            //Swift.print("fourth: " + "\(fourth)")
			//--log "length of theStatusParts: " & (length of theStatusParts)
			//--log theStatusParts
            var statusItem:[String:String] = ["state":"", "cmd":"", "fileName":""] //--store the individual parts in an accociative
			if (second == " ") { //--aka " M", remember that the second item is the first capturing group
				statusItem["cmd"] = third //--Changes not staged for commit:
				statusItem["state"] = "Changes not staged for commit" //-- you Pneed to add them
			}else{ //-- Changes to be committed--aka "M " or  "??" or "UU"
				statusItem["cmd"] = third //--rename cmd to type
				//--log "cmd: " & cmd
				if(statusItem["cmd"] == "??"){
					statusItem["state"] = "Untracked files"
				}else if(statusItem["cmd"] == "UU") { //--Unmerged path
					//--log "Unmerged path"
					statusItem["state"] = "Unmerged path"
				}else{
					statusItem["state"] = "Changes to be committed" //--this is when the file is ready to be commited
				}
			}
			statusItem["fileName"] = fourth
			//--log "state: " & state & ", cmd: " & cmd & ", file_name: " & file_name --logs the file named added changed etc
			transformedList.append(statusItem) //--add a record to a list
		}
		return transformedList
	}
	/**
	 * Iterates over the status items and "git add" the item unless it's already added (aka "staged for commit")
	 * NOTE: if the status list is empty then there is nothing to process
	 * NOTE: even if a file is removed, its status needs to be added to the next commit
	 * TODO: Squash some of the states together with if or or or etc..
	 */
	class func processStatusList(_ localRepoPath:String, _ statusList:[Dictionary<String,String>]){
		//Swift.print("processStatusList()")
        for statusItem:[String:String] in statusList{
			//--log "len of status_item: " & (length of statusItem)
			//--set cmd to cmd of status_item
            let state:String = statusItem["state"]!
            //Swift.print("state: " + "\(state)")
            let fileName:String = statusItem["fileName"]!
            //Swift.print("fileName: " + "\(fileName)")
			switch state {
				case "Untracked files": //--this is when there exists a new file
					//Swift.print("1. " + "Untracked files")
					_ = GitModifier.add(localRepoPath, fileName) //🌵 add the file to the next commit
				case "Changes not staged for commit": //--this is when you have not added a file that has changed to the next commit
					//Swift.print("2. " + "Changes not staged for commit")
					_ = GitModifier.add(localRepoPath, fileName) //🌵 add the file to the next commit
				case "Changes to be committed"://--this is when you have added a file to the next commit, but not commited it
                    _ = ""
                    //Swift.print("3. " + "Changes to be committed")//do nothing here
				case "Unmerged path": //--This is when you have files that have to be resolved first, but eventually added aswell
					//Swift.print("4. " + "Unmerged path")
					_ = GitModifier.add(localRepoPath, fileName) //🌵 add the file to the next commit
                default :
					//throw error
					break
			}
		}
	}
}
