//import utils/xml/XMLParser.swift
//import utils/misc/shell/ShellUtils.swift
//import utils/string/regexp/RegExpParser.swift
//import utils/string/regexp/RegExpModifier.swift

class GitSync{
	/*
	 * Handles the process of comitting, pushing for multiple repositories
	 * This is called on every interval
	 * NOTE: while testing you can call this manually, since idle will only work when you run it from an .app
	 */
	func handle_interval(){
		print( "handle_interval()")
		let repo_list = RepoUtil.compile_repo_list(repo_file_path) --try to avoid calling this on every intervall, its nice to be able to update on the fly, be carefull though
		let current_time_in_min to (current_time / 60) --divide the seconds by 60 seconds to get minutes
		
		
		//continue here
		
		
		log "current_time_in_min: " & current_time_in_min
		repeat with repo_item in repo_list --iterate over every repo item
			if (current_time_in_min mod (interval of repo_item) = 0) then handle_commit_interval(repo_item, "master") --is true every time spesified by the user
			if (current_time_in_min mod (interval of repo_item) = 0) then handle_push_interval(repo_item, "master") --is true every time spesified by the user
		end repeat
		set current_time to current_time + the_interval --increment the interval (in seconds)
	}
}
class RepoUtils{//Utility methods for parsing the repository.xml file
	/**
	 * Returns a list with repo values derived from an XML file
 	 * @param file_path 
 	 * TODO: if the interval values is not set, then use default values
	 * TODO: test if the full/partly file path still works?
	 */
	func compileRepoList(filePath:String)->Array{
		let xml:String = XMLParser.data(filePath)
		let children:Array = xml["."]["repositories"][0]["."]["repository"]
		let numChildren:Int = children.count //number of xml children in xml root element
		var theRepoList:Array to []
		for (var i:Int; i++; i < numChildren){
			let child = children[i]
			let localPath to child["@"]["local-path"] //this is the path to the local repository (we need to be in this path to execute git commands on this repo)
			let localPath = ShellUtils.run("echo " + "'" + localPath + "'" + " | sed 's/ /\\\\ /g'")//--Shell doesnt handle file paths with space chars very well. So all space chars are replaced with a backslash and space, so that shell can read the paths. 
			let remotePath: String = child["@"]["remote_path"]
			remotePath = RegExpModifier.replace(remotePath,"^https://.+$","")//support for partial and full url, strip away the https://, since this will be added later
			//print(remotePath)
			let keychainItemName: String = child["@"]["keychain-item-name"]
			let interval: String = child["@"]["interval"]//default is 1min
			let remoteAccountName: String = child["@"]["remote-account-name"]
			theRepoList += ["localPath":localPath,"remotePath":remotePath,"keychainItemName":keychainItemName,"interval":interval,"remoteAccountName":remoteAccountName]
		}
		return theRepoList
	}
}