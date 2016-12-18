import Foundation

class CommitViewUtils {
    /**
     *
     */
    static func processCommitData(repoTitle:String,_ commitData:CommitData)-> Dictionary<String, String>{
        let date:NSDate = GitLogParser.date(commitData.date)
        //Swift.print("date.shortDate: " + "\(date.shortDate)")
        let relativeTime = DateParser.relativeTime(NSDate(),date)[0]
        let relativeDate:String = relativeTime.value.string + relativeTime.type/*create date like 3s,4m,5h,6w,2y*/
        //Swift.print("relativeDate: " + "\(relativeDate)")
        let descendingDate:String = DateParser.descendingDate(date)
        //Swift.print(">"+descendingDate+"<")
        let compactBody:String = GitLogParser.compactBody(commitData.body)/*compact the commit msg body*/
        //Swift.print("compactBody: " + "\(compactBody)")
        let subject:String = StringParser.trim(commitData.subject, "'", "'")
        let processedCommitData:Dictionary<String, String> = ["repo-name":repoTitle,"contributor":commitData.author,"title":subject,"description":compactBody,"date":relativeDate,"sortableDate":descendingDate,"hash":commitData.hash]
        return processedCommitData
    }
    /**
     * PARAM: max = max Items Allowed per repo
     */
    static func commitItems(localPath:String,_ max:Int)->[String]{
        let commitCount:String = GitParser.commitCount(localPath)/*Get the commitCount of this repo*/
        //Swift.print("commitCount: " + ">\(commitCount)<")
        
        let length:Int = commitCount.int > max ? max : commitCount.int//20 = maxCount
        //Swift.print("length: " + "\(length)")
        
        var args:[String] = []
        let formating:String = " --pretty=format:Hash:%h%nAuthor:%an%nDate:%ci%nSubject:%s%nBody:%b"//"-3 --oneline"//
        for i in 0..<length{
            let cmd:String = "git show head~" + "\(i)" + formating + " --no-patch"//--no-patch suppresses the diff output of git show
            args.append(cmd)
        }
        return args
    }
    /**
     * Sets up a NSTask
     */
    static func configOperation(args:[String],_ localPath:String,_ repoTitle:String) -> (task:NSTask,pipe:NSPipe,repoTitle:String){
        let task = NSTask()
        task.currentDirectoryPath = localPath
        task.launchPath = "/bin/sh"//"/usr/bin/env"//"/bin/bash"//"~/Desktop/my_script.sh"//
        task.arguments = ["-c",args[0]]//["echo", "hello world","  echo","again","&& echo again","\n echo again"]//["ls"]//"-c", "/usr/bin/killall Dock",
        let pipe = NSPipe()
        task.standardOutput = pipe
        //task.waitUntilExit()/*not needed if we use NSNotification*/
        return (task,pipe,repoTitle)
    }
}

//let processedCommitData:Dictionary<String, String> = ["repo-name":repoTitle,"contributor":commitData.author,"title":subject,"description":compactBody,"date":relativeDate,"sortableDate":descendingDate,"hash":commitData.hash]
/**
 * NOTE: Using struct is justified because the data is never modified. Just stored and reproduced
 */
struct Commit{
    let repoName:String
    let contributor:String
    let title:String
    let description:String
    let date:String
    let sortableDate:Int
    let hash:String
    init(_ repoName:String,_ contributor:String,_ title:String,_ description:String,_ date:String,_ sortableDate:Int,_ hash:String){
        
    }
}