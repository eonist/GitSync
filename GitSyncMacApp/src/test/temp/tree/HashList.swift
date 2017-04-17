import Foundation
@testable import Utils
/**
 * HashList is a 2-way: 2d<->3d idx map
 * NOTE: key gives you idx in array
 * NOTE: idx in array gives you key in dict
 * NOTE: https://github.com/raywenderlich/swift-algorithm-club/tree/master/Hash%20Table
 * NOTE: we could use T:Hashable, but no need atm
 * PARAM: arr: stores "3d-idx" [0,00,01,1,2]
 * PARAM: dict: stores "2d-idx" ["0":0,"00":1,"01":2,"1":3,"2":4]
 * NOTE: "Key-Collisions" can't happen, since 3d-idencies are always unique
 */
struct HashList {
    var arr:[String]
    var dict:[String:Int]
    init(_ arr:[String] = [],_ dict:[String:Int] = [:]){
        self.arr = arr
        self.dict = dict
    }
}

