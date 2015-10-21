let str =   "- [ ] second" + "\n" +
            " - [X] a"+"\n" +//+
            " - [ ] b"+"\n" +
            " - [X] c" + "\n" +
            " - [ ] d" + "\n" +
            " - [X] e" + "\n" +
            "- [X] first" + "\n" +
            " - [X] f" + "\n" +
            " - [X] g" + "\n" +
            " - [X] h"

/*
The Array/Dictionary tree structure: (square brackets = Array, curly brackets = Dictionary)
[
    {
        folder:{
                    bool:X,
                    title:task1
                }
        content:[
                    {
                        bool:X
                        title:subTask1
                    }
                    {
                        bool:X
                        title:subTask1
                    }
                ]
    }
]
*/

let taskList = TaskParser.tasks(str)//parse the Markdown task list into an Array/Dictionary structure
var sortedTaskList = TaskModifier.sort(taskList)//Sort in ascending order
sortedTaskList = TaskModifier.sort(taskList,true)//Sort in descending order
TaskTraverser.traverseTree(sortedTaskList)//prints the result
