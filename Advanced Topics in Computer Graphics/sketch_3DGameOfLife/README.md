# Game of life 3D

Start: 05/10/2022<br/>
Deadline: 1 Month after start<br/>
Finished: 09/10/2022<br/>
Language used: Processing<br/>
Programs used: Processing 4.0.1<br/>


"Conway's Game of Life
The Game of Life, also known simply as Life, is a cellular automaton devised by the British mathematician John Horton Conway in 1970.[1] 
It is a zero-player game,[2][3] meaning that its evolution is determined by its initial state, requiring no further input. 
One interacts with the Game of Life by creating an initial configuration and observing how it evolves. 
It is Turing complete and can simulate a universal constructor or any other Turing machine."
-- https://en.wikipedia.org/wiki/Conway%27s_Game_of_Life --

Rules of my game of life:<br/>
if a node has 3 neighbours it becomes/stays alive. If a node has less than 2 or more then 3 neighbours it dies. if a node has 2 neighbours its state doesn't change. These are the base rules, but by changing the reanimate variable the rules can be changed however you want.<br/>
Math used<br/>
To find all the neighbours of each node I first did some exploration to figure out how each node is related to each other. Since each node has a index value that never changes I used that to figure out what all the index values are of the neighbours and then gave each node a list of neighbour indices. I figourde out that you can find each neighbour with:

n = width of grid

middle layer<br/>
index-n-1,  index-n, index-n+1, index-1, index+1, index+n-1, index+n, index+n+1
 
bottom layer<br/>
index-n-1-n*n, index-n-n*n, index-n+1-n*n, index-1-n*n, index+1-n*n, index+n-1-n*n, index+n-n*n, index+n+1-n*n, index-n*n<br/>
 
top layer <br/>
index-n-1+n*n, index-n+n*n, index-n+1+n*n, index-1+n*n, index+1+n*n, index+n-1+n*n, index+n+n*n, index+n+1+n*n, index+n*n<br/>

However when you use this you need to keep in mind that when a node is at the edge of the grid it will also add nodes that arent their neighbour. To fix this we first need to remove all nullpointer expections and afterward remove each neighbour that isnt a real neighbour but that does exist. To do this I compared each neighbour to the node in question if they had a x, y or z value that was further away than 1 step. If done properly each node should have between 7 and 26 neighbours.<br/>

Extermination: Since the most of fun for me is seeing the life form grow I created a function that kills off a variable percentage every varaible life cycles. <br/>

Resources used to code:<br/>
https://processing.org/

Personal review of this assignment<br/>
Making the 3D game of life was a lot fun. I always like making 3D animation with math. In this case I even came up with the math myself. Figuring out how to get every available neighbour and removing all the wrong neighbours was a lot of fun.

What did I learn during this assignment<br/>
Always double check if you are using the correct variables. At some point I was sure everything was correct, but after a couple hours I found that I used the i from a for loop instead of using that i to get the correct index from a list. After that everything worked.
