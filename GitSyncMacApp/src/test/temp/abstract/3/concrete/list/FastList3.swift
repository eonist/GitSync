import Foundation
@testable import Utils
@testable import Element

class FastList3:ContainerView3{
    var selectedIdx:Int?/*This cooresponds to the "absolute" index in dp*/
    var dataProvider:DataProvider/*data storage*/
    var pool:[FastListItem] = []/*Stores the FastListItems*/
    var inActive:[FastListItem] = []/*Stores pool item that are not in-use*/
}
