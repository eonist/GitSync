import Foundation

class CommitDBCache {
    static var url:String = "~/Desktop/sortedcommits.xml"
    /**
     * Read commits from disk (xml)
     */
    static func read()->CommitDB{
        let url:String = CommitDBCache.url.tildePath
        let xml = FileParser.xml(url)
        //Swift.print("xml.XMLString: " + "\(xml.XMLString)")
        let commitDB:CommitDB = CommitDB.unWrap(xml)!
        //Swift.print("Printing sortedArr after unwrap: ")
        //commitDB.sortedArr.forEach{Swift.print($0.sortableDate)}
        return commitDB
    }
    /**
     * Write commits to disk (xml)
     */
    static func write(commitDB:CommitDB){
        let xml = Reflection.toXML(commitDB)/*Reflection*/
        //Swift.print(xml.XMLString)
        let contentToWriteToDisk = xml.XMLString
        FileModifier.write(CommitDBCache.url.tildePath, contentToWriteToDisk)
    }
}

