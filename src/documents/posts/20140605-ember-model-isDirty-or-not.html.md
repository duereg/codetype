```
title: Ember Model.isDirty - or not
description: Ember Model.isDirty - or not
created: 2014/06/05 12:41:45
post_name: ember-model-isDirty-or-not
status: publish
tags: post, development, software, coding, web, html, JavaScript, CoffeeScript, EMCAScript, Ember, Ember.js, Ember.data
layout: post
```

In Ember, if you have models like this:

```javascript
  var Tag = DS.Model.extend({
    name: DS.attr('string'),
    person: DS.belongsTo('person')
  });

  var Person = DS.Model.extend({
    name: DS.attr('string'),
    tags: DS.hasMany('tag')
  });
```

Then did something like this:

```javascript
var tag1 = this.store.find('tag', 1);

tag1.get('isDirty'); //returns false
tag1.get('name'); //return null
tag1.set('name', 'foo');
tag1.get('isDirty'); //returns true
```

That would be the obvious outcome, right?

However, if you do this:

```javascript
var tag1 = this.store.find('tag', 1);
var thatGuy = this.store.find('person', 1);

tag1.get('isDirty'); //returns false
tag.get('person'); //returns null
tag1.set('person', thatGuy); //set person on tag
tag1.get('isDirty'); //returns false
```

Because Ember does not check relationships when figuring out isDirty.

[Here is the issue on github](https://github.com/emberjs/data/issues/1188)

[Here is a solution proposed by someone else (that I do not think solves the problem)](http://emberjs.jsbin.com/jaxoriki/1/edit)
