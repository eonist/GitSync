class RepoUtils{//Utility methods for parsing the repository.xml file
	/**
	 * Returns a list with repo values derived from an XML file
 	 * @param file_path 
 	 * TODO: if the interval values is not set, then use default values
	 * TODO: test if the full/partly file path still works?
	 */
	func compileRepoList(filePath:String)->[Dictionary<String,String>]{
		let xml:String = XMLParser.data(filePath)
		let children:[Dictionary<String,String>] = xml["."]!["repositories"]![0]!["."]!["repository"]!
		let numChildren:Int = children.count //number of xml children in xml root element
		var theRepoList:[Dictionary<String,String>] = []
		for (var i:Int; i++; i < numChildren){
			let child:Dictionary = children[i]
			let localPath:String = child["@"]["local-path"] //this is the path to the local repository (we need to be in this path to execute git commands on this repo)
			localPath = ShellUtils.run("echo " + StringModifer.wrapWith(localPath,"'") + " | sed 's/ /\\\\ /g'")//--Shell doesnt handle file paths with space chars very well. So all space chars are replaced with a backslash and space, so that shell can read the paths. 
			let remotePath:String = child["@"]["remote_path"]
			remotePath = RegExpModifier.replace(remotePath,"^https://.+$","")//support for partial and full url, strip away the https://, since this will be added later
			//print(remotePath)
			let keychainItemName:String = child["@"]["keychain-item-name"]
			let interval:String = child["@"]["interval"]//default is 1min
			let remoteAccountName:String = child["@"]["remote-account-name"]
			theRepoList += ["localPath":localPath,"remotePath":remotePath,"keychainItemName":keychainItemName,"interval":interval,"remoteAccountName":remoteAccountName]
		}
		return theRepoList
	}
}