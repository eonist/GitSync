import Foundation

class GraphicShapeTest {
    func rectTest(){
        let rect = RectGraphic(300,300)
        //line.setPosition(CGPoint(150,150))
        rect.initialize()
    }
    func lineTest(){
        let line = LineGraphic(CGPoint(20,20),CGPoint(50,50))
        //line.setPosition(CGPoint(150,150))
        line.initialize()
    }
    func cricleTest(){
        let circle = CircleGraphic(10)
        circle.initialize()
    }
}
