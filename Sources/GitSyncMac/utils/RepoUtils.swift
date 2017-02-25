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
        return (localPath:dict["local-path"]!,interval:dict["interval"]!.int,branch:dict["branch"]!,keyChainItemName:dict["keychain-item-name"]!,broadcast:dict["broadcast"]!.bool,title:dict["title"]!,subscribe:dict["subscribe"]!.bool,autoSync:dict["auto-sync"]!.bool,remotePath:dict["remote-path"]!)
    }
}
