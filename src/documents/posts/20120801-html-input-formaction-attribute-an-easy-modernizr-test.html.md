```
title: HTML5 'formaction' attribute - An easy Modernizr test
link: http://codetype.wordpress.com/2012/08/01/html-input-formaction-attribute-an-easy-modernizr-test/
author: mablair2
description: 
post_id: 168
created: 2012/08/01 15:58:59
created_gmt: 2012/08/01 07:58:59
comment_status: open
post_name: html-input-formaction-attribute-an-easy-modernizr-test
status: publish
layout: post
```

# HTML5 'formaction' attribute - An easy Modernizr test

> EDIT NOTE: This no longer needs to be done outside of Modernizr. This was added to the Modernizr package about a month ago. [Link to issue](https://github.com/Modernizr/Modernizr/issues/1067)

I've been writing some Html Forms, and in playing with submit buttons came across an interesting attribute in the HTML 5 specs: formaction. The definition, from [HTML Living Standard Doc](http://www.whatwg.org/specs/web-apps/current-work/multipage/association-of-controls-and-forms.html#attr-fs-formaction)

> The action and formaction content attributes, if specified, must have a value that is a valid non-empty URL potentially surrounded by spaces. The action of an element is the value of the element's formaction attribute, if the element is a submit button and has such an attribute, or the value of its form owner's action attribute, if it has one, or else the empty string. 

What does that mean? It means you can have a form on your page, and supply the `formaction` attribute to various `` buttons, and each button will post the same form to a different URL! Pretty neat, and has global acceptance in all browsers but one; Internet Explorer. Whoops. I really want to use this functionality, so I'll come up with a shim to replace the functionality that IE is missing. For now, the only part of this problem I've solved is how to detect whether or not your browser supports this feature, via [Modernizr](http://modernizr.com) 

``` js
// input[formaction] attribute 
// When used on an <input type='submit'>, 
// this attribute signifies that the form containing 
// the input should post to the URL contained in the attribute 
// rather than the URL defined in the form's 'action' attribute. 
// By Matt Blair - 
Modernizr.addTest('inputformaction', 'formAction' in document.createElement('input')); 
```