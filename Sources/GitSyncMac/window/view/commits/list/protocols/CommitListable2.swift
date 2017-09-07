import Cocoa
@testable import Utils
@testable import Element

protocol CommitListable2:class {
    var progressIndicator:ProgressIndicator {get set}
    var performance:PerformanceTester {get set} /*Debug*/
    var _state:CommitListState {get set}//because state is used by Element
}
