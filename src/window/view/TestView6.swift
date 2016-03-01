import Foundation

class TestView6:AnimatableView {
    let target:CGPoint = CGPoint(100,60)
    var circ:EllipseGraphic!
    override func resolveSkin() {
        super.resolveSkin()
        listAnimTest()
    }
    func listAnimTest(){
        //create a container with a mask 200x200
        
        //create a container with 3 rects insider 200x150 per rect
        
        //add the scrollEvent mover scheme to move the container with the rects
        
        //when y+height of rectContainer is above y+height of the maskContainer then stop moving the rectContainer
        
        //then apply spring and more friction when the above event happens. 
        
        //if the above works do the same scheme for when rectContainer.y top is bellow top maskContainer.y
        
        
        
    }
}
