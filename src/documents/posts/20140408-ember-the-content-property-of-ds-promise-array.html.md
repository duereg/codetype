```
title: Ember - The content property of DS.PromiseArray should be set before modifying it
description: Ember - The content property of DS.PromiseArray should be set before modifying it
created: 2014/04/08 10:38:15
post_name: ember-the-content-property-of-ds-promise-array
status: publish
layout: post
```

If you see the following error in Ember.Data 1.0.0-beta.7:

**The content property of DS.PromiseArray should be set before modifying it**

The issue is with a field that has been declared async:

```javascript
//program.js
Program = DS.Model.extend({
  styles: DS.hasMany('style', {async: true}),
});

Style = DS.Model.extend({});
```

and then used like so:

```javascript
program.get('styles').pushObject(style);
```

That code will throw the exception listed above. To work around this behavior, do the following:

```javascript
program.get('styles').then(function(styles){
  styles.pushObject(style);
});
```

A gist talking about the issue is [here](https://gist.github.com/Microfed/6573839).