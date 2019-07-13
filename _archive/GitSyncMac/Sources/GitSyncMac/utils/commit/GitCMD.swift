import Foundation

/**
 * Utility methods for parsing the the "git status message"
 * - TODO: Sometimes RM shows up, figure out what that does
 * - NOTE: ' ' = unmodified, M = modified,A = added,D = deleted,R = renamed,C = copied,U = updated but unmerged
 * - IMPORTANT ⚠️️ sequenceCommitMsgTitle and sequenceDescription also uses this enum
 */
enum GitCMD: String{
    case M /*When a file is modified*/
    case D /*When a file is deleted*/
    case A /*When a file is added*/
    case R /*When a file is renamed,*/
    case C /*When a file is copied,beta*/
    case RD /*BETA*/
    case DU /*unmerged, deleted by us*/
    case DD /*unmerged, both deleted*/
    case DM /*deleted from index*/
    case AA /*unmerged, both added*/
    case AU /*unmerged, added by us*/
    case AM /*Beta, needs description, probably file added with two parents*/
    case AD  //beta
    case MM /*There are two Ms in your example because it's a merge commit with two parents*/
    case MD //beta
    case RM /*When a file is renamed, new and experimental*/
    case UU /*unmerged, both modified*/
    case UD /*unmerged, deleted by them*/
    case UA /*unmerged, added by them*/
    case CM /*copied, modified? beta*/
    case QQ = "??"/*untracked*/
    case EE = "!!"/*ignored*/
}
