import Foundation
@testable import Utils

/**
 * DISCUSSION: Using struct is justified because the data is never modified. Just stored and reproduced
 * NOTE: nice struct, but extending Dictionary proved too difficult
 */
struct Commit{
    var repoName:String
    let contributor:String
    let title:String /*'Commit title' aka 'commit subject'*/
    let description:String/*'Commit description' aka 'commit body'*/
    let date:String/*2 min ago, 2016/12/12, feb 2, etc*/
    let sortableDate:Int/*chronological descending date  in this format: yyyymmddhhmmss 20161201165959*/
    let hash:String
    let repoId:Int/*internal id system*/
    init(_ repoName:String,_ contributor:String,_ title:String,_ description:String,_ date:String,_ sortableDate:Int,_ hash:String,_ repoId:Int){
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
/*extension Commit: ExpressibleByDictionaryLiteral {
 init(dictionaryLiteral elements: (String, Any)...) {
 self.init()
 for (key, value) in elements {
 if("\(key)" == "repoName"){self.repoName = "\(value)"}
 }
 }
 }*/

extension Commit:Comparable{
}
func == (lhs: Commit, rhs: Commit) -> Bool {
    return lhs.hash == rhs.hash
}
func < (a: Commit, b: Commit) -> Bool {
    return a.sortableDate < b.sortableDate
}
func > (a: Commit, b: Commit) -> Bool {
    return a.sortableDate > b.sortableDate
}


//this makes SortableCommit unwrappable (XML->SortableCommit)
extension Commit:UnWrappable{
    static func unWrap<T>(_ xml:XML) -> T? {
        let repoName:String = unWrap(xml, "repoName") ?? ""
        let contributor:String = unWrap(xml, "contributor") ?? ""
        let title:String = unWrap(xml, "title") ?? ""
        let description:String = unWrap(xml, "description") ?? ""
        let date:String = unWrap(xml, "date") ?? ""
        let sortableDate:Int = unWrap(xml, "sortableDate")!
        let hash:String = unWrap(xml, "hash") ?? ""
        let repoId:Int = unWrap(xml, "repoId")!
        return Commit(repoName,contributor,title,description,date,sortableDate,hash,repoId) as? T
    }
}

