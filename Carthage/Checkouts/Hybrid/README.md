<img width="288" alt="img" src="https://rawgit.com/stylekit/img/master/hybrid_logo.svg">

![mit](https://img.shields.io/badge/License-MIT-brightgreen.svg)
![platform](https://img.shields.io/badge/Platform-iOS-blue.svg)
![platform](https://img.shields.io/badge/Platform-macOS-blue.svg)
![Lang](https://img.shields.io/badge/Language-Swift%205.0-orange.svg)
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)
[![codebeat badge](https://codebeat.co/badges/a14b185c-f5ec-4fab-ae83-6141e4f24a24)](https://codebeat.co/a/30n1st/projects/github-com-eonist-animationbutton-master)
[![SwiftLint Sindre](https://img.shields.io/badge/SwiftLint-Sindre-hotpink.svg)](https://github.com/sindresorhus/swiftlint-sindre)

### What is it
UI Library for iOS and macOS

### How does it work
- Use the same code for iOS and macOS
- Uses Autolayout

### How do I get it
- Carthage `github "eonist/Hybrid" "master"`
- Manual Open `Hybrid.xcodeproj`
- CocoaPod (Coming soon)

### Topology:
    .
    ├── example               # Cross-platform example code
    ├── Hybrid                # iOS app code
    ├── Hybrid-example-macOS  # macOS app code
    └── src                   # Core UI components
         ├── button           # Various buttons
         ├── slider           # Vertical / Horizontal slider
         └── spinner          # Value changer


<img width="487" alt="img" src="https://github.com/stylekit/img/blob/master/Screenshot 2019-04-06 at 17.22.09.png?raw=true">

<img width="569" alt="img" src="https://github.com/stylekit/img/blob/master/Screenshot 2019-04-06 at 17.20.52.png?raw=true">

<img width="418" alt="img" src="https://github.com/stylekit/img/blob/master/switchHighRes.gif?raw=true">

<img width="490" alt="img" src="https://github.com/stylekit/img/blob/master/Screenshot 2019-03-29 at 01.16.10.png?raw=true">


### Example:

```swift
/*Horizontal*/
let xSlider:Slider = {
   let slider = Slider.init(axis: .hor, buttonSide: 44, progress: 0)
   self.view.addSubview(slider)
   slider.anchorAndSize(to: view, height: 44, align: .topCenter, alignTo: .topCenter, offset:.init(x:0,y:44),sizeOffset:.init(width:-88,height:0))
   return slider
}()
/*Vertical*/
let ySlider:Slider = {
   let slider = Slider.init(axis: .ver, buttonSide: 44, progress: 0)
   self.view.addSubview(slider)
   slider.anchorAndSize(to: xSlider, sizeTo:view, width: 44, align: .topLeft, alignTo: .bottomLeft, offset:.init(x:0,y:44),sizeOffset:.init(width:8,height:-88-88))
   return slider
}()
ySlider.onChange = { progress in
   Swift.print("progress:  \(progress)")//0-1
}
```

<img width="487" alt="img" src="https://github.com/stylekit/img/blob/master/Screenshot 2019-03-08 at 17.25.56.png?raw=true">

<img width="592" alt="img" src="https://github.com/stylekit/img/blob/master/Screenshot 2019-03-08 at 16.36.23.png?raw=true">



### TODO:
- Add macOS support ✅
- Improve Spatial
