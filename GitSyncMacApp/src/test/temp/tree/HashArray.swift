import Foundation
@testable import Utils
/**
 * https://github.com/raywenderlich/swift-algorithm-club/tree/master/Hash%20Table
 * NOTE: we could use T:Hashable, but no need atm
 */
class HashArray{
    var dict:[String:Int] = [:]
    var arr:[Any] = []
    init(){}
    subscript(key:String) -> Any? {
        get {
            return get(key)
        }
        set {
            add(key,newValue!)
        }
    }
}
extension HashArray{
    fileprivate func add(_ key:String, _ content:Any){
        if(!dict.hasKey(key)){//make sure key doesn't exist
            arr.append(content)//store content in arr
            let idx:Int = arr.count//idx after last, can also be 0 /*arr.isEmpty ? 0 : arr.count - 1*/
            dict[key] = idx//store idx in key
        }else{fatalError("key already exist")}
    }
    func remove(_ key:String){
        if let idx:Int = dict[key]{//make sure the key exists
            dict.removeValue(forKey: key)//remove key and val from dict
            _ = arr.removeAt(idx)//remove item from arr
        }else{fatalError("key does not exist")}
    }
    fileprivate func get(_ key:String)->Any?{
        if let idx:Int = dict[key]{
            return arr[idx]
        }
        return nil
    }
}
