```
title: Cracking the Coding Interview - JavaScript Min/Max Binary Heap
link: http://codetype.wordpress.com/2012/08/29/cracking-the-coding-interview-javascript-minmax-binary-heap/
author: mablair2
description: 
post_id: 307
created: 2012/08/29 12:30:00
created_gmt: 2012/08/29 04:30:00
comment_status: open
post_name: cracking-the-coding-interview-javascript-minmax-binary-heap
status: publish
layout: post
```

# Cracking the Coding Interview - JavaScript Min/Max Binary Heap

I finished my second algorithm from [Cracking the Coding Interview](http://www.amazon.com/gp/product/098478280X/ref=as_li_qf_sp_asin_il_tl?ie=UTF8&camp=1789&creative=9325&creativeASIN=098478280X&linkCode=as2&tag=aplfopoex-20) - the [Binary Heap](http://en.wikipedia.org/wiki/Binary_heap). This algorithm racketed up the complexity from the [Linked List](http://codetype.wordpress.com/2012/08/24/cracking-the-coding-interview-javascript-singly-linked-list/). The heap's structure is easy to understand - it's a binary tree (a tree where each node can have at most two children). In the case of a max heap, the parents have a greater value than their children. So the values in a Max Heap decrease as you move down the tree from the parent to children. 

(This image is from Wikipedia) 
![Max Tree Example](http://upload.wikimedia.org/wikipedia/commons/thumb/b/bf/Max-heap.png/240px-Max-heap.png) 

The complexity comes from the behaviour. Though the algorithms are easy to understand, there is enough going on in each one that it's easy to sneak in bugs. It took me a bit of time to get each of my implementations the way I wanted it. The insert operation is the easiest to implement. The algorithm is also straight forward. 

  1. Add the element to the bottom of the heap.
  2. Compare the added element with its parent; if they are in the correct order, stop.
  3. If not, swap the element with its parent and return to the previous step.

Here is part of my implementation of insert: 
``` js
binaryHeap.prototype.add = function(data) {
    if (data === undefined) { throw "data must be valid to add"; }
 
    this.array.push(data);
    this.bubbleUp(this.array.length - 1, data);
};
 
binaryHeap.prototype.bubbleUp = function(childIndex, childData) {
    if(childIndex > 0) {
        var parentIndex = this.getParentIndex(childIndex);
        var parentData = this.array[parentIndex];
 
        if (this.shouldSwap(childData, parentData)) {
            this.array[parentIndex] = childData;
            this.array[childIndex] = parentData;
            this.bubbleUp(parentIndex, childData);
        }
    }
};
 
binaryHeap.prototype.getParentIndex = function (childIndex) {
    return Math.floor((childIndex - 1) / 2);
};
```

 Delete is a quite bit more complicated, though the algorithm reads about the same. To delete the top of a heap: 
  1. Replace the root of the heap with the last element on the last level.
  2. Compare the new root with its children; if they are in the correct order, stop.
  3. If not, swap the element with one of its children and return to the previous step. 
    * Swap with its smaller child in a min-heap and its larger child in a max-heap.

``` js
binaryHeap.prototype.removeHead = function() {
    var headNode = this.array[0];
    var tailNode = this.array.pop();
 
    this.array[0] = tailNode;
    this.bubbleDown(0, tailNode);
 
    return headNode;
};
 
binaryHeap.prototype.bubbleDown = function(parentIndex, parentData) {
    if(parentIndex < this.array.length) {
        var targetIndex = parentIndex;
        var targetData = parentData;
 
        var leftChildIndex = this.getLeftChild(parentIndex);
        var rightChildIndex = this.getRightChild(parentIndex);
 
        if(leftChildIndex < this.array.length) {
            var leftChildData = this.array[leftChildIndex];
 
            if (this.shouldSwap( leftChildData, targetData )) {
                targetIndex = leftChildIndex;
                targetData = leftChildData;
            }
        }
         
        if(rightChildIndex < this.array.length) {
            var rightChildData = this.array[rightChildIndex];
 
            if(this.shouldSwap(rightChildData, targetData )) {
                targetIndex = rightChildIndex;
                targetData = rightChildData;
            }
        }
 
        if(targetIndex !== parentIndex) {
            this.array[parentIndex] = targetData;
            this.array[targetIndex] = parentData;
            this.bubbleDown(targetIndex, parentData);
        }
    }
};
 
binaryHeap.prototype.getLeftChild = function (parentIndex) {
    return parentIndex * 2 + 1;
};
 
binaryHeap.prototype.getRightChild = function (parentIndex){
    return parentIndex * 2 + 2;
};
```

 It's quite a bit more code to delete the top element and reshuffle the list into the correct order. With all the extra comparisons there are quite a few places that bugs can sneak into the code. The source code for the project and the tests are [here](https://github.com/duereg/js-algorithms).