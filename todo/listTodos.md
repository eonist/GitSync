When you are scrolling at high speed, you are pulling out items from dp.items at the edges of the view

If you change the dp while scrolling, what happens?


You need to do many test with fast list
- small lists (how does fast list behave?)
- Long list to small list (keep visual position)
- Small list to long list 
- No list to small list
- No list to long list
- New list to list

1. Try to maintain the position index when transitioning between lists.
2. If your moving when the transition happens, try to copy the momentum of the animation.


## Thoughts:

- The current FastList is very "Item-centric" when animating the list. It may be easier to buil FastList around moving a very tall view instead. The current implementation calculates the position of a virtual view, and then offsets the items accordingly, but the code is complicated and future additions to the code may prove hard to accomplish. A really tall view may be easier to reason with when adding new features as long as Apple hasn't put any restrictions on very tall views. 

- The First iteration of the FastList will have problems with list that are bellow the maxVisible height. Try doing the tall-view idea. With the intimate knowledge of building the First iteration of the fast list it should not be to difficult to implement the tall-view idea. Start by drawing on paper and putting down some code ideas.