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
    /**
     *
     */
    func createBarGraph(_ size:CGSize,_ graphPts:[CGPoint]){
        //graphArea?.addSubview()
        graphPts.forEach{
            let bar:Bar = graphArea!.addSubView(Bar(NaN,size.height,graphArea))
            bars.append(bar)
            bar.setPosition($0)
        }
    }
}
class Bar:Element{
    
}
