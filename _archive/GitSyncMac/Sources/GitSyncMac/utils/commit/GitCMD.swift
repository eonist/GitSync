import Foundation

/**
 * Utility methods for parsing the the "git status message"
 * - TODO: Sometimes RM shows up, figure out what that does
 * - NOTE: ' ' = unmodified, M = modified,A = added,D = deleted,R = renamed,C = copied,U = updated but unmerged
 * - IMPORTANT ⚠️️ sequenceCommitMsgTitle and sequenceDescription also uses this enum
 * - Fixme: write descriptions for each case in comments not in the code 🏀
 * M When a file is modified
 * D When a file is deleted
 * A When a file is added
 * R When a file is renamed,
 * C When a file is copied,beta
 * RD BETA
 * DU unmerged, deleted by us
 * DD unmerged, both deleted
 * DM deleted from index
 * AA unmerged, both added
 * AU unmerged, added by us
 * AM Beta, needs description, probably file added with two parents
 * AD  beta
 * MM There are two Ms in your example because it's a merge commit with two parents
 * MD beta
 * RM When a file is renamed, new and experimental
 * UU unmerged, both modified
 * UD unmerged, deleted by them
 * UA unmerged, added by them
 * CM copied, modified? beta
 */
enum GitCMD: String {
    case M, D, A, R, C, RD, DU, DD, DM, AA, AU, AM, AD, MM, MD, RM, UU, UD, UA, CM
    case QQ = "??"/*untracked*/
    case EE = "!!"/*ignored*/
}
