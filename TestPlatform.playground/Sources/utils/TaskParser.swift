import Foundation

public class TaskParser {
    private static var taskFolder:String = "(?<! )- \\[(?:X| )\\] [\\w]*?\\n"
    private static var childContent:String = "[\\w\\-\\[ X\\]\\n]*?"
    private static var pattern:String =   "(" + //open capture group "task folder"
        taskFolder + // taskFolder "task-bool" and task "text"
        ")" + //close capture group "task folder"
        "(" + //open capture group for child content of task folder
        childContent + //capture child content of task folder
        ")" + //open capture group for child content of task folder
        "(?=" + //open look ahead group (non-consuming)
        taskFolder + // match the "task folder pattern"
        "|" + //or
        "$" + //match end of string
    ")"//close look ahead group (non-consuming)
    /**
     * Returns an array of dictionaries that contains the task folder and the sub tasks
     */
    public class func tasks(str:String)->[Dictionary<String,Any>]{
        RegExpParser.match(str, taskFolder + childContent + "$")[0]
        let matches = RegExpParser.matches(str, pattern)
        //matches.count
        enum FolderTaskParts:Int{ case folder = 1, content }//2 capture groups: taskFolder and child content
        var folderTasks = [Dictionary<String,Any>]()
        for match:NSTextCheckingResult in matches {
            match.numberOfRanges
            let folder = (str as NSString).substringWithRange(match.rangeAtIndex(FolderTaskParts.folder.rawValue))
            let folderTaskItem:Dictionary<String,String> = FolderTaskParser.task(folder)//Extracts bool value and title value
            //print(folder)
            let content = (str as NSString).substringWithRange(match.rangeAtIndex(FolderTaskParts.content.rawValue))
            //print(content)
            let theContent:[Dictionary<String,Any>] = SubTaskParser.tasks(content)//
            folderTasks.append(["folder":folderTaskItem,"content":theContent])
        }
        return folderTasks
    }
}