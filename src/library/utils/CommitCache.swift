import Foundation

class CommitCache {
    /**
     * Read commits from disk (xml)
     */
    static func read()->CommitDB{
        let url:String = "~/Desktop/sortedcommits.xml".tildePath
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
        Swift.print(xml.XMLString)//Output: <Temp><color type="NSColor">FFFF0000</color></Temp>
        
        
        
        
        let data:XML = "<data></data>".xml
        let cssFileDates:XML = StyleCache.cssFileDates()
        data.appendChild(cssFileDates)
        let styles:XML = "<styles></styles>".xml
        //Swift.print("StyleManager.styles.count: " + "\(StyleManager.styles.count)")
        StyleManager.styles.forEach{
            let xml = Reflection.toXML($0)
            styles.appendChild(xml)
            //Swift.print("xml.XMLString: " + "\(xml.XMLString)")
        }
        data.appendChild(styles)
        let contentToWriteToDisk = data.XMLString
        FileModifier.write("~/Desktop/styles.xml".tildePath, contentToWriteToDisk)
    }
}

