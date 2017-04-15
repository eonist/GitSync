import Foundation
@testable import Utils
/**
 * NOTE: key gives you idx in array
 * NOTE: idx in array gives you key in dict
 * https://github.com/raywenderlich/swift-algorithm-club/tree/master/Hash%20Table
 * NOTE: we could use T:Hashable, but no need atm
 */
struct HashList {
    var dict:[String:Int] 
    var arr:[String]
    init(_ dict:[String:Int] = [:],_ arr:[String] = []){
        self.dict = dict
        self.arr = arr
    }
}
extension HashList{
    subscript(at:Int) -> String? {//Convenience
        get {
            return arr[index]
        }
    }
    mutating func add(_ key:String){
        if(!dict.hasKey(key)){
            arr.append(key)//store content in arr
            let idx:Int = arr.count-1
            dict[key] = idx//store idx in key
        }else{fatalError("key already exist")}
    }
    mutating func remove(_ key:String){
        if let idx:Int = dict[key]{//make sure the key exists
            dict.removeValue(forKey: key)//remove key and val from dict
            _ = arr.removeAt(idx)//remove item from arr
        }else{fatalError("key does not exist")}
    }
}
