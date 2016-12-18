import Foundation

/**
 * DISCUSSION: Using struct is justified because the data is never modified. Just stored and reproduced
 */
struct Commit{
    let repoName:String
    let contributor:String
    let title:String
    let description:String
    let date:String
    let sortableDate:Int
    let hash:String
    let repoId:Int/*internal id system*/
    init(_ repoName:String,_ contributor:String,_ title:String,_ description:String,_ date:String,_ sortableDate:Int,_ hash:String, _ repoId:Int){
        self.repoName = repoName
        self.contributor = contributor
        self.title = title
        self.description = description
        self.date = date
        self.sortableDate = sortableDate
        self.hash = hash
        self.repoId = repoId
    }
}

extension Commit:Comparable{
}
//this makes SortableCommit unwrappable (XML->SortableCommit)
extension Commit:UnWrappable{
    static func unWrap<T>(xml:XML) -> T? {
        let repoName:String = unwrap(xml, "repoName")!
        let contributor:String = unwrap(xml, "contributor")!
        let title:String = unwrap(xml, "title")!
        let description:String = unwrap(xml, "description")!
        let date:String = unwrap(xml, "date")!
        let sortableDate:Int = unwrap(xml, "sortableDate")!
        let hash:String = unwrap(xml, "hash")!
        let repoId:Int = unwrap(xml, "repoId")!
        return Commit(repoName,contributor,title,description,date,sortableDate,hash,repoId,) as? T
    }
}
func < (a: Commit, b: Commit) -> Bool {
    return a.date < b.date
}
func > (a: Commit, b: Commit) -> Bool {
    return a.date > b.date
}
func == (a: Commit, b: Commit) -> Bool {
    return a.date == b.date && a.hash == b.hash && a.repoId == b.repoId
}