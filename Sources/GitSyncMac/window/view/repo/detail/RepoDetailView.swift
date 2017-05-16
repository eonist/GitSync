import Cocoa
@testable import Utils
@testable import Element

class RepoDetailView:ElasticSlideScrollView3 {
    override var maskSize:CGSize {return CGSize(super.width,super.height-48)}
    override var contentSize:CGSize {return CGSize(NaN,(12 * 24)+64) }
    override var itemSize:CGSize {return CGSize(NaN,24)}
    /*TextInput*/
    lazy var nameTextInput:TextInput = {
         return self.contentContainer.addSubView(TextInput(self.width, 32, "Name: ", "", self.contentContainer))
    }()
    lazy var localPathTextInput:TextInput = {
         return self.contentContainer.addSubView(TextInput(self.width, 32, "Local-path: ", "", self.contentContainer))
    }()
    lazy var remotePathTextInput:TextInput = {
        return self.contentContainer.addSubView(TextInput(self.width, 32, "Remote-path: ", "", self.contentContainer))
    }()
    lazy var branchTextInput:TextInput = {
        return self.contentContainer.addSubView(TextInput(self.width, 32, "Branch: ", "", self.contentContainer))//branch-text-input: master is default, set to dev for instance
    }()
    /*CheckButtons*/
    lazy var uploadCheckBoxButton:CheckBoxButton = {
        return contentContainer.addSubView(CheckBoxButton(width, 32, "Upload:", false, contentContainer))
    }()
    lazy var downloadCheckBoxButton:CheckBoxButton = {
        
    }()
    lazy var activeCheckBoxButton:CheckBoxButton = {
        
    }()
    var messageCheckBoxButton:CheckBoxButton?
    var intervalCheckBoxButton:CheckBoxButton?
    var fileChangeCheckBoxButton:CheckBoxButton?
    var pullCheckBoxButton:CheckBoxButton?
    /*LeverSpinner*/
    lazy var autoSyncIntervalLeverSpinner:LeverSpinner {
        return self.contentContainer.addSubView(LeverSpinner(self.width, 32, "Interval: ", 0, 1, Int.min.cgFloat, Int.max.cgFloat, 0, 100, 200, self.contentContainer))
    }()
    
    override func resolveSkin() {
        super.resolveSkin()/*self.skin = SkinResolver.skin(self)*/
        //Swift.print("RepoDetailView.width: " + "\(width)")
        _ = nameTextInput
        _ = localPathTextInput
        _ = remotePathTextInput
        _ = branchTextInput
        _ = autoSyncIntervalLeverSpinner
        downloadCheckBoxButton =
        uploadCheckBoxButton = contentContainer.addSubView(CheckBoxButton(width, 32, "Download:", false, contentContainer))//to disable an item uncheck broadcast and subscribe
        activeCheckBoxButton = contentContainer.addSubView(CheckBoxButton(width, 32, "Active:", false, contentContainer))//if auto sync is off then a manual commit popup dialog will appear (with pre-populated text)
        pullCheckBoxButton = contentContainer.addSubView(CheckBoxButton(width, 32, "Pull to refresh:", false, contentContainer))
        fileChangeCheckBoxButton = contentContainer.addSubView(CheckBoxButton(width, 32, "File change:", false, contentContainer))
        messageCheckBoxButton = contentContainer.addSubView(CheckBoxButton(width, 32, "Auto message:", false, contentContainer))
        intervalCheckBoxButton = contentContainer.addSubView(CheckBoxButton(width, 32, "Interval:", false, contentContainer))
    }
    /**
     * Modifies the dataProvider item on UI change
     * TODO: Collectivly test for event type, then anrrow down on origin
     * TODO: Might need to change to origin testing since these items now are in the container. So event.orgin === downloadButoon.checkBox
     * TODO: ⚠️️ enumify this method? at least usw switch
     */
    override func onEvent(_ event:Event) {
        Swift.print("onEvent: type: " + "\(event.type) immediate: \(event.immediate) origin: \(event.origin)")
        let idx3d:[Int] = RepoView.selectedListItemIndex
        guard var attrib:[String:String] = RepoView.treeDP.tree[idx3d]?.props else{
            fatalError("no attribs at: \(idx3d)")
        }
        /*LeverSpinner*/
        if event == (SpinnerEvent.change, autoSyncIntervalLeverSpinner!) {
            attrib[RepoItemType.interval] = (event as! SpinnerEvent).value.string
        }else if event.type == Event.update {
            switch true{
                /*TextInput*/
                case event.isChildOf(nameTextInput):
                    attrib[RepoItemType.title] = nameTextInput!.inputString
                case event.isChildOf(localPathTextInput):
                    attrib[RepoItemType.localPath] = localPathTextInput!.inputString
                case event.isChildOf(remotePathTextInput):
                    attrib[RepoItemType.remotePath] = remotePathTextInput!.inputString
                case event.isChildOf(branchTextInput):
                    attrib[RepoItemType.branch] = branchTextInput!.inputString
                default:
                    break;
                }
        }else if event.type == CheckEvent.check{
            switch true{
                /*CheckButtons*/
                case event.isChildOf(uploadCheckBoxButton!):
                    attrib[RepoItemType.upload] = uploadCheckBoxButton!.getChecked().str//String((event as! CheckEvent).isChecked)
                case event.isChildOf(downloadCheckBoxButton!):
                    attrib[RepoItemType.download] = downloadCheckBoxButton!.getChecked().str
                case event.isChildOf(activeCheckBoxButton)://TODO: <---use getChecked here
                    attrib[RepoItemType.active] = activeCheckBoxButton!.getChecked().str
                case event.isChildOf(messageCheckBoxButton):
                    attrib[RepoItemType.autoCommitMessage] = messageCheckBoxButton!.getChecked().str
                case event.isChildOf(pullCheckBoxButton):
                    attrib[RepoItemType.pullToAutoSync] = pullCheckBoxButton!.getChecked().str
                case event.isChildOf(fileChangeCheckBoxButton):
                    attrib[RepoItemType.fileChange] = fileChangeCheckBoxButton!.getChecked().str
                case event.isChildOf(intervalCheckBoxButton):
                    attrib[RepoItemType.autoSyncInterval] = intervalCheckBoxButton!.getChecked().str
                default:
                    break;
            }
        }else{
            super.onEvent(event)//forward other events
        }
        if(event.type == CheckEvent.check || event.type == Event.update || event.type == SpinnerEvent.change){
            //Swift.print("✨ Update dp with: attrib: " + "\(attrib)")
            RepoView.treeDP.tree[idx3d]!.props = attrib//RepoView.node.setAttributeAt(i, attrib)
            if let tree:Tree = RepoView.treeDP.tree[idx3d]{
                Swift.print("title: " + "\(tree.props?["title"])")
                //Swift.print("node.xml.xmlString: " + "\(tree.xml.xmlString)")
            }
        }
    }
}
extension RepoDetailView{
    /**
     * Populates the UI elements with data from the dp item
     */
    func setRepoData(_ repoItem:RepoItem){
        nameTextInput!.inputTextArea.setTextValue(repoItem.title)
        localPathTextInput!.inputTextArea.setTextValue(repoItem.localPath)
        remotePathTextInput!.inputTextArea.setTextValue(repoItem.remotePath)
        branchTextInput!.inputTextArea.setTextValue(repoItem.branch)
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
