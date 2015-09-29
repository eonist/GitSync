//import utils/xml/XMLParser.swift
//import utils/misc/shell/ShellUtils.swift
//import utils/string/regexp/RegExpParser.swift
//import utils/string/regexp/RegExpModifier.swift

class GitSync{

}
class RepoUtils{
	/**
	 * 
	 */
	func compileRepoList(filePath:String)->{
		let xml:String = XMLParser.data(filePath)
		let children:Array = xml["."]["repositories"][0]["."]["repository"]
		let numChildren:Int = children.count //number of xml children in xml root element
		var theRepoList to []
		for (var i:Int; i++; i < numChildren){
			let child = children[i]
			let localPath to child["@"]["local-path"] //this is the path to the local repository (we need to be in this path to execute git commands on this repo)
			let localPath = ShellUtils.run("echo " + "'" + localPath + "'" + " | sed 's/ /\\\\ /g'")//--Shell doesnt handle file paths with space chars very well. So all space chars are replaced with a backslash and space, so that shell can read the paths. 
			let remotePath: String = child["@"]["remote_path"]
			remotePath = RegExpModifier.replace(remotePath,"^https://.+$","")//support for partial and full url, strip away the https://, since this will be added later
			//print(remotePath)
			let keychainItemName: String = child["@"]["keychain-item-name"]
			//set commit_int to XMLParser's attribute_value_by_name(theXMLChild, "commit-interval-in-minutes") --defualt is 5min
			//set push_int to XMLParser's attribute_value_by_name(theXMLChild, "push-interval-in-minutes") --defualt is 10min
			//set pull_int to XMLParser's attribute_value_by_name(theXMLChild, "pull-interval-in-minutes") --default is 30min
			let interval: String = child["@"]["interval"]//default is 1min
			let remoteAccountName: String = child["@"]["remote-account-name"]
			let key_value_pairs to {local_path:local_path, remote_path:remote_path, keychain_item_name:keychain_item_name, interval:interval} //remote_account_name:remote_account_name,commit_int:commit_int, push_int:push_int--TODO: shouldnt the line bellow be sudo acociative list? or does the record style list work as is?, if you dont need to iterate over the values, you may use record
			theRepoList += ["localPath":localPath,"remotePath":remotePath,"keychainItemName":keychainItemName,"interval":interval,"remoteAccountName":remoteAccountName]
		}
		return theRepoList
	}
}