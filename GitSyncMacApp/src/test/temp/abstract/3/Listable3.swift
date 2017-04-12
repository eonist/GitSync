import Foundation
@testable import Utils
@testable import Element

protocol Listable3 {
    var dp:DataProvider {get}
    var dir:Dir {get}//the "primary" direction the list scroll in. the secondary direction is the opposite   
    var itemSize:CGSize{get}
}
