import Foundation
@testable import Utils

extension RepoDetailView{
    enum Key{
        static let title:String = RepoType.title.rawValue
        static let local:String = RepoType.local.rawValue
        static let remote:String = RepoType.remote.rawValue
        static let branch:String = RepoType.branch.rawValue
        static let auto:String = RepoType.auto.rawValue
        static let message:String = RepoType.message.rawValue
        static let active:String = RepoType.active.rawValue
        static let template:String = "template"
        static let notification:String = "notification"
    }
}
