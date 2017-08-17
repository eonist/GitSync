import Foundation
@testable import Utils

class NotificationManager {
    /**
     * Sends Message to NotificationCenter in MacOS about latest commit
     */
    static func notifyUser(message commitMessage:CommitMessage,repo repoItem:RepoItem){
        guard PrefsView.prefs.notification else { return }//dont send notification if its globally turned off
        let notification = NSUserNotification()
        notification.title = "\(repoItem.title)"//Committed in:
        notification.subtitle = commitMessage.title
        notification.informativeText = commitMessage.description
        notification.soundName = nil//NSUserNotificationDefaultSoundName
        NSUserNotificationCenter.default.deliver(notification)
    }
}
