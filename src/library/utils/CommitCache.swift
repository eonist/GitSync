import Foundation

class CommitCache {
    static var url:String = "~/Desktop/sortedcommits.xml"
    /**
     * Read commits from disk (xml)
     */
    static func read()->CommitDB{
        let url:String = CommitCache.url.tildePath
        let xml = FileParser.xml(url)
        let commitDB:CommitDB = CommitDB.unWrap(xml)!/*UnWrapping*/
        Swift.print("Printing sortedArr after unwrap: ")
        commitDB.sortedArr.forEach{Swift.print($0.sortableDate)}
        return commitDB
    }
    /**
     * Write commits to disk (xml)
     */
    static func write(commitDB:CommitDB){
        let xml = Reflection.toXML(commitDB)/*Reflection*/
        //Swift.print(xml.XMLString)
        let contentToWriteToDisk = xml.XMLString
        FileModifier.write(CommitCache.url.tildePath, contentToWriteToDisk)
    }
}

