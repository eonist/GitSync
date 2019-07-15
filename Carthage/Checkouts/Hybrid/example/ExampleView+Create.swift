#if os(iOS)
import Hybrid_iOS
#elseif os(macOS)
import Hybrid_macOS
#endif

extension ExampleView {
   /**
    *
    */
   func createUI() {
      //      test()
//      testSpecialBtn() //⭐
      //      testToggleButton()
      //      toggleGroup()
      //      testCheckButton()
      //      testCheckBoxButton()
//      testSwitchButton()
//            testStepper()
      //      testSpinner()
            testManyComponents()
//            testBtn()
//      testTextBtn()
//            testSlider()
//      testVolumeSlider()
//      testSelectButton()
//      testSwitch()
   }
   /**
    *
    */
   func testSwitch() {
      let switcher: Switch = .init(isSelected: true)
      self.addSubview(switcher)
      switcher.anchorAndSize(to: self, width: 88, height: 44, align: .centerCenter, alignTo: .centerCenter)
      switcher.upInsideCallBack = { Swift.print("tapUpInsideCallBack") }
      switcher.upOutsideCallBack = { Swift.print("tapUpOutsideCallBack") }
      switcher.upCallBack = { Swift.print("tapUpCallBack") }
      switcher.downCallBack = { Swift.print("tapDownCallBack") }
   }
   /**
    *
    */
   func testSelectButton() {
      let btn: SelectButton = .init(selected: false, frame: .zero)
      self.addSubview(btn)
      btn.anchorAndSize(to: self, width: 44, height: 44, align: .centerCenter, alignTo: .centerCenter )
      btn.upInsideCallBack = { Swift.print("tapUpInsideCallBack") }
      btn.upOutsideCallBack = { Swift.print("tapUpOutsideCallBack") }
      btn.upCallBack = { Swift.print("tapUpCallBack") }
      btn.downCallBack = { Swift.print("tapDownCallBack") }
   }
   /**
    * Slider
    */
   func testSlider() {
      let xSlider: Slider = {/*Horizontal*/
         let slider: Slider = .init(axis: .hor, buttonSide: 44/*, progress: 0*/)
         self.addSubview(slider)
         slider.anchorAndSize(to: self, height: 44, align: .topCenter, alignTo: .topCenter, offset: .init(x: 0, y: 44), sizeOffset: .init(width: -88, height: 0))
         return slider
      }()
      xSlider.onChange = { progress in
         Swift.print("progress:  \(progress)")//0-1
      }
      let ySlider: Slider = {/*Vertical*/
         let slider: Slider = .init(axis: .ver, buttonSide: 44, progress: 0)
         self.addSubview(slider)
         slider.anchorAndSize(to: xSlider, sizeTo: self, width: 44, align: .topLeft, alignTo: .bottomLeft, offset: .init(x: 0, y: 44), sizeOffset: .init(width: 8, height: -88 - 88))
         return slider
      }()
      ySlider.onChange = { progress in
         Swift.print("progress:  \(progress)")//0-1
      }
   }
   /**
    * Volume-Slider
    */
   func testVolumeSlider() {
      let xSlider: VolumeSlider = {/*Horizontal*/
         let slider: VolumeSlider = .init(axis: .hor, buttonSide: 44/*, progress: 0*/)
         self.addSubview(slider)
         slider.anchorAndSize(to: self, height: 44, align: .topCenter, alignTo: .topCenter, offset: .init(x: 0, y: 44), sizeOffset: .init(width: -88, height: 0))
         return slider
      }()
      xSlider.onChange = { progress in
         Swift.print("progress:  \(progress)")//0-1
      }
      let ySlider: VolumeSlider = {
         let slider: VolumeSlider = .init(axis: .ver, buttonSide: 44, progress: 0)
         self.addSubview(slider)
         slider.anchorAndSize(to: xSlider, sizeTo: self, width: 44, align: .topLeft, alignTo: .bottomLeft, offset: .init(x: 0, y: 44), sizeOffset: .init(width: 8, height: -88 - 88))
         return slider
      }()
      ySlider.onChange = { progress in
         Swift.print("progress:  \(progress)")//0-1
      }
   }
   /**
    *
    */
   func testSpecialBtn() {
      //      let rect:CGRect = .init(origin:.zero,size:.init(width:122,height:44))
      let btn: SelectableTextButton = .init(selected: false, text: "Special", frame: .zero)
      self.addSubview(btn)
      btn.anchorAndSize(to: self, height: 44, align: .centerCenter, alignTo: .centerCenter, sizeOffset: .init(width: -120, height: 0))
      btn.upInsideCallBack = { Swift.print("tapUpInsideCallBack") }
      btn.upOutsideCallBack = { Swift.print("tapUpOutsideCallBack") }
      btn.upCallBack = { Swift.print("tapUpCallBack") }
      btn.downCallBack = { Swift.print("tapDownCallBack") }
   }
   /**
    *
    */
   func testBtn() {
      //let rect:CGRect = .init(origin:.zero,size:.init(width:100,height:44))
      let btn: Button = .init(style: (.white, .black, 1, true), frame: .zero)
      self.addSubview(btn)
      btn.anchorAndSize(to: self, height: 44, align: .centerCenter, alignTo: .centerCenter, sizeOffset: .init(width: -120, height: 0))
      btn.upInsideCallBack = { Swift.print("tapUpInsideCallBack") }
      btn.upOutsideCallBack = { Swift.print("tapUpOutsideCallBack") }
      btn.upCallBack = { Swift.print("tapUpCallBack") }
      btn.downCallBack = { Swift.print("tapDownCallBack") }
   }
   /**
    * Tests many ui components
    */
   func testManyComponents() {
      let autoOpenItem: SwitchButton = .init(text: "Auto open bay door:", selected: false )
      self.addSubview(autoOpenItem)
      // Clipboard
      let openClipboardItem: SwitchButton = .init(text: "Auto-pilot:", selected: true )
      self.addSubview(openClipboardItem)
      // Darkmode
      let darkModeItem: SwitchButton = .init(text: "Night mode:", selected: false)
      self.addSubview(darkModeItem)
      // Fps
      let fpsItem: Spinner = .init(text: "Thrust:", initData: (value: 6, increment: 1, min: 1, max: 12, decimals: 0))
      self.addSubview(fpsItem)
      // moudle-Count
      let moduleCountItem: Spinner = .init(text: "Velocity:", initData: (value: 26, increment: 1, min: 21, max: 80, decimals: 0))
      self.addSubview(moduleCountItem)
      // Version
      let versionItem: Label = .init(text: "Version. 0.2.1", style: (.systemFont(ofSize: 20), .black, .left) )
      self.addSubview(versionItem)
      // Exit
      let exitItem: TextButton = .init(text: "Exit")
      self.addSubview(exitItem)
      // Items
      let items = [autoOpenItem, openClipboardItem, darkModeItem, fpsItem, moduleCountItem, versionItem, exitItem]
      items.distributeAndSize(dir: .ver, height: 44, align: .topCenter, alignTo: .topCenter, spacing: 12, offset: 44, sizeOffset: .init(width: -60, height: 0))
   }
   /**
    *
    */
   func testSpinner() {
      let spinner: Spinner = .init()
      self.addSubview(spinner)
      spinner.anchorAndSize(to: self, height: 44, align: .centerCenter, alignTo: .centerCenter, sizeOffset: .init(width: -120, height: 0))
      spinner.onChange = { value in Swift.print("\(value)") }
   }
   /**
    *
    */
   func testStepper() {
      let stepper: Stepper = .init()
      self.addSubview(stepper)
      stepper.anchorAndSize(to: self, width: 88 + 12, height: 44, align: .centerCenter, alignTo: .centerCenter)
      stepper.onChange = { value in Swift.print("value:  \(value)") }
   }
   /**
    *
    */
   func testCheckBoxButton() {
      let btn1: CheckBoxButton = .init(text: "Darkmode:", selected: false, checkBoxStyles: ((.black, .black, true), (.white, .black, true)))
      self.addSubview(btn1)
      btn1.anchorAndSize(to: self, height: 44, align: .centerCenter, alignTo: .centerCenter, sizeOffset: .init(width: -120, height: 0))
   }
   /**
    *
    */
   func testSwitchButton() {
      let btn1: SwitchButton = .init(text: "Darkmode:", selected: false)
      self.addSubview(btn1)
      btn1.anchorAndSize(to: self, height: 44, align: .centerCenter, alignTo: .centerCenter, sizeOffset: .init(width: -120, height: 0))
   }
   /**
    *
    */
   func testCheckButton() {
      let btn1: CheckButton = .init(selected: true)
      self.addSubview(btn1)
      btn1.anchorAndSize(to: self, height: 44, align: .centerCenter, alignTo: .centerCenter, sizeOffset: .init(width: -80, height: 0))
   }
   /**
    *
    */
   func testTextBtn() {
      let btn: TextButton = .init(text: "Exit", frame: .zero)
      self.addSubview(btn)
      btn.anchorAndSize(to: self, height: 44, align: .centerCenter, alignTo: .centerCenter, sizeOffset: .init(width: -80, height: 0))
      btn.upInsideCallBack = { Swift.print("tapUpInsideCallBack") }
      btn.upOutsideCallBack = { Swift.print("tapUpOutsideCallBack") }
      btn.upCallBack = { Swift.print("tapUpCallBack") }
      btn.downCallBack = { Swift.print("tapDownCallBack") }
   }
}




