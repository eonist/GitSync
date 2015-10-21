class RepoUtils{//Utility methods for parsing the repository.xml file
	/**
	 * Returns a list with repo values derived from an XML file
 	 * @param file_path 
 	 * TODO: if the interval values is not set, then use default values
	 * TODO: test if the full/partly file path still works?
	 */
	func compileRepoList(filePath:String)->[Dictionary<String,String>]{
		let xml:Dictionary<String,Any> = XMLParser.data(filePath)
        let rootContent:Dictionary<String,Any> = xml["."] as! Dictionary<String,Any>
        let repositoriesChildren:[Dictionary<String,Any>] = rootContent["repositories"] as! [Dictionary<String,Any>]
        let firstRepositoriesChild:Dictionary<String,Any> = repositoriesChildren[0]
        let firstRepositoriesChildContent:Dictionary<String,Any> = firstRepositoriesChild["."] as! Dictionary<String,Any>
		let repositoryChildren:[Dictionary<String,Any>] = firstRepositoriesChildContent["repository"] as! [Dictionary<String,Any>]
        
        //let numChildren:Int = repositoryChildren.count //number of xml children in xml root element
		var theRepoList:[Dictionary<String,String>] = []
		
        for repositoryChild:Dictionary<String,Any> in repositoryChildren{
			//let child:Dictionary = repositoryChildren[i]
            let attr:Dictionary<String,String> = repositoryChild["@"] as! Dictionary<String,String>
			var localPath:String = attr["local-path"]! //this is the path to the local repository (we need to be in this path to execute git commands on this repo)
			localPath = ShellUtils.run("echo " + StringModifier.wrapWith(localPath,"'") + " | sed 's/ /\\\\ /g'")//--Shell doesnt handle file paths with space chars very well. So all space chars are replaced with a backslash and space, so that shell can read the paths.
			var remotePath:String = attr["remote_path"]!
			remotePath = RegExpModifier.replace(remotePath,"^https://.+$","")//support for partial and full url, strip away the https://, since this will be added later
			//print(remotePath)
			let keychainItemName:String = attr["keychain-item-name"]!
			let interval:String = attr["interval"]!//default is 1min
			let remoteAccountName:String = attr["remote-account-name"]!
            let repoItem:Dictionary<String,String> = ["localPath":localPath,"remotePath":remotePath,"keychainItemName":keychainItemName,"interval":interval,"remoteAccountName":remoteAccountName]
			theRepoList.append(repoItem)
		}
		return theRepoList
	}
}