import Foundation

/**
 * Utility methods for parsing the the "git status message"
 * TODO: Sometimes RM shows up, figure out what that does
 * NOTE: ' ' = unmodified, M = modified,A = added,D = deleted,R = renamed,C = copied,U = updated but unmerged
 * IMPORTANT ⚠️️ sequenceCommitMsgTitle and sequenceDescription also uses this enum
 */
enum GitCMD:String{
    case M = "M"/*When a file is modified*/
    case D = "D"/*When a file is deleted*/
    case A = "A"/*When a file is added*/
    case R = "R"/*When a file is renamed,*/
    case C = "C"/*When a file is copied,beta*/
    case RD = "RD"/*BETA*/
    case DU = "DU"/*unmerged, deleted by us*/
    case DD = "DD"/*unmerged, both deleted*/
    case DM = "DM"/*deleted from index*/
    case AA = "AA"/*unmerged, both added*/
    case AU = "AU"/*unmerged, added by us*/
    case AM = "AM"/*Beta, needs description, probably file added with two parents*/
    case AD = "AD" //beta
    case MM = "MM"/*There are two Ms in your example because it's a merge commit with two parents*/
    case MD = "MD"//beta
    case RM = "RM"/*When a file is renamed, new and experimental*/
    case QQ = "??"/*untracked*/
    case EE = "!!"/*ignored*/
    case UU = "UU"/*unmerged, both modified*/
    case UD = "UD"/*unmerged, deleted by them*/
    case UA = "UA"/*unmerged, added by them*/
    case CM = "CM"/*copied, modified? beta*/
}
