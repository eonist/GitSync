import Foundation
@testable import Utils

class CommitDPCache {
    static var url:String = "~/Desktop/sortedcommits.xml"
    /**
     * Read commits from disk (xml)
     */
    static func read()->CommitDP{
        let url:String = CommitDBCache.url.tildePath
        let xml = FileParser.xml(url)
        //Swift.print("xml.XMLString: " + "\(xml.XMLString)")
        let commitDP:CommitDP? = CommitDB.unWrap(xml)
        //Swift.print("Printing sortedArr after unwrap: ")
        //commitDB.sortedArr.forEach{Swift.print($0.sortableDate)}
        return commitDP!
    }
    /**
     * Write commits to disk (xml)
     */
    static func write(_ commitDB:CommitDP){
        let xml = Reflection.toXML(commitDB)/*Reflection*/
        //Swift.print(xml.XMLString)
        let contentToWriteToDisk = xml.xmlString
        _ = FileModifier.write(CommitDBCache.url.tildePath, contentToWriteToDisk)
    }
}

