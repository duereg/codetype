```
title: Ember.Data Promise-Aware Properties (Cheaters Edition)
description: Ember.Data Promise-Aware Properties (Cheaters Edition)
created: 2014/07/11 09:51:27
post_name: ember-data-promise-aware-properties
status: publish
tags: post, development, software, coding, web, html, JavaScript, CoffeeScript, EMCAScript, Ember, Ember.js, Ember.data, ES6, promises, then, isFulfilled, properties, Models, models
layout: post
```

I have models like this:

### Models

```javascript
App.Child = DS.Model.extend({
  parent: DS.belongsTo('parent', {async: true})
});

App.Parent = DS.Model.extend({
  children: DS.hasMany('child', {async: true})
});

App.Nursery = DS.Model.extend({
  children: DS.hasMany('child')
});
```

Then a controller like this:

###Controller
```javascript
App.NurseryController = Ember.Controller.extend({

  uniqueParents = function() {
    return this.get('children').mapBy('parent').uniq();
  }.property('children'),

  somethingLikeReliesOnUniqueParents = function() {
   ....
  }.property('uniqueParents')
}
```

## The Problem

The property somethingLikeReliesOnUniqueParents was never getting unique values. I found two problems here:


  1. uniq() couldn't figure out uniqueness - much like the problems with [filter](/posts/20140429-ember-filterby-fun).
  2. The parents promises, once they resolved, weren't updating properties that relied on them.


The first problem I solved the same way I solved in the filter case - filter uniqueness by id, not by object.

The second problem I found a somewhat hacky workaround. All promises in the system have a `isFulfilled` flag. Setting the properties to observe that field allowed the properties to update.

## The Solution

My code ended up looking like this:

###Controller
```javascript
App.NurseryController = Ember.Controller.extend({

  uniqueParents = function() {
    return this.get('children').mapBy('parent').uniq(function(parent) { return parent.get('id'); });
  }.property('children'),

  somethingLikeReliesOnUniqueParents = function() {
   ....
  }.property('uniqueParents.@each.isFulfilled')
}
```

This solved the issue and still allowed the async behavior I was looking for.
