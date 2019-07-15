#if os(iOS)
import UIKit

/**
 * Fixme: ⚠️️ Might be better to use UIButton, see this to access bg layer: https://stackoverflow.com/questions/26351759/why-does-my-uibuttons-background-layer-animate-in-and-how-can-i-stop-it  , keep in mind that UIButton is hard to get right when combing animation and UITableView
 * Fixme: ⚠️️ You could also scale down via .transform (test this when you have time) ref: https://medium.com/livefront/animating-font-size-in-uilabels-fb6fd273a5f3
 * Fixme: ⚠️️ provide some anim config in init?
 */
open class AnimationButton: TextButton, Receedable {
   //   public override init(style:Style = RoundedButton.defaultStyle, text:String = "Dummy text", frame:CGRect = .zero) {
   //      super.init(style: style, text: text, frame: frame)
   //   }
   //   /**
   //    * Boilerplate
   //    */
   //   required public init?(coder aDecoder: NSCoder) {
   //      fatalError("init(coder:) has not been implemented")
   //   }
}

#endif
