import Foundation

public class TaskModifier{
    /*
     * Sorts trees
     * Note: this method is recursive
     * TODO: May need to use inout with the arr arg here.
     */
    public class func sort(arr:[Dictionary<String,Any>], _ reverse:Bool = false)->[Dictionary<String,Any>]{
        var completeTasks:[Dictionary<String,Any>] = []
        var inCompleteTasks:[Dictionary<String,Any>] = []
        
        for var taskItem:[String:Any] in arr{
            if (taskItem["folder"] != nil)  {//taskItem is a folder
                if let content = taskItem["content"] as? [Dictionary<String, Any>] {//continue here, needs a typed class, dictionaries wont cooperate! or figure out casting dictionaries.
                    let folder = taskItem["folder"] as! Dictionary<String, String>
                    //print(folder!["bool"]! + " " + folder!["title"]!)
                    //print(" has content")
                    taskItem["content"] = sort(content,reverse)//Sort the subTasks (recursively!!!)
                    (folder["bool"]! == "X") != reverse ? completeTasks.append(taskItem) : inCompleteTasks.append(taskItem)
                }
            }else{//taskItem is a subTask
                //print(" " + (taskItem["bool"] as! String) + " " + (taskItem["title"] as! String))
                ((taskItem["bool"]! as! String) == "X") != reverse ? completeTasks.append(taskItem) : inCompleteTasks.append(taskItem)
            }
        }
        let returnArr = completeTasks + inCompleteTasks
        return returnArr
    }
}
