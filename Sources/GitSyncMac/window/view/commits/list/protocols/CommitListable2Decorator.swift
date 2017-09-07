import Cocoa
@testable import Utils
@testable import Element


protocol CommitListable2Decorator:ProgressableDecorator,CommitListable2{}

extension CommitListable2Decorator{
    var commitListable:CommitListable2 {return progressable as! CommitListable2}
    var progressIndicator:ProgressIndicator {get{return commitListable.progressIndicator} set{commitListable.progressIndicator = newValue}}
    var performance:PerformanceTester  {get{return commitListable.performance} set{commitListable.performance = newValue}}/*Debug*/
    var _state:CommitListState {get{return commitListable._state} set{commitListable._state = newValue}}//because state is used by Element
}
