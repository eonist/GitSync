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
    let repoId:Int
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

struct SortableCommit:Comparable{
    let date:Int
    let hash:String
        init(_ repoId:Int,_ hash:String,_ date:Int){
        self.repoId = repoId
        self.hash = hash
        self.date = date
    }
}