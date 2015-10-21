import Foundation

public class FolderTaskParser {
    /**
    * Returns A Dictionary with bool value and title
    */
    public class func task(str:String)->Dictionary<String,String>{
        let folderTaskPattern:String = "\\- \\[( |X)\\] (.*?)\\n"//you can also use the folderPattern
        let theMatches = RegExpParser.matches(str,folderTaskPattern)//hello, world
        
        enum FolderParts:Int{ case bool = 1, title }
        
        //theMatches[0].numberOfRanges//num of capturing groups
        let bool = (str as NSString).substringWithRange(theMatches[0].rangeAtIndex(FolderParts.bool.rawValue))
        let title = (str as NSString).substringWithRange(theMatches[0].rangeAtIndex(FolderParts.title.rawValue))
        //print(bool + " " + title)
        let parts:Dictionary<String,String> = ["bool":bool,"title":title]
        
        return parts
    }
}