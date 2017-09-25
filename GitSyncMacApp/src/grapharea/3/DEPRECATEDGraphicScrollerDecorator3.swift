import Foundation
@testable import Element
@testable import Utils

protocol GraphScrollerDecorator3:ElasticDecorator{
    var prevX:CGFloat {get set}
    var points:[CGPoint] {get set}
//    var prevPoints:[CGPoint]? {get set}//rename 👉 fromPoints
//    var newPoints:[CGPoint]? {get set}//rename 👉 toPoints
    var animator:NumberSpringer? {get set}/*Anim*/
    var prevMinY:CGFloat? {get set}
    var graphArea:GraphAreaX {get set}
}

extension GraphScrollerDecorator3{
    var graph:GraphScrollView3 {return progressable as! GraphScrollView3}
    var prevX:CGFloat {get{return graph.prevX} set{graph.prevX = newValue}}
    var points:[CGPoint] {get{return graphArea.points}set{graphArea.points = newValue}}
    //
//    var prevPoints:[CGPoint]? {get{return graph.prevPoints} set{graph.prevPoints = newValue}}
//    var newPoints:[CGPoint]? {get{return graph.newPoints} set{graph.newPoints = newValue}}
    var animator:NumberSpringer? {get{return graph.animator} set{graph.animator = newValue}}
    var prevMinY:CGFloat? {get{return graph.prevMinY} set{graph.prevMinY = newValue}}
    var graphArea:GraphAreaX {get{return graph.graphArea} set{graph.graphArea = newValue}}
}


