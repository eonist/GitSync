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
			StatusUtils.processStatusList(localRepoPath, statusList) //--process current status by adding files, now the status has changed, some files may have disapared, some files now have status as renamed that prev was set for adding and del
			set commitMsgTitle = CommitUtils.sequenceCommitMsgTitle(statusList) //--sequence commit msg title for the commit
			//log tab & "commit_msg_title: " & commit_msg_title
			let commitMsgDesc = DescUtil.sequenceDescription(statusList) //--sequence commit msg description for the commit
			//log tab & "commit_msg_desc: " & commit_msg_desc
			do {//--try to make a git commit
				try let commitResult to GitModifiers.commit(localRepoPath, commitMsgTitle, commitMsgDesc) //--commit
			   //log tab & "commit_result: " & commit_result
			} catch let error as NSError {
			    print ("Error: \(error.domain)")
				 //log tab & "----------------ERROR:-----------------" & errMsg
			}
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
 * Utils for paraing the git status list
 */
class StatusUtils{
	/*
	 * Returns a descriptive status list of the current git changes
	 * NOTE: you may use short staus, but you must interpret the message if the state has an empty space infront of it
	 */
	func generate_status_list(localRepoPath){
		
		//continue here 
		//also move internal classes to a folder structure in the project, this is not a library or an applescript that needs to be one file
		
		set the_status to GitParser's status(localRepoPath, "-s") -- the -s stands for short message, and returns a short version of the status message, the short stauslist is used because it is easier to parse than the long status list
		--log tab & "the_status: " & the_status
		set the_status_list to TextParser's every_paragraph(the_status) --store each line as items in a list
		set transformed_list to {}
		if (length of the_status_list > 0) then
			set transformed_list to my transform_status_list(the_status_list)
		else
			--log "nothing to commit, working directory clean" --this is the status msg if there has happened nothing new since last, but also if you have commits that are ready for push to origin
		end if
		--log "len of the_status_list: " & (length of the_status_list)
		--log transformed_list
		return transformed_list
	}
	/*
 	 * Transforms the "compact git status list" by adding more context to each item (a list with acociative lists, aka records)
 	 * Returns a list with records that contain staus type, file name and state
 	 * NOTE: the short status msg format is like: "M" " M", "A", " A", "R", " R" etc
 	 * NOTE: the space infront of the capetalized char indicates Changes not staged for commit:
 	 * NOTE: Returns = renamed, M = modified, A = addedto index, D = deleted, ?? = untracked file
	 * NOTE: the state can be:  "Changes not staged for commit" , "Untracked files" , "Changes to be committed"
	 * @Param: the_status_list is a list with status messages like: {"?? test.txt"," M index.html","A home.html"}
	 * NOTE: can also be "UU" unmerged paths
 	 */
	func transform_status_list(the_status_list){
		set transformed_list to {}
		repeat with the_status_item in the_status_list
			--log "the_status_item: " & the_status_item
			set the_status_parts to RegExpUtil's match(the_status_item, "^( )*([MARDU?]{1,2}) (.+)$") --returns 3 capturing groups, 
			--log "length of the_status_parts: " & (length of the_status_parts)
			--log the_status_parts
			if ((second item in the_status_parts) = " ") then --aka " M", remember that the second item is the first capturing group
				set cmd to third item in the_status_parts --Changes not staged for commit:
				set state to "Changes not staged for commit" -- you need to add them
			else -- Changes to be committed--aka "M " or  "??" or "UU"
				set cmd to third item in the_status_parts --rename cmd to type
				--log "cmd: " & cmd
				if (cmd = "??") then
					set state to "Untracked files"
				else if (cmd = "UU") then --Unmerged path
					--log "Unmerged path"
					set state to "Unmerged path"
				else
					set state to "Changes to be committed" --this is when the file is ready to be commited
				end if
			end if
			set file_name to the fourth item in the_status_parts
			--log "state: " & state & ", cmd: " & cmd & ", file_name: " & file_name --logs the file named added changed etc
			set status_item to {state:state, cmd:cmd, file_name:file_name} --store the individual parts in an accociative
			set transformed_list to ListModifier's add_list(transformed_list, status_item) --add a record to a list
		end repeat
		return transformed_list
	end transform_status_list
	/*
	 * Iterates over the status items and "git add" the item unless it's already added (aka "staged for commit")
	 * NOTE: if the status list is empty then there is nothing to process
	 * NOTE: even if a file is removed, its status needs to be added to the next commit
	 * TODO: Squash some of the states together with if or or or etc
	 */
	func process_status_list(localRepoPath, status_list){
		--log "process_status_list()"
		repeat with status_item in status_list
			--log "len of status_item: " & (length of status_item)
			set state to state of status_item
			--set cmd to cmd of status_item
			set file_name to file_name of status_item
			if state = "Untracked files" then --this is when there exists a new file
				log tab & "1. " & "Untracked files"
				GitModifier's add(localRepoPath, file_name) --add the file to the next commit
			else if state = "Changes not staged for commit" then --this is when you have not added a file that has changed to the next commit
				log tab & "2. " & "Changes not staged for commit"
				GitModifier's add(localRepoPath, file_name) --add the file to the next commit
			else if state = "Changes to be committed" then --this is when you have added a file to the next commit, but not commited it
				log tab & "3. " & "Changes to be committed" --do nothing here
			else if state = "Unmerged path" then --This is when you have files that have to be resolved first, but eventually added aswell
				log tab & "4. " & "Unmerged path"
				GitModifier's add(localRepoPath, file_name) --add the file to the next commit
			end if
		end repeat
	}
}
/*
 * single choice list window, similar to applescript's "choose from list" Dialog Window
 * Todo: rename to ChooseFromListWinow?
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










