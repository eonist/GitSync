//import utils/xml/XMLParser.swift
//import utils/misc/shell/ShellUtils.swift
//import utils/string/regexp/RegExpParser.swift
//import utils/string/regexp/RegExpModifier.swift

class GitSync{
	//Properties:
	let currentTime:Int = 0 //keeps track of the time passed, remember to reset this value pn every init
	let theInterval:Int = 60 //static value, increases the time by this value on every interval--TODO: rename to "frequncy"
	var repoList:Array = null //Stores all values the in repositories.xml, remember to reset this value pn every init
	let repoFilePath:String = ""
	let options = ["keep local version", "keep remote version", "keep mix of both versions", "open local version", "open remote version", "open mix of both versions", "keep all local versions", "keep all remote versions", "keep all local and remote versions", "open all local versions", "open all remote versions", "open all mixed versions"]
	var currentTime:Int = 0 //always reset this value on init, applescript has persistent values

	/*
	 * Handles the process of comitting, pushing for multiple repositories
	 * This is called on every interval
	 * NOTE: while testing you can call this manually, since idle will only work when you run it from an .app
	 */
	func handleInterval(){
		//print( "handle_interval()")
		repoList = RepoUtil.compileRepoList(repoFilePath) //try to avoid calling this on every intervall, its nice to be able to update on the fly, be carefull though
		let currentTimeInMin to (currentTime / 60) //divide the seconds by 60 seconds to get minutes
		//print ("currentTimeInMin: " + currentTimeInMin)
		for (repoItem in repoList){//iterate over every repo item
			if (currentTimeInMin % (repoItem["interval"]) = 0) { handleCommitInterval(repo_item, "master") } //is true every time spesified by the user
			if (currentTimeInMin % (repoItem["interval"]) = 0) { handlePushInterval(repo_item, "master") }//is true every time spesified by the user
		}
		current_time += theInterval //increment the interval (in seconds)
	}
	/*
	 * Handles the process of making a commit for a single repository
	 */
	func handleCommitInterval(repoItem, branch){
		//log "GitSync's handle_commit_interval() a repo with remote path: " & (remote_path of repo_item) & " local path: " & (local_path of repo_item)
		if (GitAsserter.hasUnmMergedPaths(repoItem["localPath"])) { //Asserts if there are unmerged paths that needs resolvment
			//log tab & "has unmerged paths to resolve"
			MergeUtil.resolveMergeConflicts(repoItem["localPath"], branch, GitParser.unMergedFiles(repoItem["localPath"])) //Asserts if there are unmerged paths that needs resolvment
		}
		doCommit(local_path of repo_item) //if there were no commits false will be returned
		//log "has_commited: " & has_commited
	}
	/*
	 * Handles the process of making a push for a single repository
	 * NOTE: We must always merge the remote branch into the local branch before we push our changes. 
	 * NOTE: this method performs a "manual pull" on every interval
	 * TODO: contemplate implimenting a fetch call after the pull call, to update the status, whats the diff between git fetch and git remote update again?
	 */
	func handlePushInterval(repo_item, branch){
		log ("GitSync's handle_push_interval()")
		my MergeUtil's manual_merge((local_path of repo_item), (remote_path of repo_item), branch) --commits, merges with promts, (this method also test if a merge is needed or not, and skips it if needed)
		set has_local_commits to GitAsserter's has_local_commits((local_path of repo_item), branch) --TODO: maybe use GitAsserter's is_local_branch_ahead instead of this line
		if (has_local_commits) then --only push if there are commits to be pushed, hence the has_commited flag, we check if there are commits to be pushed, so we dont uneccacerly push if there are no local commits to be pushed, we may set the commit interval and push interval differently so commits may stack up until its ready to be pushed, read more about this in the projects own FAQ
			set the_keychain_item_name to (keychain_item_name of repo_item)
			log "the_keychain_item_name: " & the_keychain_item_name
			set keychain_data to KeychainParser's keychain_data(keychain_item_name of repo_item)
			set keychain_password to the_password of keychain_data
			log "keychain_password: " & keychain_password
			set remote_account_name to account_name of keychain_data
			log "remote_account_name: " & remote_account_name
			set push_call_back to GitModifier's push(local_path of repo_item, remote_path of repo_item, remote_account_name, keychain_password, branch)
			log "push_call_back: " & push_call_back
		end if
	}
	/*
	 * This method generates a git status list,and asserts if a commit is due, and if so, compiles a commit message and then tries to commit
	 * Returns true if a commit was made, false if no commit was made or an error occured
	 * NOTE: checks git staus, then adds changes to the index, then compiles a commit message, then commits the changes, and is now ready for a push
	 * NOTE: only commits if there is something to commit
	 * TODO: add branch parameter to this call
	 * NOTE: this a purly local method, does not need to communicate with remote servers etc..
	 */
	func doCommit(localRepoPath){
		//log ("GitSync's do_commit()")
		//--log "do_commit"
		set statusList:Array = StatusUtils.generateStatusList(localRepoPath) //--get current status
		if (statusList.count > 0) {
			//log tab & "there is something to add or commit"
			//--log tab & "length of status_list: " & (length of statusList)
			my StatusUtil's process_status_list(localRepoPath, statusList) //--process current status by adding files, now the status has changed, some files may have disapared, some files now have status as renamed that prev was set for adding and del
			set commit_msg_title to my CommitUtil's sequence_commit_msg_title(statusList) //--sequence commit msg title for the commit
			//log tab & "commit_msg_title: " & commit_msg_title
			set commit_msg_desc to my DescUtil's sequence_description(statusList) //--sequence commit msg description for the commit
			//log tab & "commit_msg_desc: " & commit_msg_desc
			try --try to make a git commit
				set commit_result to GitModifier's commit(localRepoPath, commit_msg_title, commit_msg_desc) //--commit
				//log tab & "commit_result: " & commit_result
			on error errMsg
				//log tab & "----------------ERROR:-----------------" & errMsg
			end try
			return true //--return true to indicate that the commit completed
		}else{
			//log tab & "nothing to add or commit"
			return false //--break the flow since there is nothing to commit or process
		}
	}
}

