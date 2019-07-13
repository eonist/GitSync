import Foundation
/**
 * Fixme: ⚠️️ rename to RepoData
 * Fixme: ⚠️️ Needs a unique identifier value
 * Fixme: Why not use let variables?
 */
struct RepoItem {
    var local: String // Local path
    var branch: String // Repo branch, Master is default
    var title: String // The title displayed in the app
    var active: Bool // Active means that auto and pull will sync the repo
    var remote: String // Remote path to repository
    var message: Bool // Auto-created commit message //Fixme: ⚠️️ rename
    var auto: Bool // Automatically syncs on an interval*///Fixme: ⚠️️ rename to interva
    var template: String // template message for commitmessages
    var notification: Bool // toggle Notifications per repo
    init(){/*Default RepoItem*/
        self.local = ""/*Local path*/
        self.branch = ""/*Repo branch, Master is default*/
        self.title = ""/*The title displayed in the app*/
        self.active = false/*Active means that auto and pull will sync the repo*/
        self.remote = ""/*Remote path to repository*/
        self.message = false/*Auto-created commit message*/ //Fixme: ⚠️️ rename
        self.auto = false/*Automatically syncs on an intervall*/ //Fixme: ⚠️️ rename to interval?
        self.template = ""
        self.notification = false
    }
}
