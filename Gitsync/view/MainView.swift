import Cocoa

open class MainView: NSView{
   override open var isFlipped: Bool { return true }/*TopLeft orientation*/
   lazy var commitList: CommitList = createCommitList()

   override public init(frame: CGRect) {
      super.init(frame: frame)
      Swift.print("hello world")
      self.wantsLayer = true /*if true then view is layer backed*/
      _ = commitList
   }
   /**
    * Boilerplate
    */
   required public init?(coder decoder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
   }
}
