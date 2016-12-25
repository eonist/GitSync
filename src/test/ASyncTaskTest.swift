import Foundation
/**
 * 1. Launch multiple NSTasks on the background thread concurrently
 * 2. Completion callback with result on the main thread
 * 3. Batch completion callback on main thread (all tasks completed) use own extension method to launch batch tasks
 */
class ASyncTaskTest {
    /**
     * Testing running an NSTask on a background thread
     * 1. Create, NSTask,NSPipe,LocalPath, Command and run the code
     * 2. Attaches the task to a concurrent background-thread (spins up many cores at once)
     * 3. Completion callback on the main thread
     */
    init(){
        
    }
}
