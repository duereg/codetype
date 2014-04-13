```
title: Ember - Test Teardown Error
description: Ember - Test Teardown Error
created: 2014/04/10 11:33:39
post_name: ember-test-teardown-errors
status: publish
layout: post
```

# Ember - Test Teardown Error
## Cannot read property 'addObject' of null

If you see the following error in Ember.Data 1.0.0-beta.7:

```
Cannot read property 'addObject' of null
TypeError: Cannot read property 'addObject' of null
    at Ember.ArrayProxy.extend.addRecord
    at Ember.Object.extend.updateRecordArray
    at null.<anonymous>
```

I found this had to do with Test teardown. A monkey patch that solves the issue:

```javascript
DS.RecordArray.reopen({
  addRecord: function(record) {
    var thing = Ember.get(this, 'content');

    if(thing) {
      this._super(record);
    }
  }
});
```
