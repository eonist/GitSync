import Foundation
@testable import Utils

class NotificationManager {
    /**
     * Sends Message to NotificationCenter in MacOS about latest commit
     * - Note: Notification center is the rightLeft popup that shows up in macOS from time to time
     */
    static func notifyUser(message commitMessage: CommitMessage, repo repoItem: RepoItem){
        guard PrefsView.prefs.notification else { return }//don't send notification if it's globally turned off
        let notification = NSUserNotification()
        notification.title = "\(repoItem.title)"//Committed in:
        notification.subtitle = commitMessage.title
        notification.informativeText = commitMessage.description
        notification.soundName = nil//NSUserNotificationDefaultSoundName
        NSUserNotificationCenter.default.deliver(notification)
    }
}
