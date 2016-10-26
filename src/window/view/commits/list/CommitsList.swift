import Foundation

class CommitsList:RBSliderList {
    /**
     * NOTE: this method overrides the mergeAt method to facilitate special list items
     */
    override func mergeAt(objects: [Dictionary<String, String>], _ index: Int) {
        /**/var i:Int = index;
        //Swift.print("mergeAt: index: " + "\(index)");
        for object:Dictionary<String,String> in objects {// :TODO: use for i
            let item:CommitsListItem = CommitsListItem(width, itemHeight ,object["repo-name"]!, object["contributor"]!,object["title"]!,object["description"]!,object["date"]!, false, self.lableContainer)
            lableContainer!.addSubviewAt(item, i)/*the first index is reserved for the List skin, what?*/
            i++
        }
    }
    override func getClassType() -> String {
        return String(List)
    }
    
    //override onScollWheel
    
    //override onEvent -> SliderEvent.change
    
        //get the slider.progressValue
    
        //if the progressValue <  0.0
    
            //start progressing the ProgressIndicator
    
        //if the progressValue < - 0.1
    
            //go into refresh mode
    
            
}

//repo-name
//contributor
//title
//description
//date
