```
title: Ember FilterBy Fun
description: Ember FilterBy Fun
created: 2014/04/29 12:45:20
post_name: ember-filterby-fun
status: publish
layout: post
```

# Ember FilterBy Fun

If you happen to be writing filterBy statements in Ember against an object, you will want to use this syntax:

```javascript
  skusForStyle: function(style) {
    return this.get('mergedSkus').filterBy('style.id', style.get('id'));
  }
```

Instead of this similar looking but exceptionally evil and non-functioning cousin:

```javascript
  skusForStyle: function(style) {
    return this.get('mergedSkus').filterBy('style', style);
  }
```
