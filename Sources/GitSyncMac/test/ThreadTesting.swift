import Foundation
@testable import Utils

class ThreadTesting {
    var startTime:NSDate?
    dynamic var isRunning = false
    var repoList:[[String:String]] = []
    
    var taskTerminatedCount:Int = 0
    var notificationCount:Int = 0
    var outputCount:Int = 0
    
    var timer:SimpleTimer?
    var tickerDate:NSDate?
    
    init(){
        //asyncTest()
        tickerDate = NSDate()//measure the time of the refresh
        timer = SimpleTimer(0.05,true,self,#selector(update))
    }
    /**
     * Testing running an NSTask on a background thread
     * 1. create, NSTask,NSPipe,LocalPath, Command and run the code
     * 2. attaches the task to a concurrent background-thread (spins up many cores at once)
     * 3. 
     */
    func asyncTest(){
        Swift.print("asyncTest")
        self.startTime = NSDate()//measure the time of the refresh
        Swift.print("run.before")
        let repoXML = FileParser.xml("~/Desktop/assets/xml/list.xml".tildePath)//~/Desktop/repo2.xml
        repoList = XMLParser.toArray(repoXML)//or use dataProvider
        Swift.print("repoList.count: " + "\(repoList.count)")
        repoList.forEach{
            let task = Process()
            let pipe = Pipe()
            let localPath:String = $0["local-path"]!
            let title:String = $0["title"]!
            run(localPath,title,task,pipe)
        }
        Swift.print("run.after")
    }
    /**
     *
     */
    func run(_ localPath:String,_ title:String,_ task:Process, _ pipe:Pipe){
        //1. Sets isRunning to true. this enables you to stop the process
        isRunning = true
        let taskQueue = DispatchQueue.global(qos: DispatchQoS.QoSClass.background)//swift 3-> let taskQueue = DispatchQueue.global(qos: DispatchQoS.QoSClass.background)
        //swift 3 update, the bellow line is totally changes in swift 3, do research
        taskQueue.async {
            
            //2. Creates a new Process object and assigns it to the TasksViewController‘s buildTask property. The launchPath property is the path to the executable you want to run. Assigns the BuildScript.command‘s path to the Process‘s launchPath, then assigns the arguments that were passed to runScript:to Process‘s arguments property. Process will pass the arguments to the executable, as though you had typed them into terminal.
            //self.tasks.append(NSTask())
            //Swift.print(title + " launched")
            //let localPath = "~/_projects/_code/_active/swift/GitSyncOSX"
            task.currentDirectoryPath = localPath
            task.launchPath = "/bin/sh"
            let cmd:String = "git rev-list HEAD --count"
            task.arguments = ["-c",cmd]//["echo", "hello world","  echo","again","&& echo again","\n echo again"]//["ls"]//"-c", "/usr/bin/killall Dock",
            
            //3.Process has a terminationHandler property that contains a block which is executed when the task is finished. This updates the UI to reflect that finished status as you did before.
            
            //this wont work, the NSNOtification will sometimes never complete
            task.terminationHandler = {/*Avoid using NSNotification if you use this callback, as it will block NSNotification from fireing sometimes*/
                task in
                //Swift.print("complete")
                let data:Data = pipe.fileHandleForReading.readDataToEndOfFile()/*retrive the date from the nstask output*/
                let output:String = NSString(data:data, encoding:String.Encoding.utf8.rawValue) as! String/*decode the date to a string*/
                Swift.print("completed " + "output.count: " + "\(output.trim("\n"))")
            }
            //1.//Creates an Pipe and attaches it to buildTask‘s standard output. Pipe is a class representing the same kind of pipe that you created in Terminal. Anything that is written to buildTask‘s stdout will be provided to this Pipe object.
            //self.pipes.append(NSPipe())//we create a new pipe for each task
            task.standardOutput = pipe
            
            //2.the fileHandleForReading is used to read the data in the pipe, You call waitForDataInBackgroundAndNotify on it to use a separate background thread to check for available data.
            pipe.fileHandleForReading.waitForDataInBackgroundAndNotify()//
            //self.captureStandardOutput(task, pipe,title)
            
            //4.In order to run the task and execute the script, calls launch on the Process object. There are also methods to terminate, interrupt, suspend or resume an Process.
            task.launch()
            
            //5.Calls waitUntilExit, which tells the Process object to block any further activity on the current thread until the task is complete. Remember, this code is running on a background thread. Your UI, which is running on the main thread, will still respond to user input.
            //task.waitUntilExit()//<-- not needed I think
        }
    }
    /**
     *
     */
    func captureStandardOutput(_ task:Process, _ pipe:Pipe,_ title:String) {
        //Swift.print("captureStandardOutput: \(title)")
        //1.//Creates an Pipe and attaches it to buildTask‘s standard output. Pipe is a class representing the same kind of pipe that you created in Terminal. Anything that is written to buildTask‘s stdout will be provided to this Pipe object.
        //self.pipes.append(NSPipe())//we create a new pipe for each task
        task.standardOutput = pipe
        
        //2.the fileHandleForReading is used to read the data in the pipe, You call waitForDataInBackgroundAndNotify on it to use a separate background thread to check for available data.
        pipe.fileHandleForReading.waitForDataInBackgroundAndNotify()//
        
        //3.Whenever data is available, waitForDataInBackgroundAndNotify notifies you by calling the block of code you register with NSNotificationCenter to handle NSFileHandleDataAvailableNotification.
        /*
        NSNotificationCenter.defaultCenter().addObserverForName(NSFileHandleDataAvailableNotification, object: pipe.fileHandleForReading, queue: nil){  notification -> Void in
        //4. Inside your notification handler, gets the data as an NSData object and converts it to a string.
        let output = pipe.fileHandleForReading.availableData
        let outputString:String = NSString(data:output, encoding:NSUTF8StringEncoding) as? String ?? ""/*decode the date to a string*/
        self.notificationCount++
        //Swift.print("notify: \(title) resutl:\(outputString.trim("\n")) count: \(self.notificationCount)")
        
        dispatch_async(dispatch_get_main_queue()){//back on the main thread
        self.outputCount++
        Swift.print("\(title) main-thread: result \(outputString.trim("\n")) Time-async:  \(abs(self.startTime!.timeIntervalSinceNow)) count: \(self.outputCount)")
        }
        /**/
        }*/
        
        
        /*When Using NSFileHandleDataAvailableNotification and  NSTaskDidTerminateNotification together you can only get data in one location as you sort of empty the pipe when you get the data*/
        /*NSNotificationCenter.defaultCenter().addObserverForName(NSTaskDidTerminateNotification, object: task, queue: nil){  notification -> Void in
        
        let data:NSData = pipe.fileHandleForReading.readDataToEndOfFile()/*retrive the date from the nstask output*/
        let output:String = NSString(data:data, encoding:NSUTF8StringEncoding) as! String/*decode the date to a string*/
        
        Swift.print("completed " + "output.count: " + "\(output.trim("\n"))")
        }*/
        
        
        
        //6.Finally, repeats the call to wait for data in the background. This creates a loop that will continually wait for available data, process that data, wait for available data, and so on.
        //pipe.fileHandleForReading.waitForDataInBackgroundAndNotify()
    }
    /**
     *
     */
    func stopTask(){
        if isRunning {
            //task.terminate()
        }
    }
    @objc func update() {
        Swift.print("tick" + "\(abs(tickerDate!.timeIntervalSinceNow))")
        //timer!.timer!.fireDate
    }
   
}
