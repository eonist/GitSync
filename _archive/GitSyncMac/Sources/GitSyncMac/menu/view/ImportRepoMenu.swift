class ImportReposMenu: CustomMenuItem{
    override func onSelect(event: AnyObject) {
        //grab the xml

        //prompt the file viewer
        let dialog: NSOpenPanel = NSOpenPanel()
        dialog.directoryURL = "~/Desktop/".tildePath.url
        let respons = dialog.runModal()
        //let thePath:String? = dialog.url?.path /*Get the path to the file chosen in the NSOpenPanel*/

        //TODO: use two guards on the bellow instead

        if let url = dialog.url, respons == NSApplication.ModalResponse.OK {/*Make sure that a path was chosen*/
            if let xml = url.path.tildePath.content?.xml{
                RepoView._treeDP = TreeDP(xml)
            }
        }
    }
}
