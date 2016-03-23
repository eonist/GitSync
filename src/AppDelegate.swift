import Cocoa
/**
 * This is the main class for the application
 */
@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    weak var window: NSWindow!
    var repoFilePath:String = "~/Desktop/repo.xml"
    var win:NSWindow?/*<--The window must be a class variable, local variables doesnt work*/
    func applicationDidFinishLaunching(aNotification: NSNotification) {
        /*
        
        let root:Node = Node()
        root.children.append(Node(["title":"Dog"]))
        root.children.append(Node(["title":"Pizza"]))
        let computerNode = Node(["title":"Computer"])
        computerNode.children.append(Node(["title":"ram"]))
        computerNode.children.append(Node(["title":"cpu"]))
        computerNode.children.append(Node(["title":"screen"]))
        root.children.append(computerNode)
        
        let result = NodeParser.nodeAt(root, [2,1])!.data["title"]//cpu
        Swift.print("result: " + "\(result!)")
        
        */
        
        
        
        
        Swift.print("\(XMLParser.toXML(["name":[]]))")
        
        
        /*
        NodeModifier.removeAll(root)
        Swift.print("root.children.count: " + "\(root.children.count)")
        */
        
        //let xmlStr:String = "<media><book><novel/><biography/></book><music><cd/><cassette/></music><film><dvd/><vhs/><blueray/><dvd>movie.mkv</dvd></film><media>"
        /*
        let xmlStr:String = "<subCategories><category><id>someId</id><name>someName</name></category></subCategories>"
        let xml:NSXMLElement = XMLParser.root(xmlStr)!
        Swift.print(xml.children![0].childCount)//2
        
        let node:Node = NodeParser.node(xml)
        Swift.print("node.children.count: " + "\(node.children.count)")
        */
        
        //Continue here: go from node to xml. See your xml string building implementation
        //Continue here: Then start doing node manipulation, removal, additions, updates, creation. aka crud
        
        
        /*
        let test2 = ["someValue":"abc","someObject":["name":"john", "anotherObject":["cow":"power"]]]
        let result2 = XMLParser.toXML(test2,"user")//<user someValue="abc"><someObject name="john"><anotherObject cow="power"/></someObject></user>
        Swift.print("result2: " + "\(result2)")
        */
        
        
        /*Swift.print("hello world")
        let result = AdvanceArrayParser.childAt([["red","green"],[["four","five"],[1,2,3]]],[1,0,1])//[five]
        Swift.print("result: " + "\(result)")*/
        
        /*let arr = ["a","b","c","d","e","f"]//["b", "c", "d", "e", "f"]
        let result = ArrayModifier.slice2(arr, 1, arr.count)
        Swift.print("result: " + "\(result)")*/
        
        /*
        let result = arr.slice(1, arr.count-1)
        Swift.print("result: " + "\(result)")
        Swift.print("arr: " + "\(arr)")
        */
        
        /*StyleManager.addStyle("Window{fill:white;corner-radius:4px;}")//E8E8E8//<--you should target a bg element not the window it self, since now everything inherits these values
        StyleManager.addStylesByURL("~/Desktop/css/gitsync.css")
        win = GitSyncWin(300,400)/*Init the window*/
        let app:NSApplication = aNotification.object as! NSApplication/*grab the app instance from the notification*/
        app.windows[0].close()/*close the initial non-optional default window*/*/
    }
    func applicationWillTerminate(aNotification: NSNotification) {
        print("Good-bye")
    }
}





/*
let repoXML = FileParser.xml(repoFilePath.tildePath)
let repoList = XMLParser.toArray(repoXML)
Swift.print("repoList.count: " + "\(repoList.count)")

GitSync.initCommit(repoList[0], "master")


GitSync.initPush(repoList[0], "master")

*/
        