class RepoUtils{//Utility methods for parsing the repository.xml file
	/**
	 * Returns a list with repo values derived from an XML file
 	 * @param file_path 
 	 * TODO: if the interval values is not set, then use default values
	 * TODO: test if the full/partly file path still works?
	 */
	func compileRepoList(filePath:String)->Array{
		let xml:String = XMLParser.data(filePath)
		let children:Array = xml["."]["repositories"][0]["."]["repository"]
		let numChildren:Int = children.count //number of xml children in xml root element
		var theRepoList:Array to []
		for (var i:Int; i++; i < numChildren){
			let child = children[i]
			let localPath to child["@"]["local-path"] //this is the path to the local repository (we need to be in this path to execute git commands on this repo)
			let localPath = ShellUtils.run("echo " + "'" + localPath + "'" + " | sed 's/ /\\\\ /g'")//--Shell doesnt handle file paths with space chars very well. So all space chars are replaced with a backslash and space, so that shell can read the paths. 
			let remotePath: String = child["@"]["remote_path"]
			remotePath = RegExpModifier.replace(remotePath,"^https://.+$","")//support for partial and full url, strip away the https://, since this will be added later
			//print(remotePath)
			let keychainItemName: String = child["@"]["keychain-item-name"]
			let interval: String = child["@"]["interval"]//default is 1min
			let remoteAccountName: String = child["@"]["remote-account-name"]
			theRepoList += ["localPath":localPath,"remotePath":remotePath,"keychainItemName":keychainItemName,"interval":interval,"remoteAccountName":remoteAccountName]
		}
		return theRepoList
	}
}

