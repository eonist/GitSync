import Foundation
/**
 * 1. Launch multiple NSTasks on the background thread concurrently
 * 2. Completion callback with result on the main thread
 * 3. Batch completion callback on main thread (all tasks completed) use own extension method to launch batch tasks
 */
class ASyncTaskTest {
    var startTime:NSDate?
    var timer:Timer?
    var tickerDate:NSDate?
    var repoList:[[String:String]] = []
    var results:[String] = []
    //dynamic var isRunning = false
    //var taskTerminatedCount:Int = 0
    //var notificationCount:Int = 0
    //var outputCount:Int = 0
    
    //TODO: retrive all commits needed to populate CommitsDB async (time it) 🏀
    //TODO: Test parts of the gitsync algo on a background thread (a couple of steps)
    
    /**
     * Testing running an NSTask on a background thread
     * 1. Create, NSTask,NSPipe,LocalPath, Command and run the code
     * 2. Attaches the task to a concurrent background-thread (spins up many cores at once)
     * 3. Completion callback on the main thread -> (work-item-index,Output)
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
        for (index,element) in repoList.enumerate(){
            let task = NSTask()
            let localPath:String = element["local-path"]!
            //let title:String = element["title"]!
            task.currentDirectoryPath = localPath
            task.launchPath = "/bin/sh"
            let cmd:String = "git rev-list HEAD --count"
            task.arguments = ["-c",cmd]//["echo", "hello world","  echo","again","&& echo again","\n echo again"]//["ls"]//"-c", "/usr/bin/killall Dock",
            let pipe = NSPipe()
            task.standardOutput = pipe//1.//Creates an Pipe and attaches it to buildTask‘s standard output. Pipe is a class representing the same kind of pipe that you created in Terminal. Anything that is written to buildTask‘s stdout will be provided to this Pipe object
            run(task,index)
        }
        Swift.print("run.after")
    }
    /**
     * NOTE: task.waitUntilExit() //is only needed if we stream data
     */
    func run(task:NSTask,_ index:Int){
        dispatch_async(bgQueue(), { () -> Void in
            task.terminationHandler = { task in/*Avoid using NSNotification if you use this callback, as it will block NSNotification from fireing sometimes*/
                dispatch_async(mainQueue()){/*back on the main thread*/
                    let data:NSData = task.standardOutput!.fileHandleForReading.readDataToEndOfFile()/*retrive the date from the nstask output*/
                    let output:String = (NSString(data:data, encoding:NSUTF8StringEncoding) as! String).trim("\n")/*decode the date to a string*/
                    self.complete(output,index)
                }
            }
            task.launch()/*In order to run the task and execute the script, calls launch on the Process object. There are also methods to terminate, interrupt, suspend or resume an Process.*/
        })
    }
    /**
     * PARAM: index: indicates which task completed
     */
    func complete(result:String,_ index:Int){
        Swift.print("index: " + "\(index)")
        self.results += result
        //Swift.print("\(title) main-thread: result \(output) Time-async:  \(abs(self.startTime!.timeIntervalSinceNow)) count: \(self.outputCount)")
        if(self.results.count == self.repoList.count){
            Swift.print("all tasks completed")
            self.results.forEach{Swift.print($0)}//all tasks are comeplete, do something
        }
    }
}

//Async work on background threads: (use this when you need a batch of values retrived, and their order of completion doesnt matter)

//1. Define a bunch of work ()
    //do the work item async
    //on work item complete
//2. Define a completion handler for the work
//3. launch the work
//4. the completion handler is notified, read the data from an array on the main thread
//5. Error handler -> you define this if a task fails, look at the failure code of the nstask and handle it accordingly.

//Serial work on a background thread: (use this when one thing after the other has to happen, and their order of completion matters)

//1. define a session of tasks on a async - serial: qeue
//2. when the last task completes call a completion handler on main thread
//3. complete handles the result and moves on to other potential tasks


// At first we should string many sessions together on a bg thread like in GitSync applescript, this avoids problems while keeping the UI snappy. later we can add more concurrency



