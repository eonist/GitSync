import Foundation
class RepoUtils{//Utility methods for parsing the repository.xml file
	/**
	 * Returns a list with repo values derived from an XML file
 	 * @param file_path 
 	 * TODO: if the interval values is not set, then use default values
	 * TODO: test if the full/partly file path still works?
	 */
	func compileRepoList(filePath:String)->[Dictionary<String,String>]{
        let children:Array<NSXMLElement> = XMLParser.rootChildrenByFilePath(filePath)
        var theRepoList:[Dictionary<String,String>] = []
        for child:NSXMLElement in children{
            var localPath:String = XMLParser.attribute(child,"local-path")! //this is the path to the local repository (we need to be in this path to execute git commands on this repo)
            localPath = ShellUtils.run("echo " + StringModifier.wrapWith(localPath,"'") + " | sed 's/ /\\\\ /g'")//--Shell doesnt handle file paths with space chars very well. So all space chars are replaced with a backslash and space, so that shell can read the paths.
            var remotePath:String = XMLParser.attribute(child,"remote-path")!
            remotePath = RegExpModifier.replace(remotePath,"^https://.+$","")//support for partial and full url, strip away the https://, since this will be added later
            //print(remotePath)
            let keychainItemName:String = XMLParser.attribute(child,"keychain-item-name")!
            let interval:String = XMLParser.attribute(child,"interval")!//default is 1min
            let repoItem:Dictionary<String,String> = ["localPath":localPath,"remotePath":remotePath,"keychainItemName":keychainItemName,"interval":interval]
            theRepoList.append(repoItem)
        }
        return theRepoList
	}
}