import Foundation
@testable import Utils
/**
 * https://github.com/raywenderlich/swift-algorithm-club/tree/master/Hash%20Table
 */
class HashArray{
    var dict:[String:Int] = [:]
    var arr:[Any] = []
    init(){}
    subscript(key:String) -> Any? {
        get {
            return nil
        }
        set {
            _ = newValue
        }
    }
}
extension HashArray{
    func add(_ key:String, _ content:Any){
        if(!dict.hasKey(key)){//make sure key doesn't exist
            let idx:Int = arr.endIndex//idx after last, can also be 0 /*arr.isEmpty ? 0 : arr.count - 1*/
            arr[idx] = content//store content in arr
            dict[key] = idx//store idx in key
        }else{fatalError("key already exist")}
    }
    func remove(_ key:String){
        if let idx:Int = dict[key]{//make sure the key exists
            dict.removeValue(forKey: key)//remove key and val from dict
            _ = arr.removeAt(idx)//remove item from arr
        }else{fatalError("key does not exist")}
    }
    func get(_ key)->Any?{
        if let idx:Int = dict[key]{
            
        }
        return arr[]
    }
}
