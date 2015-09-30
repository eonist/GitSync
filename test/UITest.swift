//test creating buttons,lists,checkbuttons,textfields, etc to the view

//Button
let myButton = UIButton()
myButton.setTitle("Hai Touch Me", forState: .Normal)
myButton.setTitleColor(UIColor.blueColor(), forState: .Normal)
myButton.frame = CGRectMake(15, 50, 300, 500)
myButton.addTarget(self, action: "pressedAction:", forControlEvents: .TouchUpInside)
self.view.addSubview( myButton)


func pressedAction(sender: UIButton!) {
   // do your stuff here 
  NSLog("you clicked on button %@", sender.tag)
}

