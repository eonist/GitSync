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
     *
     */
    func createCommitList() -> CommitsList{
        let dp = CommitDPCache.read()/*Creates the dp based on cached data from previous app runs*/
        let size:CGSize = CGSize(self.getWidth(), self.getHeight())
        Swift.print("size: " + "\(size)")
        let list = CommitsList.init(size.w,size.h, CGSize(24,102), dp, self,"commitsList")
        self.addSubview(list)/*24 should be allowed to be nan no?*/
        //⚠️️list!.selectAt(dpIdx: CommitsView.selectedIdx)
        return list
    }
}
