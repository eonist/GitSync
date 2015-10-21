import Foundation

public class SubTaskParser {
    /**
     * Returns an array with dictionaries <bool,title>
     *
     */
    public class func tasks(str:String)->[Dictionary<String,Any>]{
        let pattern:String = " \\- \\[( |X)\\] (.*?)(\\n|$)"
        let matches = RegExpParser.matches(str,pattern)//hello, world
        //matches.count//num of matches
        enum taskParts:Int{ case bool = 1, title }
        var taskItems = [Dictionary<String,Any>]()
        for match:NSTextCheckingResult in matches {
            //match.numberOfRanges//num of capturing groups
            //let a = (str as NSString).substringWithRange(match.rangeAtIndex(0))
            let bool = (str as NSString).substringWithRange(match.rangeAtIndex(taskParts.bool.rawValue))
            let title = (str as NSString).substringWithRange(match.rangeAtIndex(taskParts.title.rawValue))
            
            //print(" " + bool + " " + title)
            let taskItem:Dictionary<String,Any> = ["bool":bool,"title":title]
            taskItems.append(taskItem)
        }
        return taskItems
        
    }
}