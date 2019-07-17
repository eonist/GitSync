import Cocoa
import Spatial_macOS
import With_mac
import Hybrid_macOS
/**
 * Create
 * Fixme: Rename to DynamicText
 */
extension TextInput {
   /**
    * Description
    */
   @objc func createDescriptionLabel() -> NSLabel {
      return with(.init()) {
         $0.text = "title"
         $0.textColor = .black//.black
         $0.backgroundColor = .yellow
         $0.font = .systemFont(ofSize: 14)//.boldSystemFont(ofSize: 20.0)
         $0.textAlignment = .left
         $0.centerVertically()
         self.addSubview($0)
         $0.anchorAndSize(to: self, offset: .init(x: 12, y: 0))
      }
   }
   /**
    * Create Content TextField
    */
   @objc func createContentTextField() -> NSTextField {
      return with(.init()) {
         $0.alignment = .right
         $0.textColor = .gray
         $0.font = .systemFont(ofSize: 16)
         self.addSubview($0)
         $0.anchorAndSize(to: self, width: 160, height: 20, align: .centerRight, alignTo: .centerRight, offset: .init(x: -12, y: 0))
      }
   }
}

//         $0.translatesAutoresizingMaskIntoConstraints = false
//         let left = $0.leadingAnchor.constraint(equalTo: self.leadingAnchor,  constant: 12)
//         NSLayoutConstraint.activate([left])
//         $0.setContentHuggingPriority(.init(500), for: .horizontal) //Makes sure the label retians it's instrinsic width, as oppose to sticking to the textField left anchor


/**
 * Create Title Label
 */
//   @objc func createDescriptionLabel() -> NSLabel {
//      return with(.init()) {
//         $0.text = "title"
//         $0.textColor = .white//.black
//         $0.backgroundColor = .clear
//         $0.font = .boldSystemFont(ofSize: 16)//.boldSystemFont(ofSize: 20.0)
//         $0.textAlignment = .left
//         self.addSubview($0)
//         $0.translatesAutoresizingMaskIntoConstraints = false
//         let left = $0.leadingAnchor.constraint(equalTo: self.leadingAnchor,  constant: 12)
//         NSLayoutConstraint.activate([left])
//         $0.setContentHuggingPriority(.init(500), for: .horizontal) //Makes sure the label retians it's instrinsic width, as oppose to sticking to the textField left anchor
//      }
//   }

