import Cocoa
@testable import Utils
@testable import Element
//enum
/**
 * Right click context menu
 */
class RepoContextMenu:NSMenu{
    var rightClickItemIdx:[Int]?
    var clipBoard:XML?
    var treeList:TreeListable3
    init(_ treeList:TreeListable3) {
        self.treeList = treeList//Element - mac
        super.init(title:"Contextual menu")
        var menuItems:[(title:RepoMenuItem,selector:Foundation.Selector)] = []
        menuItems.append((.newFolder, #selector(newFolder)))
        menuItems.append((.newRepo, #selector(newRepo)))
        menuItems.append((.duplicate, #selector(duplicate)))
        menuItems.append((.copy, #selector(doCopy)))
        menuItems.append((.cut, #selector(cut)))
        menuItems.append((.paste, #selector(paste)))
        menuItems.append((.delete, #selector(delete)))
        menuItems.append((.moveUp, #selector(moveUp)))
        menuItems.append((.moveDown, #selector(moveDown)))
        menuItems.append((.moveTop, #selector(moveToTop)))
        menuItems.append((.moveBottom, #selector(moveToBottom)))
        menuItems.append((.showInFinder, #selector(showInFinder)))
        menuItems.append((.openUrl, #selector(openURL)))
        //continue here: add Open in github
        menuItems.forEach{
            let menuItem = NSMenuItem(title: $0.title.rawValue, action: $0.selector, keyEquivalent: "")
            self.addItem(menuItem)
            menuItem.target = self
        }
        self.insertItem(NSMenuItem.separator(), at: 6)/*Separator*/
        self.insertItem(NSMenuItem.separator(), at: 11)/*Separator*/
    }
    required init(coder decoder: NSCoder) {fatalError("init(coder:) has not been implemented")}
}
/**
 * Right click Context menu methods
 */
extension RepoContextMenu{
    
    /**
     * TODO: A bug is that when you add a folder and its the last item then the list isnt resized
     */
    func newFolder(sender:AnyObject) {
        Swift.print("newFolder")
        let idx = rightClickItemIdx!
        let xmlStr:String = "<item title=\"New folder\" isOpen=\"false\" ></item>"//hasChildren=\"true\"
        let tree = TreeConverter.tree(xmlStr.xml)//treeList.node.addAt(newIdx(idx), a.xml)//"<item title=\"New folder\"/>"
        let newIdx = Utils.newIdx(treeList,idx)
        treeList.insert(newIdx,tree)
        Swift.print("Promt folder name popup")
    }
    func newRepo(sender:AnyObject) {
        Swift.print("newRepo")
        //treeList.insert([1],Tree("item",[],nil,["title":"Fish"]))/*Insert item at
        let idx = rightClickItemIdx!
        Swift.print("idx: " + "\(idx)")
        let props:[String:String] = ["title":"New repo","local-path":"~/Desktop/test","remote-path":"https://github.com/eonist/test.git","interval":"30","keychain-item-name":"eonist","branch":"master","broadcast":"true","subscribe":"true","auto-sync":"true"]
        let tree:Tree = Tree.init("item", [], nil, props)
        let newIdx = Utils.newIdx(treeList,idx)
        treeList.insert(newIdx,tree)
        //Swift.print("Promt repo name popup")
    }
    func duplicate(sender: AnyObject) {
        Swift.print("duplicate")
        let idx = rightClickItemIdx!
        Swift.print("idx: " + "\(idx)")
        if let tree = treeList.treeDP.tree[idx] {
            let newIdx = Utils.newIdx(treeList,idx)
            treeList.insert(newIdx, tree)
        }
    }
    func doCopy(sender: AnyObject) {
        Swift.print("copy")
        let idx = rightClickItemIdx!
        Swift.print("idx: " + "\(idx)")
        if let tree = treeList.treeDP.tree[idx] {
            clipBoard = tree.xml
            Swift.print("clipBoard: " + "\(clipBoard)")
        }
    }
    func cut(sender: AnyObject) {
        Swift.print("cut")
        let idx = rightClickItemIdx!
        Swift.print("idx: " + "\(idx)")
        if let tree:Tree = treeList.treeDP.tree[idx] {
            treeList.remove(idx)
            clipBoard = tree.xml
            Swift.print("clipBoard: " + "\(clipBoard)")
        }
    }
    func paste(sender: AnyObject) {
        Swift.print("paste")
        if let idx = rightClickItemIdx, let clipBoard:XML = clipBoard{
            //Swift.print("clipBoard: " + "\(self.clipBoard)")
            let newIdx = Utils.newIdx(treeList,idx)
            let tree = TreeConverter.tree(clipBoard)
            treeList.insert(newIdx, tree)
        }
    }
    func delete(sender:AnyObject) {
        Swift.print("delete")
        if let idx = rightClickItemIdx {
            _ = treeList.remove(idx)
        }
    }
    /*move up down top bottom.*/
    func moveUp(sender: AnyObject){
        //let idx = rightClickItemIdx!
        
        //continue here 🏀
            //get the cut paste etc working 👈
            // return 3d idx and update 2d list. Check collapse first to see how it works. also how remove and add works etc
        if let idx = rightClickItemIdx {
            let idxAbove:Int = TreeModifier.moveUp(&treeList.treeDP.tree, idx)//_ = TreeListModifier.moveUp(treeList, idx)
            
        }
        
    }
    func moveDown(sender: AnyObject){
        /*let idx = rightClickItemIdx!
         _ = TreeListModifier.moveDown(treeList, idx)*/
    }
    func moveToTop(sender: AnyObject){
        /*let idx = rightClickItemIdx!
         _ = TreeList3AdvanceModifier.moveToTop(treeList, idx)*/
    }
    func moveToBottom(sender: AnyObject){
        /*let idx = rightClickItemIdx!
         _ = TreeList3AdvanceModifier.moveToBottom(treeList, idx)*/
    }
    func showInFinder(sender: AnyObject){
        let idx = rightClickItemIdx!
        let hasChildren:Bool = TreeList3Asserter.hasChildren(treeList,idx)
        if !hasChildren {/*Only repos can be opened in finder*/
            let repoItem = RepoUtils.repoItem(treeList.treeDP.tree.xml, idx)
            if FileAsserter.exists(repoItem.localPath.tildePath) {/*make sure local-path exists*/
                FileUtils.showFileInFinder(repoItem.localPath)
            }
        }
    }
    func openURL(sender:AnyObject){
        let idx = rightClickItemIdx!
        let hasChildren:Bool = TreeList3Asserter.hasChildren(treeList,idx)
        if !hasChildren {/*Only repos can be opened in finder*/
            let repoItem = RepoUtils.repoItem(treeList.treeDP.tree.xml, idx)
            NetworkUtils.openURLInDefaultBrowser(repoItem.remotePath)
        }
    }
}
enum RepoMenuItem:String {
    case newFolder = "New folder"
    case newRepo = "New repo"
    case duplicate = "Duplicate"
    case copy = "Copy"
    case cut = "Cut"
    case paste = "Paste"
    case delete = "Delete"
    case moveUp = "Move up"
    case moveDown = "Move down"
    case moveTop = "Move top"
    case moveBottom = "Move bottom"
    case showInFinder = "Show in finder"
    case openUrl = "Open URL"
}
private class Utils {
    /**
     * Returns a new idx
     * NOTE: isFolder -> add within, is not folder -> add bellow
     */
    static func newIdx(_ treeList:TreeListable3,_ idx:[Int]) -> [Int] {
        var idx = idx
        //let itemData:ItemData3 = TreeList3Utils.itemData(treeList, idx)
        if let hasChildren = treeList[idx,"hasChildren"],hasChildren == "true"{//isFolder, add within
            idx += [0]
        }else{/*is not folder, add bellow*/
            idx[idx.count-1] = idx.last! + 1
        }
        return idx
    }
}