/**
 *
 */
//   func toggleGroup(){
//
//      let btn1:SelectableRoundedTextButton = .init(selected: true, text:("Send","Send"))
//      view.addSubview(btn1)
//
//      let btn2:SelectableRoundedTextButton = .init(selected: false, text:("Receive","Receive"))
//      view.addSubview(btn2)
//
//      let views = [btn1,btn2]
//      let selectGroup:SelectGroup = .init(selectables: views, selected: btn1)
//      views.forEach{ view in view.tapUpInsideCallBack = {selectGroup.selected = view}}
//
//      views.applySizes(width: UIScreen.main.bounds.width-80, height: 44)
//      views.applyAnchors(to: view, align: .centerX , alignTo: .centerX)
//      let inset:CGFloat = (UIScreen.main.bounds.height - 160) / 2/*Basically spaceAround now works inside a virtual 160x160 box*/
//      views.spaceAround(dir: .ver, parent: view, inset: .init(top: inset, left: 0, bottom: inset, right: 0))
//   }
/**
 *
 */
//   func testToggleButton(){
//      let btn:SelectableRoundedTextButton = .init(selected: false)
//      view.addSubview(btn)
////      btn.selected = true
////      Swift.print("view.frame:  \(view.frame)")
////      btn.applySize(to: self.view, height: 44, multiplier: .init(width: 0.8, height: 1))
////      btn.applyAnchor(to: self.view, align: .bottomRight, alignTo: .bottomRight)
//      btn.applyAnchorAndSize(to: view, height: 44, align: .centerCenter, alignTo: .centerCenter , sizeOffset: .init(width: -80, height: 0))
//   }



