import Cocoa
@testable import Utils
@testable import Element
//TODO: try RBSliderView next
//TODO: Sliderview needs fadeout fade in etc.
class RepoDetailView:ElasticSlideScrollView2/*RBScrollView*//**//*RBSliderView*/{
    override var height:CGFloat {get{return super.height-48}set{super.height = newValue}}//lazy fix, you can use negative height padding to acchive the same thing
    override var itemsHeight:CGFloat {return (12 * 24)+64}
    override var itemHeight:CGFloat {return 24}
    /*TextInput*/
    var nameTextInput:TextInput?
    var localPathTextInput:TextInput?
    var remotePathTextInput:TextInput?
    var branchTextInput:TextInput?
    /*CheckButtons*/
    var uploadCheckBoxButton:CheckBoxButton?
    var downloadCheckBoxButton:CheckBoxButton?
    var activeCheckBoxButton:CheckBoxButton?
    var messageCheckBoxButton:CheckBoxButton?
    var intervalCheckBoxButton:CheckBoxButton?
    var fileChangeCheckBoxButton:CheckBoxButton?
    var pullCheckBoxButton:CheckBoxButton?
    /*LeverSpinner*/
    var autoSyncIntervalLeverSpinner:LeverSpinner?
    
    override func resolveSkin() {
        super.resolveSkin()/*self.skin = SkinResolver.skin(self)*/
        //Swift.print("RepoDetailView.width: " + "\(width)")
        
        nameTextInput = lableContainer!.addSubView(TextInput(width, 32, "Name: ", "", lableContainer))
        localPathTextInput = lableContainer!.addSubView(TextInput(width, 32, "Local-path: ", "", lableContainer))
        remotePathTextInput = lableContainer!.addSubView(TextInput(width, 32, "Remote-path: ", "", lableContainer))
        branchTextInput = lableContainer!.addSubView(TextInput(width, 32, "Branch: ", "", lableContainer))//branch-text-input: master is default, set to dev for instance
        autoSyncIntervalLeverSpinner = lableContainer!.addSubView(LeverSpinner(width, 32, "Interval: ", 0, 1, Int.min.cgFloat, Int.max.cgFloat, 0, 100, 200, lableContainer))
        downloadCheckBoxButton = lableContainer!.addSubView(CheckBoxButton(width, 32, "Upload:", false, lableContainer))
        uploadCheckBoxButton = lableContainer!.addSubView(CheckBoxButton(width, 32, "Download:", false, lableContainer))//to disable an item uncheck broadcast and subscribe
        pullCheckBoxButton = lableContainer!.addSubView(CheckBoxButton(width, 32, "Pull to refresh:", false, lableContainer))
        fileChangeCheckBoxButton = lableContainer!.addSubView(CheckBoxButton(width, 32, "File change:", false, lableContainer))
        messageCheckBoxButton = lableContainer!.addSubView(CheckBoxButton(width, 32, "Auto message:", false, lableContainer))
        activeCheckBoxButton = lableContainer!.addSubView(CheckBoxButton(width, 32, "Active:", false, lableContainer))//if auto sync is off then a manual commit popup dialog will appear (with pre-populated text)
        intervalCheckBoxButton = lableContainer!.addSubView(CheckBoxButton(width, 32, "Interval:", false, lableContainer))
    }
    /**
     * Modifies the dataProvider item on UI change
     * TODO: Collectivly test for event type, then anrrow down on origin
     * TODO: Might need to change to origin testing since these items now are in the container. So event.orgin === downloadButoon.checkBox
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
        }else if(event == (Event.update,localPathTextInput!)){
            attrib[RepoItemType.localPath] = (event as! TextFieldEvent).stringValue
        }else if(event == (Event.update,remotePathTextInput!)){
            attrib[RepoItemType.remotePath] = (event as! TextFieldEvent).stringValue
        }else if(event == (Event.update,remotePathTextInput!)){
            attrib[RepoItemType.branch] = (event as! TextFieldEvent).stringValue
        }
        /*CheckButtons*/
        else if(event == (CheckEvent.check,uploadCheckBoxButton!)){
            attrib[RepoItemType.upload] = String((event as! CheckEvent).isChecked)
        }else if(event == (CheckEvent.check,downloadCheckBoxButton!)){
            attrib[RepoItemType.download] = String((event as! CheckEvent).isChecked)
        }else if(event == (CheckEvent.check,activeCheckBoxButton!)){
            attrib[RepoItemType.active] = String((event as! CheckEvent).isChecked)
        }else if(event == (CheckEvent.check,messageCheckBoxButton!)){
            attrib[RepoItemType.autoCommitMessage] = String((event as! CheckEvent).isChecked)
        }else if(event == (CheckEvent.check,pullCheckBoxButton!)){
            attrib[RepoItemType.pullToAutoSync] = String((event as! CheckEvent).isChecked)
        }else if(event == (CheckEvent.check,fileChangeCheckBoxButton!)){
            attrib[RepoItemType.fileChange] = String((event as! CheckEvent).isChecked)
        }else if(event == (CheckEvent.check,intervalCheckBoxButton!)){
            attrib[RepoItemType.autoSyncInterval] = String((event as! CheckEvent).isChecked)
        }else{//forward other events
            super.onEvent(event)
        }
        node.setAttributeAt(i, attrib)
    }
}
extension RepoDetailView{
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
