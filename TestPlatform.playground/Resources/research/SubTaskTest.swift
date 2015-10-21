import Foundation


//TODO: load string in playground

var str:String =    " - [ ] this is a todo item\n" +
    " - [X] another todo item here\n" +
" - [ ] third todo item"

SubTaskParser.tasks(str)

/**
* Returns a Markdown Task list as string
* TODO: Dont add \n to the last item in the array
*/
func sequence(taskItems:[Dictionary<String,String>])->String{
    var result = ""
    for taskItem in taskItems{
        result += "- [" + taskItem["bool"]! + "] " + taskItem["content"]! + "\n"
    }
    return result
}

//sequence(taskItems)
