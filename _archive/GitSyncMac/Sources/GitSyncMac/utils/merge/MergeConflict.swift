/**
 * Utility methods for merging branches
 */
struct MergeConflict {
    let issue: String, file: String, repo: String
}
extension MergeConflict {
    static let dummyData: MergeConflict = {
        let issue: String = "Conflict: Local file is older than the remote file"
        let file: String = "File: Element.swift"
        let repo: String = "Repository: Element - iOS"
        return MergeConflict(issue: issue, file: file, repo: repo)
    }()
}
