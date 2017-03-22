import Cocoa
@testable import Element
@testable import Utils

protocol ElasticScrollable2:Elastic2, Scrollable2 {
    func setProgress(_ value:CGFloat)
}

