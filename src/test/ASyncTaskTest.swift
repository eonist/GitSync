import Foundation
/**
 * 1. Launch multiple NSTasks on the background thread concurrently
 * 2. Completion callback with result on the main thread
 * 3. Batch completion callback on main thread (all tasks completed) use own extension method to launch batch tasks
 */
class ASyncTaskTest {
    var startTime:NSDate?
    dynamic var isRunning = false
    var repoList:[[String:String]] = []
    
    var taskTerminatedCount:Int = 0
    var notificationCount:Int = 0
    var outputCount:Int = 0
    
    var timer:Timer?
    var tickerDate:NSDate?
    /**
     * Testing running an NSTask on a background thread
     * 1. Create, NSTask,NSPipe,LocalPath, Command and run the code
     * 2. Attaches the task to a concurrent background-thread (spins up many cores at once)
     * 3. Completion callback on the main thread -> (NSTask,Output)
     * 4. When the entire batch of tasks has completed
     */
    init(){
        Swift.print("ASyncTaskTest.init()")
        self.startTime = NSDate()//measure the time of the refresh
        
        tickerDate = NSDate()//measure the time of the refresh
        timer = Timer(0.05,true,self,"update")
        
        Swift.print("run.before")
        let repoXML = FileParser.xml("~/Desktop/assets/xml/list.xml".tildePath)//~/Desktop/repo2.xml
        repoList = XMLParser.toArray(repoXML)//or use dataProvider
        Swift.print("repoList.count: " + "\(repoList.count)")
        repoList.forEach{
            let task = NSTask()
            let pipe = NSPipe()
            let localPath:String = $0["local-path"]!
            let title:String = $0["title"]!
            run(localPath,title,task,pipe)
        }
        Swift.print("run.after")
    }
    /**
     * NOTE: task.waitUntilExit() //is only needed if we stream data
     */
    func run(localPath:String,_ title:String,_ task:NSTask, _ pipe:NSPipe){
        let taskQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0)//swift 3-> let taskQueue = DispatchQueue.global(qos: DispatchQoS.QoSClass.background)
        dispatch_async(taskQueue, { () -> Void in
            task.currentDirectoryPath = localPath
            task.launchPath = "/bin/sh"
            let cmd:String = "git rev-list HEAD --count"
            task.arguments = ["-c",cmd]//["echo", "hello world","  echo","again","&& echo again","\n echo again"]//["ls"]//"-c", "/usr/bin/killall Dock",
            task.terminationHandler = { task in/*Avoid using NSNotification if you use this callback, as it will block NSNotification from fireing sometimes*/
                let data:NSData = pipe.fileHandleForReading.readDataToEndOfFile()/*retrive the date from the nstask output*/
                let output:String = NSString(data:data, encoding:NSUTF8StringEncoding) as! String/*decode the date to a string*/
                Swift.print("completed " + "output.count: " + "\(output.trim("\n"))")
            }
            task.standardOutput = pipe//1.//Creates an Pipe and attaches it to buildTask‘s standard output. Pipe is a class representing the same kind of pipe that you created in Terminal. Anything that is written to buildTask‘s stdout will be provided to this Pipe object.
            pipe.fileHandleForReading.waitForDataInBackgroundAndNotify()//2.the fileHandleForReading is used to read the data in the pipe, You call waitForDataInBackgroundAndNotify on it to use a separate background thread to check for available data.
            task.launch()/*In order to run the task and execute the script, calls launch on the Process object. There are also methods to terminate, interrupt, suspend or resume an Process.*/
        })
    }
}


//continue here:
    //Try to sketch out scenarios you need:🏀
    //maybe you need background serial qeues for lining up tasks.
        //how do we return the result for such a scenario
    //complete the post about Threading ✅