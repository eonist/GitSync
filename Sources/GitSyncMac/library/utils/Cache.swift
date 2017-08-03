import Foundation
@testable import Utils
typealias CommitDPCache = Cache//temp
class  Cache{
    //TODO: ⚠️️ move sortedCommits into .bundle
    
    /**
     * Read commits from disk (xml)
     */
    static func read()->CommitDP{
        let url:String = Config.Bundle.commitCacheURL.tildePath
        let xml = FileParser.xml(url)
        //Swift.print("xml.XMLString: " + "\(xml.XMLString)")
        let commitDP:CommitDP? = CommitDP.unWrap(xml)
        //Swift.print("Printing sortedArr after unwrap: ")
        //commitDB.sortedArr.forEach{Swift.print($0.sortableDate)}
        return commitDP!
    }
    /**
     * Write commits to disk (xml)
     */
    static func write(_ commitDP:CommitDP){
        //Swift.print("💾 write begin")
        let xml:XML = Reflection.toXML(commitDP)/*Reflection*/
        //Swift.print(xml.xmlString)
        let contentToWriteToDisk = xml.xmlString
        _ = FileModifier.write(Config.Bundle.commitCacheURL.tildePath, contentToWriteToDisk)
        //Swift.print("💾 write end")
    }
}

