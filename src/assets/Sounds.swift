import Cocoa

class Sounds {
    static let path:String = "~/_projects/_code/_active/swift/GitSyncOSX/try_these_sounds/"
    static let add:NSSound? = NSSound(contentsOfFile:(path + "add.wav").tildePath, byReference:true)
    static let delete:NSSound? = NSSound(contentsOfFile:(path + "delete.wav").tildePath, byReference:true)
    static let disable:NSSound? = NSSound(contentsOfFile:(path + "disable.wav").tildePath, byReference:true)
    static let done:NSSound? = NSSound(contentsOfFile:(path + "done.wav").tildePath, byReference:true)
    static let enable:NSSound? = NSSound(contentsOfFile:(path + "enable.wav").tildePath, byReference:true)
    static let error:NSSound? = NSSound(contentsOfFile:(path + "error.wav").tildePath, byReference:true)
    static let play:NSSound? = NSSound(contentsOfFile:(path + "v.wav").tildePath, byReference:true)
    static let startup:NSSound? = NSSound(contentsOfFile:(path + "startup.wav").tildePath, byReference:true)
}
