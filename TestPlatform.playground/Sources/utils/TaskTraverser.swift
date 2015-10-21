import Foundation

public class TaskTraverser {
    /**
     * Prints the Task tree
     */
    public class func traverseTree(arr:[Dictionary<String,Any>]){
        for item in arr {
            if (item["folder"] != nil){
                let folder = item["folder"] as! Dictionary<String,String>
                print("- [" + folder["bool"]! + "]" + " " + folder["title"]!)
                let content = item["content"] as! [Dictionary<String,Any>]
                traverseTree(content)
            }else{
                print(" " + "- [" + (item["bool"] as! String) + "]" + " " + (item["title"] as! String))
            }
        }
    }
}