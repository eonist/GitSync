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
	func compileRepoList(filePath:String){
		let xml:String = XMLParser.data(filePath)
		let children:Array = xml["."]["repositories"][0]["."]["repository"]
		let numChildren:Int = children.count //number of xml children in xml root element
		var theRepoList to []
		for (var i:Int; i++; i < numChildren){
			let child = children[i]
			let local_path to child["@"]["local-path"] //this is the path to the local repository (we need to be in this path to execute git commands on this repo)
			
			//continue here:
			let local_path = ShellUtils.run("echo " + "'" + local_path + "'" + " | sed 's/ /\\\\ /g'")//--Shell doesnt handle file paths with space chars very well. So all space chars are replaced with a backslash and space, so that shell can read the paths. 
			"remote-path"
			let remote_path: String = child["@"]["remote_path"]
	
			set is_full_url to RegExpUtil's has_match(remote_path, "^https://.+$") --support for partial and full url
			if is_full_url = true then
				set remote_path to text 9 thru (length of remote_path) of remote_path --strip away the https://, since this will be added later
			end if
			--log remote_path
			set keychain_item_name to XMLParser's attribute_value_by_name(theXMLChild, "keychain-item-name")
			--set commit_int to XMLParser's attribute_value_by_name(theXMLChild, "commit-interval-in-minutes") --defualt is 5min
			--set push_int to XMLParser's attribute_value_by_name(theXMLChild, "push-interval-in-minutes") --defualt is 10min
			--set pull_int to XMLParser's attribute_value_by_name(theXMLChild, "pull-interval-in-minutes") --default is 30min
			set interval to XMLParser's attribute_value_by_name(theXMLChild, "interval") --default is 30min
			--set remote_account_name to XMLParser's attribute_value_by_name(theXMLChild, "remote-account-name")
			--TODO: use only 1 interval
			set key_value_pairs to {local_path:local_path, remote_path:remote_path, keychain_item_name:keychain_item_name, interval:interval} --remote_account_name:remote_account_name,commit_int:commit_int, push_int:push_int--TODO: shouldnt the line bellow be sudo acociative list? or does the record style list work as is?, if you dont need to iterate over the values, you may use record
			set the_repo_list to ListModifier's add_list(the_repo_list, key_value_pairs)
		}
		return theRepoList
	}
}