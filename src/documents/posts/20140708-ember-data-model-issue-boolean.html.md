```
title: Ember.Data Model Issues
description: Ember.Data Model Issues
created: 2014/07/11 09:50:03
post_name: ember-data-model-issues-booleans
status: publish
tags: post, development, software, coding, web, html, JavaScript, CoffeeScript, EMCAScript, Ember, Ember.js, Ember.data, ES6, boolean, bool, attr
layout: post
```
I was working with some older Ember.Data code, and I came across a model like this:

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

My question was this: was this the expected behavior? I can't find any documentation on setting boolean values directly on the model like this anywhere in the Ember.Data docs.

After asking around on [discuss.emberjs.com](http://discuss.emberjs.com/t/model-declaration-false-vs-ds-attr-boolean-defaultvalue-false/5860), I got an answer.

This behavior is by design. Fields designated with just a variable (e.g. isSelected) are local attributes. You can use them just like an other attribute.

The difference with fields declared this way is they won't dirty the model and they aren't sent across the wire on save or update.
