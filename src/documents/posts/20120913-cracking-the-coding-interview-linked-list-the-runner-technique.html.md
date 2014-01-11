```
title: Cracking the Coding Interview - Linked Lists - The Runner Technique
link: http://codetype.wordpress.com/2012/09/13/cracking-the-coding-interview-linked-list-the-runner-technique/
author: mablair2
description: 
post_id: 411
created: 2012/09/13 20:49:39
created_gmt: 2012/09/13 12:49:39
comment_status: open
post_name: cracking-the-coding-interview-linked-list-the-runner-technique
status: publish
layout: post
```

# Cracking the Coding Interview - Linked Lists - The Runner Technique

I've been going over the [Linked List](http://en.wikipedia.org/wiki/Linked_list#Singly.2C_doubly.2C_and_multiply_linked_lists) section of [Cracking the Coding Interview](http://www.amazon.com/gp/product/098478280X/ref=as_li_qf_sp_asin_il_tl?ie=UTF8&camp=1789&creative=9325&creativeASIN=098478280X&linkCode=as2&tag=aplfopoex-20) and I'm realizing that almost every time I get stumped with a problem the solution is the Runner Technique (or slow/fast pointers). The idea behind the runner technique is simple; use two pointers that either move at different speeds or are a set distance apart and iterate through a list. Why is this so useful? In many linked list problems you need to know the position of a certain element or the overall length of the list. Given that you don't always have the length of the list you are working on, the runner technique is an elegant way to solve these type of problems (and in some cases it's the only solution). Here are some examples of linked list problems where the runner technique provides an optimal solution: 

  * [Given two lists of different lengths that merge at a point, determine the merge point](http://stackoverflow.com/questions/1594061/linked-list-interview-question?rq=1)
  * [Determine if a linked list contains a loop](http://www.mytechinterviews.com/loop-in-a-singly-linked-list)
  * [Determine if a linked list is a palindrome](http://dev-faqs.blogspot.com.au/2012/04/check-if-linked-list-is-palindrome.html)
  * [Determine the kth element of a linked list](http://stackoverflow.com/questions/2598348/how-to-find-nth-element-from-the-end-of-a-singly-linked-list)
Where do you use it? If you get handed a linked list question, and you find yourself asking these questions: 
  * How do I figure out where these two things meet?
  * How do I figure out the midpoint?
  * How do I figure out the length?
You're most likely dealing with a problem where you need to use the runner technique. How does it work? I'll illustrate one of the examples above. Given two lists of different lengths that merge at a point, determine the merge point![Terrible Branched Linked List Picture](http://img10.imageshack.us/img10/7690/37343904.jpg)

  1. Start a node at the beginning of each list on the left.
  2. Count how many nodes each pointer encounters. (The top list should be 5, the bottom list 4.)
  3. The difference between the two numbers is the difference in length of the two lists before the merge point (the difference is 1)
  4. Move your nodes to the beginning of each list, but the longer list should get a headstart equal to the amount of difference. (so the top list would start on its 2nd element, while the bottom list would start on its 1st).
  5. Move each node forward at the same speed until they meet. Where they meet is the collision point.
Each of the links above contains code and solutions to each of the problems. I hope this example and the ones above show the usefulness of this approach. There are also some examples located [here](https://github.com/duereg/js-algorithms/tree/master/lib/algorithms/chapter2) of various linked list algorithms problems and solutions written in JavaScript.