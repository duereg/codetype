```
title: Javascript Strings - Using Array Accessor '[]' to set characters
link: http://codetype.wordpress.com/2012/09/05/javascript-strings-using-array-accessor-to-set-characters/
author: mablair2
description:
post_id: 331
created: 2012/09/05 09:00:48
created_gmt: 2012/09/05 01:00:48
comment_status: open
post_name: javascript-strings-using-array-accessor-to-set-characters
status: publish
tags: post, development, software, web, html, JavaScript, CoffeeScript, EMCAScript, C#, .NET
layout: post
```

# Javascript Strings - Using Array Accessor '[]' to set characters

I've been learning quite a bit about JavaScript in writing algorithms from [Cracking the Coding Interview](http://www.amazon.com/gp/product/098478280X/ref=as_li_qf_sp_asin_il_tl?ie=UTF8&camp=1789&creative=9325&creativeASIN=098478280X&linkCode=as2&tag=aplfopoex-20). I learned something new about strings in JavaScript and how they can be accessed. From [MDN](https://developer.mozilla.org/en-US/docs/JavaScript/Reference/Global_Objects/String#Distinction_between_string_primitives_and_String_objects):

> Character access There are two ways to access an individual character in a string. The first is the charAt method:
``` js
 return 'cat'.charAt(1); // returns "a"
```

 The other way is to treat the string as an array-like object, where individual characters correspond to a numerical index:
``` js
 return 'cat'[1]; // returns "a"
```

 Array-like character access (the second way above) is not part of ECMAScript 3. It is a JavaScript and ECMAScript 5 feature. **For character access using bracket notation, attempting to delete or assign a value to these properties will not succeed. The properties involved are neither writable nor configurable.**

I highlighted the important part. I know that strings are [immutable in JavaScript](http://en.wikibooks.org/wiki/JavaScript/Optimization#String_concatenation), but why give me array access if you won't let me use it? So if you want to use the array accessor with a string, there is a way to do it, but it requires a bit of overhead.
``` js
var sentence = "this is a proper JavaScript string.";
sentence = sentence.split(""); //split into array
sentence[18] = 'j'; //changing values to lowercase
sentence[22] = 's';
sentence = sentence.join(""); //make the array a string again
```

