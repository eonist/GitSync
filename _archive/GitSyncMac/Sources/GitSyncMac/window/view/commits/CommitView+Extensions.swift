import Foundation
@testable import Utils
@testable import Element

extension CommitView:Closable{
    func close() {
        Swift.print("Close and Also stop the timer")
        intervalTimer.stop()
        self.removeFromSuperview()
    }
    /**
     * Creates Commit list
     */
    func createCommitList() -> CommitList2{
        let dp = CommitDPCache.read()/*Creates the dp based on cached data from previous app runs*/
        let size:CGSize = CGSize(self.getWidth(), self.getHeight())
        Swift.print("size: " + "\(size)")
        let config:List5.Config = .init(itemSize: CGSize(size.w,102), dp: dp, dir:.ver)
        let list = CommitList2.init(config: config, size: size, id: "commitsList")
        self.addSubview(list)
        //⚠️️list!.selectAt(dpIdx: CommitsView.selectedIdx)
        return list
    }
}
