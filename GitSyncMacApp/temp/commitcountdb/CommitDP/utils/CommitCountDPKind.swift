import Foundation
@testable import Utils

protocol CommitCountDPKind{
    var commitCount:[Int:Int] {get}
    var min:Int {get}
    var max:Int {get}
    var count:Int {get}
    //
    func item(at: Int) -> Int?
    func item(at:Int)->(commitCount:Int?,ymd:YMD)
}
