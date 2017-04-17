import Foundation
@testable import Utils
/**
 * HashList: "data structure" that maps 2d <-> 3d array in a 2-way relationship
 * NOTE: So the basic concept is to flatten a 3d array into a 2d array. But avoid doing it each time something changes in either 2d array or 3d array. Basically if something happens in either its a mirrored change. Now my current solution is a third DataStructure I call HashList. Which holds the index of both 2d and 3d array. And facilitates their index translation. Why? Because I need to iterate over a 2d array for speed. But I need to be able to edit the 3d structure as thats where the data is stored. My on going blog post about this: 
 * NOTE: key gives you idx in array
 * NOTE: idx in array gives you key in dict
 * NOTE: https://github.com/raywenderlich/swift-algorithm-club/tree/master/Hash%20Table
 * NOTE: we could use T:Hashable, but no need atm
 * PARAM: arr: stores "3d-idx" ["0","00","01","1","2"]
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

