```
title: Derby.js - Working with Views, Models, and Bindings
link: http://codetype.wordpress.com/2012/08/07/derby-js-working-with-view-templates-models-and-bindings/
author: mablair2
description:
post_id: 174
created: 2012/08/07 15:18:54
created_gmt: 2012/08/07 07:18:54
comment_status: open
post_name: derby-js-working-with-view-templates-models-and-bindings
status: publish
tags: post, development, software, coding, web, html, JavaScript, CoffeeScript, EMCAScript, derby, node, express, views, models, bindings, data-binding
layout: post
```

# Derby.js - Working with Views, Models, and Bindings

In my previous [post](/posts/20120722-derby-js-playing-with-models) about [derby](http://derbyjs.com/), I talked a bit about how to create a model in derby and one rule you need to follow when creating models (the first two path segments should be an object).

I'm creating a test application to help me learn derby [here](http://github.com/duereg/Potluck). In the process of doing absolutely everything wrong to start I've learned a bit about how Derby binds to models. Let's say you're got some markup like this that you'd like to bind to.

``` html
<div>
  <div> <input type="text" id="firstName" /> </div>
  <div> <input type="text" id="lastName" /> </div>
  <div> <input type="tel"  id="phoneNumber" /> </div>
  <div> <input type="date" id="birthDate" /> </div>
</div>
```

 Nothing sexy but you get the idea. You can post this information into a view and everything will show up the way you'd expect it to. If you want to bind this to a model, such as `myApp.stuff.newGuy`, changing the code is straight forward.
``` html
<div>
  <div> <input type="text" id="firstName"
               value="{myApp.stuff.newGuy.firstName}" /> </div>
  <div> <input type="text" id="lastName"
               value="{myApp.stuff.newGuy.lastName}" /> </div>
  <div> <input type="tel"  id="phoneNumber"
               value="{myApp.stuff.newGuy.phoneNumber}" /> </div>
  <div> <input type="date" id="birthDate"
               value="{myApp.stuff.newGuy.birthDate}" /> </div>
</div>
```

 Note that you don't have to write any js code in your /lib/ folder to create this model. The binding [the {} information in the value attribute] will automatically wire up these fields to the `myApp.stuff.newGuy` model. If you want to add some default values to these fields you could accomplish this like so:

``` js
get('/', function(page, model, params) {

  //set some default values for my model
  model.set('myApp.stuff.newGuy', { firstName: 'John', lastName: 'Smith' });

  //render my template containing the model above
  page.render();
});
```

 When you browsed to the page you would see John in the firstName input and Smith in the lastName input. How would you render a similar collection of models? There are a couple of ways. To iterate through a collection of objects, you'll most likely want to use the `#each` binding.

``` html
{#each myApp.stuff.people}
<div>
  <div> <input type="text" value="{.firstName}" /> </div>
  <div> <input type="text" value="{.lastName}" /> </div>
  <div> <input type="tel"  value="{.phoneNumber}" /> </div>
  <div> <input type="date" value="{.birthDate}" /> </div>
</div>
{/}
```

 Several things to note here.

 First, you have to remove the id's from the html inputs you are binding to. Each input needs to have a unique id. If you omit the id field from the markup, derby will generate a unique id for you. Otherwise you'll be repeating the same id over and over again (and get strange behaviour as a result).

 Second, in an `#each` binding you don't use the full path to the model field you want to bind to (e.g. `{myApp.stuff.people.firstName}`), just the field with a dot prepended. (e.g. `{.firstName}`). Note that the dot is very important. If you just put `{firstName}` as your binding, because of the automatic model creation we noticed above, you will bind to a model called `{firstName}` for every item in the `myApp.stuff.people` collection. This will show itself by the very annoying behavior of every edit being mirrored in every row (since every row is binding to the same model).

 Another way to do binding with #each is by using an alias. The documentation of creating an alias:

> Aliases to a specific scope may be defined, enabling relative model path references within nested sections. Aliases begin with a colon (:), and can be defined at the end of a section tag with the as keyword.

What would this look like?
``` html
{#each myApp.stuff.people as :person}
<div>
  <div> <input type="text" value="{:person.firstName}" /> </div>
  <div> <input type="text" value="{:person.lastName}" /> </div>
  <div> <input type="tel"  value="{:person.phoneNumber}" /> </div>
  <div> <input type="date" value="{:person.birthDate}" /> </div>
</div>
{/}
```

 Note that when you declare your alias with your each statement (as :person) you have to keep the colon for your subsequent bindings ({:person.firstName})