/**
 *
 */
//   func test(){
//      _ = animationButton
//      animationButton.tapDownCallBack = {
//         Swift.print("🎉 tapDown")
//      }
//      animationButton.tapUpCallBack = {
//         Swift.print("🎉 tapUp")
//      }
//      animationButton.tapUpInsideCallBack = {
//         Swift.print("🎉 tapUpInside")
//      }
//      animationButton.tapUpOutsideCallBack = {
//         Swift.print("🎉 tapUpOutside")
//      }
//
//
//      let views = [animationButton/*,animationButton2*/]
//
//      views.applySizes(width: UIScreen.main.bounds.width-80, height: 44)
//      views.applyAnchors(to: view, align: .centerX , alignTo: .centerX)
//      let inset:CGFloat = (UIScreen.main.bounds.height - 160) / 2/*Basically spaceAround now works inside a virtual 160x160 box*/
//      views.spaceAround(dir: .ver, parent: view, inset: .init(top: inset, left: 0, bottom: inset, right: 0))

//   }



/**
 * Create custom button ⚠️️ out of order
 */
//   func createCustomButton() -> AnimationButton{
//      let style:AnimationButton.Style = (backgroundColor:.blue,borderColor:.blue,textColor:.white)//(.white,.blue,.blue)
//      let customButton:AnimationButton = .init(style:style,  text:"Accept", frame: .zero)
//      self.view.addSubview(customButton)
//      return customButton
//   }
/**
 * CreateCustomButton2 ⚠️️ out of order
 */
//   func createCustomButton2() -> AnimationButton{
//      let style:AnimationButton.Style = (.white,.blue,.blue)
//      let customButton:AnimationButton = .init(style:style, text:"Decline", frame: .zero)
//      self.view.addSubview(customButton)
//      return customButton
//   }
