import Cocoa
@testable import Utils
@testable import Element

class RepoDetailView:Element,i {
    var nameTextInput:TextInput?
    var localPathTextInput:TextInput?
    var remotePathTextInput:TextInput?
    var branchTextInput:TextInput?
    var uploadCheckBoxButton:CheckBoxButton?
    var downloadCheckBoxButton:CheckBoxButton?
    /*CheckButtons*/
    var activeCheckBoxButton:CheckBoxButton?
    var messageCheckBoxButton:CheckBoxButton?
    var intervalCheckBoxButton:CheckBoxButton?
    var fileChangeCheckBoxButton:CheckBoxButton?
    var pullCheckBoxButton:CheckBoxButton?
    /*LeverSpinner*/
    var autoSyncIntervalLeverSpinner:LeverSpinner?
    var container:Container?
    /*RubberBand*/
    var mover:RubberBand?
    var prevScrollingDeltaY:CGFloat = 0/*this is needed in order to figure out which direction the scrollWheel is going in*/
    var velocities:[CGFloat] = Array(repeating: 0, count: 10)/*represents the velocity resolution of the gesture movment*/
    var progressValue:CGFloat?//<--same as progress but unclamped (because RBSliderList may go beyond 0 to 1 values etc)
    /*Slider*/
    var slider:VSlider?
    var sliderInterval:CGFloat?
    let itemsHeight:CGFloat = 600
    override func resolveSkin() {
        self.skin = SkinResolver.skin(self)//super.resolveSkin()
        //Swift.print("RepoDetailView.width: " + "\(width)")
        container = addSubView(Container(width,height,self,"items"))
        nameTextInput = container!.addSubView(TextInput(width, 32, "Name: ", "", container))
        localPathTextInput = container!.addSubView(TextInput(width, 32, "Local-path: ", "", container))
        remotePathTextInput = container!.addSubView(TextInput(width, 32, "Remote-path: ", "", container))
        branchTextInput = container!.addSubView(TextInput(width, 32, "Branch: ", "", container))//branch-text-input: master is default, set to dev for instance
        autoSyncIntervalLeverSpinner = container!.addSubView(LeverSpinner(width, 32, "Interval: ", 0, 1, Int.min.cgFloat, Int.max.cgFloat, 0, 100, 200, self))
        downloadCheckBoxButton = container!.addSubView(CheckBoxButton(width, 32, "Upload:", false, container))
        uploadCheckBoxButton = container!.addSubView(CheckBoxButton(width, 32, "Download:", false, container))//to disable an item uncheck broadcast and subscribe
        pullCheckBoxButton = container!.addSubView(CheckBoxButton(width, 32, "Pull to refresh:", false, container))
        fileChangeCheckBoxButton = container!.addSubView(CheckBoxButton(width, 32, "File change:", false, container))
        messageCheckBoxButton = container!.addSubView(CheckBoxButton(width, 32, "Auto message:", false, container))
        activeCheckBoxButton = container!.addSubView(CheckBoxButton(width, 32, "Active:", false, container))//if auto sync is off then a manual commit popup dialog will appear (with pre-populated text)
        intervalCheckBoxButton = container!.addSubView(CheckBoxButton(width, 32, "Interval:", false, container))
        
        /*RubberBand*/
        let frame = CGRect(0,0,width,height)/*represents the visible part of the content *///TODO: could be ranmed to maskRect
        let itemsRect = CGRect(0,0,width,itemsHeight)/*represents the total size of the content *///TODO: could be ranmed to contentRect
        mover = RubberBand(Animation.sharedInstance,setProgress,frame,itemsRect)
        mover!.event = onEvent/*Add an eventHandler for the mover object, avoids logging missing eventHandler, this has no functionality in this class, but may have in classes that extends this class*/
        /*slider*/
        let itemHeight:CGFloat = 24
        sliderInterval = floor(itemsHeight - height)/itemHeight// :TODO: use ScrollBarUtils.interval instead?// :TODO: explain what this is in a comment
        slider = addSubView(VSlider(itemHeight,height,0,0,self))
        let thumbHeight:CGFloat = SliderParser.thumbSize(height/itemsHeight, slider!.height)
        slider!.setThumbHeightValue(thumbHeight)
    }
    /**
     * NOTE: this method overides the Native NSView scrollWheel method
     */
    /*override func scrollWheel(with event: NSEvent) {
        scroll(event)//forward the event to the scrollExtension
        if(event.phase == NSEventPhase.changed){setProgress(mover!.result)}/*direct manipulation*/
        super.scrollWheel(with: event)/*keep forwarding the scrollWheel event for NSViews higher up the hierarcy to listen to*/
    }*/
    
    /**
     * Modifies the dataProvider item on UI change
     */
    override func onEvent(_ event:Event) {
        let i:[Int] = RepoView.selectedListItemIndex
        let node:Node = RepoView.node
        var attrib:[String:String] = XMLParser.attributesAt(node.xml, i)!
        
        /*LeverSpinner*/
        if(event == (SpinnerEvent.change, autoSyncIntervalLeverSpinner!)){
            attrib[RepoItemType.interval] = (event as! SpinnerEvent).value.string
        }
        /*TextInput*/
        else if(event == (Event.update,nameTextInput!)){
            attrib[RepoItemType.title] = (event as! TextFieldEvent).stringValue
        }
        else if(event == (Event.update,localPathTextInput!)){
            attrib[RepoItemType.localPath] = (event as! TextFieldEvent).stringValue
        }
        else if(event == (Event.update,remotePathTextInput!)){
            attrib[RepoItemType.remotePath] = (event as! TextFieldEvent).stringValue
        }
        else if(event == (Event.update,remotePathTextInput!)){
            attrib[RepoItemType.branch] = (event as! TextFieldEvent).stringValue
        }
        /*CheckButtons*/
        else if(event == (CheckEvent.check,uploadCheckBoxButton!)){
            attrib[RepoItemType.upload] = String((event as! CheckEvent).isChecked)
        }
        else if(event == (CheckEvent.check,downloadCheckBoxButton!)){
            attrib[RepoItemType.download] = String((event as! CheckEvent).isChecked)
        }
        else if(event == (CheckEvent.check,activeCheckBoxButton!)){
            attrib[RepoItemType.active] = String((event as! CheckEvent).isChecked)
        }
        else if(event == (CheckEvent.check,messageCheckBoxButton!)){
            attrib[RepoItemType.autoCommitMessage] = String((event as! CheckEvent).isChecked)
        }
        else if(event == (CheckEvent.check,pullCheckBoxButton!)){
            attrib[RepoItemType.pullToAutoSync] = String((event as! CheckEvent).isChecked)
        }
        else if(event == (CheckEvent.check,fileChangeCheckBoxButton!)){
            attrib[RepoItemType.fileChange] = String((event as! CheckEvent).isChecked)
        }
        else if(event == (CheckEvent.check,intervalCheckBoxButton!)){
            attrib[RepoItemType.autoSyncInterval] = String((event as! CheckEvent).isChecked)
        }
        
        
        node.setAttributeAt(i, attrib)
    }
}
extension RepoDetailView{
    /**
     * PARAM value: is the final y value for the lableContainer
     * TODO: Try to use a preCalculated itemsHeight, as this can be heavy to calculate for lengthy lists
     */
    func setProgress(_ value:CGFloat){
        //Swift.print("RBSliderList.setProgress() value: " + "\(value)")
        container!.frame.y = value/*<--this is where we actully move the labelContainer*/
        progressValue = value / -(itemsHeight - height)/*get the the scalar values from value.*/
        slider!.setProgressValue(progressValue!)
    }
    /**
     * Populates the UI elements with data from the dp item
     */
    func setRepoData(_ repoItem:RepoItem){
        nameTextInput!.inputTextArea!.setTextValue(repoItem.title)
        localPathTextInput!.inputTextArea!.setTextValue(repoItem.localPath)
        remotePathTextInput!.inputTextArea!.setTextValue(repoItem.remotePath)
        branchTextInput!.inputTextArea!.setTextValue(repoItem.branch)
        /*CheckButtons*/
        uploadCheckBoxButton!.setChecked(repoItem.upload)
        downloadCheckBoxButton!.setChecked(repoItem.download)
        messageCheckBoxButton!.setChecked(repoItem.autoCommitMessage)
        intervalCheckBoxButton!.setChecked(repoItem.autoSyncInterval)
        autoSyncIntervalLeverSpinner!.setValue(repoItem.interval.cgFloat)
        activeCheckBoxButton!.setChecked(repoItem.active)
        pullCheckBoxButton!.setChecked(repoItem.pullToAutoSync)
        fileChangeCheckBoxButton!.setChecked(repoItem.fileChange)
    }
}
