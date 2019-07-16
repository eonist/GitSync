import Cocoa
import Spatial_macOS
import With_mac
import Hybrid_macOS
/**
 * Create
 */
extension StaticTextCell {
   /**
    * Create Title Label
    */
   @objc func createDescriptionLabel() -> NSLabel {
      return with(.init()) {
         $0.text = "title"
         $0.textColor = .black//.black
         $0.backgroundColor = .yellow
         $0.font = .systemFont(ofSize: 14)//.boldSystemFont(ofSize: 20.0)
         $0.textAlignment = .left
         $0.centerVertically()
         self.textField = $0 // Fixme: rather remove self.textField and dont add
         self.addSubview($0)
         $0.anchorAndSize(to: self, offset: .init(x: 12, y: 0))
      }
   }
   /**
    * IndicatorLabel
    */
   func crateIndicatorLabel() -> NSLabel {
      return with(.init()) {
         $0.text = ">"
         $0.textColor = .black//.black
         $0.backgroundColor = .yellow
         $0.font = .systemFont(ofSize: 14)//.boldSystemFont(ofSize: 20.0)
         $0.textAlignment = .right
         $0.centerVertically()
         self.addSubview($0)
         // fixme: ⚠️️ use width:height here
         $0.anchorAndSize(to: self, width: 42, align: .topRight, alignTo: .topRight, offset: .init(x: -12, y: 0))
      }
   }
}

//            $0.backgroundColor = UIColor.green.withAlphaComponent(0.5)
//            $0.layer.borderWidth = 0.5
//            $0.layer.borderColor = UIColor.black.cgColor

//            $0.layer.borderWidth = 0.5
//            $0.layer.borderColor = UIColor.green.cgColor

//         $0.translatesAutoresizingMaskIntoConstraints = false
//         let left = $0.leadingAnchor.constraint(equalTo: self.leadingAnchor,  constant: 12)
//         NSLayoutConstraint.activate([left])
//         $0.setContentHuggingPriority(.init(500), for: .horizontal) //Makes sure the label retians it's instrinsic width, as oppose to sticking to the textField left anchor
