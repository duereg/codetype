```
title: Cracking the Coding Interview - JavaScript Trie
link: http://codetype.wordpress.com/2012/09/01/cracking-the-coding-interview-javascript-trie/
author: mablair2
description:
post_id: 318
created: 2012/09/01 01:01:40
created_gmt: 2012/08/31 17:01:40
comment_status: open
post_name: cracking-the-coding-interview-javascript-trie
status: publish
layout: post
```

# Cracking the Coding Interview - JavaScript Trie

I finished my third algorithm from [Cracking the Coding Interview](http://www.amazon.com/gp/product/098478280X/ref=as_li_qf_sp_asin_il_tl?ie=UTF8&camp=1789&creative=9325&creativeASIN=098478280X&linkCode=as2&tag=aplfopoex-20) - the [Trie](http://en.wikipedia.org/wiki/Trie). Tries are an extremely useful algorithm, if not all that well known. They can be used for very efficient spell checking, auto suggestion, as well as the sorting of a collection of strings. This algorithm was more complex to implement than the [Linked List](/posts/20120824-cracking-the-coding-interview-javascript-singly-linked-list), but a little simpler than the [Max/Min Binary Heap](/posts/20120829-cracking-the-coding-interview-javascript-minmax-binary-heap) to implement. The trie's structure is easy to understand - it's a word tree, where each leaf of the tree is a letter of a word. Where words share common prefixes (such as **fre**sh and **fre**edom), those words share a common "branch" of prefix letters, and split where the words differ.

(This image is from Wikipedia)
![Trie Tree Example](http://upload.wikimedia.org/wikipedia/commons/thumb/b/be/Trie_example.svg/250px-Trie_example.svg.png)

The `insert` and `hasWord` operations are easy to implement. However, removal of words can be complicated due to shared nature of the word prefixes.

Insert goes something like this: For each letter in the word:

  1. if the letter exists on the tree, go to the letter. If it does not exist, create it.
  2. If there is another letter, return to the previous step. If not, add a word terminating marker.

Here is my implementation of insert:
``` js
var trie = function() {
    this.head = {};
};

trie.prototype.validate = function(word) {
    if((word === undefined) || (word === null)) throw "The given word is invalid.";
    if (typeof word !== "string") throw "The given word is not a string";
}

trie.prototype.add = function(word) {
    this.validate(word);

    var current = this.head;

    for (var i = 0; i < word.length; i++) {
        if(!(word[i] in current)) {
            current[word[i]] = {};
        }

        current = current[word[i]]
    };

    current.$ = 1;  //word end marker
};
```

 The hasWord algorithm is very similar to the insert algorithm. For each letter in the word:
  1. if the letter exists on the tree, go to the letter. If it does not exist, the word does not exist.
  2. If there is another letter, return to the previous step. If not, check for the word terminating marker.

``` js
trie.prototype.hasWord = function(word) {
    this.validate(word);

    var current = this.head;

    for (var i = 0; i < word.length; i++) {
        if(!(word[i] in current)) {
            return false;
        }

        current = current[word[i]]
    };

    return current.$ === 1; //word end marker
};
```

 Delete isn't much more complicated, though the recursive nature of the algorithm does make it a bit of a pain. You have to go to the end of the word, and if no other letters are hanging off your word, delete from the end towards the head. As soon as you find an element that is being shared, you stop the deletion.

``` js
trie.prototype.remove = function(word) {
    this.validate(word);

    canDelete(word, -1, this.head);

    function canDelete(word, index, node){
        if(word === undefined ) throw "Bad Word";
        if(index >= word.length) throw "Bad index to check for deletion.";
        if(node === undefined ) throw "Bad Node at " + index + " for " + word;

        if(index === word.length - 1) {
            //last letter
            //always delete word marker (as we are deleting word)
            return (delete node.$) && noKids(node); //if last letter of word, should be empty.
        }
        else {
            //any other letter in word
            //check child, and after child check, I am now empty
            if(canDelete(word, index + 1, node[word[index + 1]]) )
            {
                //delete me
                return (delete node[word[index + 1]]) && noKids(node);
            }
        }
        return false;
    };

    function noKids(node) {
        return Object.keys(node).length === 0;
    };
};
```

 My favorite advantage of using a trie is the ease in which a sorted list of words can be generated. All you have to do is output all the letters by [Pre-Order Traversal](http://en.wikipedia.org/wiki/Pre-order_traversal). And sorting using a trie is fast - the worst case sorting is O(kn), where k is the length of the longest word in the trie.

``` js
trie.prototype.sort = function() {
    var word = "";
    var sorted = [];

    sortTrie(this.head, word, sorted);

    function sortTrie(node, word, sorted) {
        for(var letter in node) {
            if (letter == '$') { sorted.push(word); }
            else {
                sortTrie(node[letter], word + letter, sorted);
            }
        }
    }

    console.log(sorted);
    return sorted;
};
```

The source code for the project and the tests is [here](https://github.com/duereg/js-algorithms).