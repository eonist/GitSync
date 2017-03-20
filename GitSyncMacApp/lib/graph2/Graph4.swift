import Foundation

//Final concept: 

//1. The TimeIndicator: (Top center)
    //shows the time range. 
    //Iterates on scroll

//2. The TimeBar (bottom)
    //ElasticSlidable
    //Elegantly Snaps to whole values (avoids masked out text, and enables elegant graph.y anims)
    //7 values

//3. The ValueBar (left)
    //Changes onGraphAnimComplete
    //5 values

//4. The graph (center)
    //Animates onScrollMomentumComplete /onSnapToPositionComplete
    //7 GraphPoints for (hours,days,weeks,months,years)
    //Zoom in and out of timeUnitStates via pinch zoom gesture.
    //Zoom in of the timeRange that is hovered above

//5. Data handeling:
    //calculate Git values for Graph onSnapToPositionComplete, onViewLoad, timer
    //When a new TimeUnit occures. from 16 to 17 for instance, or Mon to Tue. Then Animate to 
class Graph4 {

}
