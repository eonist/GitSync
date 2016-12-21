import Foundation

class CommitViewUtils {
    typealias ProcessedCommitData = (date:NSDate,relativeDate:String,descendingDate:String,body:String,subject:String,hash:String,author:String)
    typealias CommitLogOperation = (task:NSTask,pipe:NSPipe,repoTitle:String,repoIndex:Int)
    /**
     *
     */
    static func processCommitData(repoTitle:String,_ commitData:CommitData)->ProcessedCommitData{
        let date:NSDate = GitLogParser.date(commitData.date)
        //Swift.print("date.shortDate: " + "\(date.shortDate)")
        let relativeTime:(value:Int,type:String) = DateParser.relativeTime(NSDate(),date)[0]
        let relativeDate:String = relativeTime.value.string + relativeTime.type/*create date like 3s,4m,5h,6w,2y*/
        //Swift.print("relativeDate: " + "\(relativeDate)")
        let descendingDate:String = DateParser.descendingDate(date)
        //Swift.print(">"+descendingDate+"<")
        let compactBody:String = GitLogParser.compactBody(commitData.body)/*compact the commit msg body*/
        //Swift.print("compactBody: " + "\(compactBody)")
        let subject:String = StringParser.trim(commitData.subject, "'", "'")
        return (date,relativeDate,descendingDate,compactBody,subject,commitData.hash,commitData.author)
    }
    /**
     * Converter
     */
    static func processCommitData(repoTitle:String,_ commitData:CommitData)-> Dictionary<String, String>{
        let data:ProcessedCommitData = processCommitData(repoTitle,commitData)
        let dict:Dictionary<String, String> = ["repo-name":repoTitle,"contributor":commitData.author,"title":data.subject,"description":data.body,"date":data.relativeDate,"sortableDate":data.descendingDate,"hash":commitData.hash]
        return dict
    }
    /**
     * Converter
     */
    static func processCommitData(repoTitle:String,_ commitData:CommitData)->Commit{
        let data:ProcessedCommitData = processCommitData(repoTitle,commitData)
        let commit:Commit = Commit(repoTitle,data.author, data.subject, data.body, data.relativeDate, data.descendingDate.int, data.hash,0)
        //return
        return commit
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
    static func configOperation(args:[String],_ localPath:String,_ repoTitle:String, _ repoIndex:Int) -> CommitLogOperation{
        let task = NSTask()
        task.currentDirectoryPath = localPath
        task.launchPath = "/bin/sh"//"/usr/bin/env"//"/bin/bash"//"~/Desktop/my_script.sh"//
        task.arguments = ["-c",args[0]]//["echo", "hello world","  echo","again","&& echo again","\n echo again"]//["ls"]//"-c", "/usr/bin/killall Dock",
        let pipe = NSPipe()
        task.standardOutput = pipe
        //task.waitUntilExit()/*not needed if we use NSNotification*/
        return (task,pipe,repoTitle,repoIndex)
    }
}