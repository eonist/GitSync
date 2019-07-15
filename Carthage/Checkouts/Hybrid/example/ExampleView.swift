#if os(iOS)
import Hybrid_iOS
#elseif os(macOS)
import Hybrid_macOS
#endif

open class ExampleView: View {
   override public init(frame: CGRect) {
      super.init(frame: frame)
      self.caLayer?.backgroundColor = Color.white.cgColor
      createUI()
   }
   /**
    * Boilerplate
    */
   public required init?(coder decoder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
   }
}
