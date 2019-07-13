import Foundation
@testable import Utils

class GitSyncUtils {
    /**
     * Returns the hash (sha1) of the first commit in a repo
     * - Fixme: ⚠️️ Test what happens when the repo doesn't contain any commits, probably empty string
     */
    static func firstHash(_ localRepoPath: String) -> String {
        let shellScript: String = Git.path + "git log -1 --pretty=format:%H"
        let result: String = ShellUtils.run(shellScript, localRepoPath)
        return result
    }
}
