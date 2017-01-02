When you are scrolling at high speed, you are pulling out items from dp.items at the edges of the view

If you change the dp while scrolling, what happens?


You need to do many test with fast list
- small lists (how does fast list behave?)✅ (fixed now)
- Long list to smaller list (keep visual position) 🏀
- Long list to tiny list (align list to top I guess) 
- Small list to long list 
- No list to small list
- No list to long list
- New list to list
- Adjust ListSize -> (add/remove items from the VisibleItems arr)

1. Try to maintain the position index when transitioning between lists.
2. If your moving when the transition happens, try to copy the momentum of the animation.


## Thoughts: 💭

- The current FastList is very "Item-centric" when animating the list. It may be easier to build FastList around moving a very tall view instead. The current implementation calculates the position of a virtual view, and then offsets the items accordingly, but the code is complicated and future additions to the code may prove hard to accomplish. A really tall view may be easier to reason with when adding new features as long as Apple hasn't put any restrictions on very tall views. 

- The First iteration of the FastList will have problems with list that are bellow the maxVisible height. Try doing the tall-view idea. With the intimate knowledge of building the First iteration of the fast list it should not be to difficult to implement the tall-view idea. Start by drawing on paper and putting down some code ideas.

## Brainstorm log: 🔬

itemContainer.height = Item.height * items.count

onProgress -> you move the itemContainer.y up and down
onProgress -> you calculate the visible top and bottom of the itemContainer
onProgress -> you calculate the item.y above top and bellow bottom -> use modulo
onProgress -> you find the index of the top-item -> use modulo
onProgress -> you place items at index * itemHeight -> in the itemContainer
onProgress -> you set item.y on a modulo-loop 🔑 -> Basically you use item.index % num_of_items_to_cover -> remainder -> 4 -> iterate dp.items.count times from 4 but pin between min and max
onProgress -> figure out how to apply data to new visible items -> we could use a temp prevVisibleRange and figure out which items to remove and add

setSize -> reCalc num_of_items_to_cover -> and add/remove visibleItems accordingly
setSize -> adjust the mask