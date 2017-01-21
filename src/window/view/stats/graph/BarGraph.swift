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
            let bar:Bar = graphArea!.addSubView(Bar(NaN,NaN,graphArea,"graphPoint"))
            bars.append(bar)
            bar.setPosition($0)
            //style the button similar to VolumSlider knob (with a blue center, a shadow and white border, test different designs)
            //set the size as 12px and offset to -6 (so that its centered)
        }
    }
}
class Bar:Element{
    
}
