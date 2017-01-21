import Cocoa

class BarGraph:Graph {
    var bars:[Bar] = []
    //Continue here:
        //Extract the gesture out of CommitGraph
        //override createGraph
        //create dummy methods with sudo code that calcs the bars and draws them etc
        //test it
        //create the touch point visualisations
        //don't do the rounded look before you have the square look working
    override func createGraph(_ graphPts: [CGPoint]) {
        createBars(graphPts)
    }
    /**
     *
     */
    func createBars(_ graphPts:[CGPoint]){
        //graphArea?.addSubview()
        graphPts.forEach{
            let bar:Bar = graphArea!.addSubView(Bar(NaN,newSize!.height,graphArea))//width is set in the css
            bars.append(bar)
            bar.setPosition($0)//remember to offset with half the width in the css
        }
    }
}
class Bar:Element{
    
}
