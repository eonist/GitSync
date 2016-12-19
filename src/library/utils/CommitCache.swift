import Foundation

class CommitCache {
    /**
     * Read commits from disk (xml)
     */
    static func read()->XML{
        let url:String = "~/Desktop/sortedcommits.xml".tildePath
        let xml = FileParser.xml(url)
        return xml
    }
    /**
     * Write commits to disk (xml)
     */
    static func write(){
        
    }
}

