import UIKit
import Hybrid_iOS

class MainVC: UIViewController {
   override func viewDidLoad() {
      super.viewDidLoad()
      self.view = ExampleView(frame: UIScreen.main.bounds)
   }
   override var prefersStatusBarHidden: Bool { return true }
}
