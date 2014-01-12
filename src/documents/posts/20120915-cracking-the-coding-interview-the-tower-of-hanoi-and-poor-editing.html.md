```
title: Cracking the Coding Interview - The Tower of Hanoi and Poor Editing
link: http://codetype.wordpress.com/2012/09/15/cracking-the-coding-interview-the-tower-of-hanoi-and-poor-editing/
author: mablair2
description:
post_id: 434
created: 2012/09/15 22:39:48
created_gmt: 2012/09/15 14:39:48
comment_status: open
post_name: cracking-the-coding-interview-the-tower-of-hanoi-and-poor-editing
status: publish
layout: post
```

# Cracking the Coding Interview - The Tower of Hanoi and Poor Editing

I just finished the [Stack](http://en.wikipedia.org/wiki/Stack_\(abstract_data_type\)) section of [Cracking the Coding Interview](http://www.amazon.com/gp/product/098478280X/ref=as_li_qf_sp_asin_il_tl?ie=UTF8&camp=1789&creative=9325&creativeASIN=098478280X&linkCode=as2&tag=aplfopoex-20) and came across an old puzzle - [The Tower of Hanoi](http://en.wikipedia.org/wiki/Tower_of_Hanoi). I struggled with solving this problem. I wrote this elaborate, strange algorithm to try to solve it (which should have been a dead give-away that I had it wrong). Ironically enough, hidden in the 20-30 lines of code I wrote were the three lines of code I needed to solve the problem. Anyways, after beating my head in trying to solve this, I ended up going to the back of the book and looking up the solution. And found this pile of shit psuedocode. I've shortened the comments, but the content is the same.

``` c
moveDisks(int n, Tower origin, Tower destination, Tower buffer) {
	if (n <= 0) return; //Move top n - 1 disks from 1 to 2
	moveDisks(n-1, tower 1, tower 2, tower 3); //Move top from 1 to 3
	moveTop(tower 1, tower 3); //Move top n - 1 disks from 2 to 3
	moveDisks(n-1, tower 2, tower 3, tower 1);
}
```

 In this tiny amount of code, in over five revisions to her book, the author has managed to miss two errors.

  1. In the first line, Variables `origin`, `destination`, and `buffer` are declared, but then `tower 1`, `tower 2`, and `tower 3` are used. Which is which?
  2. In line 5, the comment says "Move top n-1 disks". Then, in lines 8-9, the author indicates that you move the top. Since you've already moved all the items in the stack but one, the bottom element, that line should read "move bottom".

Maybe these aren't huge issues, but since I was pretty frustrated with this problem, having to correct the solution didn't help my frustration. The correct code:

``` c
moveDisks(int n, Tower origin, Tower destination, Tower buffer) {
	if (n <= 0) return; //Move top n - 1 disks from origin to buffer
	moveDisks(n-1, origin, buffer, destination); //Move nth disk (the bottom disk) from origin to destination
	moveBottom(origin , destination); //Move top n - 1 disks from buffer to destination
	moveDisks(n-1, buffer, destination, origin); }
```

 I hope this helps somebody else who's working on this problem.