import Foundation

class TreeDP2Asserter {
    static func hasChildren(_ dp:TreeDP2,_ idx2d:Int) -> Bool{
        return hasChildren(dp,dp[idx2d])
    }
    static func hasChildren(_ dp:TreeDP2, _ idx3d:[Int]) -> Bool{
        return TreeAsserter.hasChildren(dp.tree, idx3d)
    }
}
