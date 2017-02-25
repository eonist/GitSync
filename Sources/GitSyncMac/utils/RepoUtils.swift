import Foundation
@testable import Utils
/**
 * Utility methods for parsing the repository.xml file
 */
class RepoUtils{
	/**
	 * Returns a list with repo values derived from an XML file
 	 * PARAM: file_path
 	 * TODO: if the interval values is not set, then use default values
	 * TODO: test if the full/partly file path still works?
	 */
	
    /**
     * Returns an array of RepoItems derived from a nested xml Structure
     */
    static var repoList:[RepoItem]{
        let repoXML:XML
        if(RepoView.node != nil){
            repoXML = RepoView.node!.xml//re-use if it already exists
        }else{
            repoXML = FileParser.xml(RepoView.repoList.tildePath)//or load a fresh copy
        }
        let arr:[Any] = XMLParser.arr(repoXML)//convert xml to multidimensional array
        let flatArr:[[String:String]] = arr.recursiveFlatmap()
        /*
         Swift.print("flatArr.count: " + "\(flatArr.count)")
         flatArr.forEach{
         Swift.print("$0: " + "\($0)")
         }
         */
        let repoList:[RepoItem] = flatArr.filter{
            ($0["hasChildren"] == nil) && ($0["isOpen"] == nil)//skips folders
            }.map{//create array of tuples
                RepoUtils.repoItem($0)
        }
        //Swift.print("repoList.count: " + "\(repoList.count)")
        //Swift.print("repoList[0]: " + "\(repoList[0])")
        return repoList
    }
    /**
     *
     */
    static func repoItem(_ dict:[String:String]) -> RepoItem{
        var localPath:String = XMLParser.attribute(child,"local-path")! //this is the path to the local repository (we need to be in this path to execute git commands on this repo)
        localPath = ShellUtils.run("echo " + StringModifier.wrapWith(localPath,"'") + " | sed 's/ /\\\\ /g'")//--Shell doesnt handle file paths with space chars very well. So all space chars are replaced with a backslash and space, so that shell can read the paths.
        var remotePath:String = dict["remote-path""]
        remotePath = RegExp.replace(remotePath,"^https://.+$","")//support for partial and full url, strip away the https://, since this will be added later
        //print(remotePath)
        let keychainItemName:String = dict["keychain-item-name"]
        let interval:String = dict["interval"]//default is 1min
        let repoItem:Dictionary<String,String> = ["localPath":localPath,"remotePath":remotePath,"keychainItemName":keychainItemName,"interval":interval]
        
        return (localPath:dict["local-path"]!,interval:dict["interval"]!.int,branch:dict["branch"]!,keyChainItemName:dict["keychain-item-name"]!,broadcast:dict["broadcast"]!.bool,title:dict["title"]!,subscribe:dict["subscribe"]!.bool,autoSync:dict["auto-sync"]!.bool,remotePath:dict["remote-path"]!)
    }
}
