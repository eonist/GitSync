import Foundation
/**
 * Consider adding default data methods in an extension that prints error if called to, or not as you probably wont be able to as easily override it etc
 */
protocol UnFoldable {
    //unfold
    //data 
    var data:[String:Any] {get set}//this should probably be just any?
}