class MergeUtils{
	/*
 	 * Promts the user with a list of options to aid in resolving merge conflicts
 	 * @param branch: the branch you tried to merge into
 	 */
	func resolveMergeConflicts(localRepoPath, branch, unMergedFiles){
		//log "resolve_merge_conflicts()"
		//log ("MergeUtil's resolve_merge_conflicts()")
		for( unMergedFile in unMergedFiles){;
			let lastSelectedAction:String = options.first //you may want to make this a "property" to store the last item more permenantly
			let listWindow = ListWindow(options,headerTitle:"Resolve merge conflict in: ",title:unMergedFile + ":",selected:lastSelectedAction,cancelButtonName:"Exit")//promt user with list of options, title: Merge conflict in: unmerged_file
			listWindow.addTarget(self, action: "Complete: ", forControlEvents: .complete)
		}
	}
	func complete(sender: ListWindow!) {
	   print("Complete: " + sender.tag)
	   if(sender.didComplete){
			handleMergeConflictDialog(sender.didComplete, sender.selected, unMergedFile, localRepoPath, branch, unMergedFiles)
	   }else{
	   	//TODO: do the git merge --abort here to revert to the state you were in before the merge attempt, you may also want to display a dialog to informnthe user in which state the files are now.
	   }
	}
	/*
 	 * Handles the choice made in the merge conflict dialog
 	 * TODO: test the open file clauses
 	 */
	func handleMergeConflictDialog(selected:String, unmergedFile:String, localRepoPath:String, branch:String, unmergedFiles:Array){
		//log "handle_merge_conflict_dialog()"
		//print("MergeUtil's handle_merge_conflict_dialog(): " & (item 1 of the_action))
		//last_selected_action = selected
		switch selected{
			case options[0]//keep local version
				GitModifier.checkOut(localRepoPath, "--ours", unmergedFile)//continue here
			case options[1]//keep remote version
				GitModifier.checkOut(localRepoPath, "--theirs", unmergedFile)
			case options[2]//keep mix of both versions
				GitModifier.checkOut(localRepoPath, branch, unmergedFile)
			case options[3]//open local version
				GitModifier's check_out(localRepoPath, "--ours", unmergedFile)
				FileUtils.openFile(localRepoPath + unmergedFile)
			case options[4]//open remote version
				GitModifier.checkOut(localRepoPath, "--theirs", unmergedFile)
				FileUtils.openFile(localRepoPath + unmergedFile)
			case options[5]//open mix of both versions
				GitModifier.checkOut(localRepoPath, branch, unmergedFile)
				FileUtils.(localRepoPath + unmergedFile)
			case options[6]//keep all local versions
				GitModifier.checkOut(localRepoPath, "--ours", "*")
			case options[7]//keep all remote versions
				GitModifier.checkOut(localRepoPath, "--theirs", "*")
			case options[8]//keep all local and remote versions
				GitModifier.checkOut(localRepoPath, branch, "*")
			case options[9]//open all local versions
				GitModifier.checkOut(localRepoPath, "--ours", "*")
				FileUtils.openFiles(localRepoPath+unmergedFiles)
			case options[10]//open all remote versions
				GitModifier.checkOut(localRepoPath, "--theirs", "*")
				FileUtils.openFiles(localRepoPath+ unmergedFiles)
			case options[11]//open all mixed versions
				GitModifier.checkOut(localRepoPath, branch, "*")
				FileUtils.openFiles(localRepoPath+ unmergedFiles)
			default
				break;
		}
	}
}
/*
 * single choice list window
 */
class ListWindow : Window{
	var list:Array
	var headerTitle:String
	var title:String
	var lastSelected:String
	var cancelButtonName:String
	/**
	 * 
	 */
	override func init(list:Array,headerTitle:String,title:String ,selected:String,cancelButtonName:String){
		init(width:300,height:800,headerTitle:headerTitle)
		self.list = list
		self.headerTitle = headerTitle
		self.title = title
		self.selected = selected
		self.cancelButtonName = cancelButtonName
		createContent()
		addTargets()
	}
	func createContent(){
		
		//list here	
		let list = List(list:self.list,selected:selected,multiSelect:false)
		self.view.addSubview(list)
		
		//container for the buttons
		let buttonContainer:Container = Container(240,60)
		self.view.addSubview(buttonContainer)
		
		let okButton = UIButton()
		okButton.setTitle("OK", forState: .Normal)
		okButton.setTitleColor(UIColor.blueColor(), forState: .Normal)
		okButton.frame = CGRectMake(0, 0, 120, 40)
		buttonContainer.addChild(okButton)
		
		//exit button here
		let exitButton = UIButton()
		exitButton.setTitle(cancelButtonName, forState: .Normal)
		exitButton.setTitleColor(UIColor.blueColor(), forState: .Normal)
		exitButton.frame = CGRectMake(0, 0, 120, 40)
		buttonContainer.addChild(exitButton)
		 
		//align the ui items
		list.align = .CENTER
		buttonContainer.align = .CENTER
		okButton.align = .CENTER_LEFT
		exitButton.align = .CENTER_RIGHT
	}
	// 
	func addTargets(){
		okButton.addTarget(self, action: "pressedAction:", forControlEvents: .TouchUpInside)
	}
	//delegate handlers
	func pressedAction(sender: UIButton!) {
	   // do your stuff here 
	  print("you clicked on button %@" + sender.tag)
	  if(sender.tag == "ok"){
	  	//dispatch complete event with ok, and selected choice
	  }else{//exit
	  	//dispatch complete event with exit 
	  }
	}
}










