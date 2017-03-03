import Foundation
@testable import Utils
typealias CommitDPCache = Cache//temp
class  Cache{
    static var url:String = "~/Desktop/sortedcommits.xml"
    /**
     * Read commits from disk (xml)
     */
    static func read()->CommitDP{
        let url:String = CommitDPCache.url.tildePath
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
        _ = FileModifier.write(CommitDPCache.url.tildePath, contentToWriteToDisk)
        //Swift.print("💾 write end")
    }
}

