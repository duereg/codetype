```
title: Ember.Data Model Issues
description: Ember.Data Model Issues
created: 2014/07/08 17:34:50
post_name: ember-data-model-issues-booleans
status: draft
tags: post, development, software, coding, web, html, JavaScript, CoffeeScript, EMCAScript, Ember, Ember.js, Ember.data, ES6, boolean, bool, attr
layout: post
```
I am working with some older Ember.Data code, and I came across a model like this:

```javascript
App.MyFancyModel = DS.Model.extend({
  isSelected: false,
  isSomethingElse: DS.attr('boolean', {defaultValue: false})
});
```

I thought this code was a bit strange, and then went and played with it a bit:

```javascript
aFancyModel.get('isSelected'); //returns false
aFancyModel.set('isSelected', true);
aFancyModel.get('isSelected'); //returns true
aFancyModel.get('isSomethingElse'); //returns false
aFancyModel.set('isSomethingElse', true);
aFancyModel.get('isSomethingElse'); //returns true
```

I got identical behavior from the two properties. Then, I tried this:

```javascript
aFancyModel.set('isSelected', true);
aFancyModel.get('isDirty'); //RETURNS FALSE
aFancyModel.set('isSomethingElse', true);
aFancyModel.get('isDirty'); //RETURNS TRUE!!!
```

So I guess my question is this: is this the expected behavior? I can't find any documentation on setting boolean values directly on the model like this anywhere in the Ember.Data docs.
