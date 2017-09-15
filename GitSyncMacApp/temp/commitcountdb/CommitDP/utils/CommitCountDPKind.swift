import Foundation

protocol CommitCountDPKind{
    var commitCount:[Int:Int] {get}
    var min:Int {get}
    var max:Int {get}
    var count:Int {get}
}
