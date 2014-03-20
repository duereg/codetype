```
title: Ember vs Knockout - Property Comparison
description: Ember vs Knockout - Property Comparison
created: 2014/03/20 08:54:43
post_name: ember-vs-knockout-property-comparison
status: draft
layout: post
```

# Ember vs Knockout
## A small, appropriate comparison

### Getting Computed Properties

#### Ember

```javascript
  firstName: null,
  lastName: null,

  fullName: function() {
    return this.get('firstName') + ' ' + this.get('lastName');
  }.property('firstName', 'lastName')
```

#### Knockout

```javascript
  this.firstName = ko.observable('Bob');
  this.lastName = ko.observable('Smith');

  this.fullName = ko.computed(function() {
    return this.firstName() + ' ' + this.lastName();
  }, this);
```

### Setting Computed Properties

#### Ember

```javascript
  firstName: null,
  lastName: null,

  fullName: function(key, value) {
    // setter
    if (arguments.length > 1) {
      var nameParts = value.split(/\s+/);
      this.set('firstName', nameParts[0]);
      this.set('lastName',  nameParts[1]);
    }

    // getter
    return this.get('firstName') + ' ' + this.get('lastName');
  }.property('firstName', 'lastName')
```

#### Knockout

```javascript
  this.firstName = ko.observable('Planet');
  this.lastName = ko.observable('Earth');

  this.fullName = ko.computed({
      read: function () {
          return this.firstName() + " " + this.lastName();
      },
      write: function (value) {
          var lastSpacePos = value.lastIndexOf(" ");
          if (lastSpacePos > 0) { // Ignore values with no space character
              this.firstName(value.substring(0, lastSpacePos)); // Update "firstName"
              this.lastName(value.substring(lastSpacePos + 1)); // Update "lastName"
          }
      },
      owner: this
  });
```

### Forcing a Property to Recompute Every Time its Called

#### Knockout

```javascript
  myViewModel.fullName = ko.computed(function() {
      return myViewModel.firstName() + " " + myViewModel.lastName();
  }).extend({ notify: 'always' });
```

#### Ember

```javascript
  fullName: function() {
    return this.get('firstName') + ' ' + this.get('lastName');
  }.property('firstName', 'lastName').volatile()
```

### Knockout's Algorithm for Dependency Tracking

>
>  It’s actually very simple and rather lovely. The tracking algorithm goes like this:
>
>  1. Whenever you declare a computed observable, KO immediately invokes its evaluator function to get its initial value.
>  2. While your evaluator function is running, KO keeps a log of any observables (or computed observables) that your  evaluator reads the value of.
>  3. When your evaluator is finished, KO sets up subscriptions to each of the observables (or computed observables) that   you’ve touched. The subscription callback is set to cause your evaluator to run again, looping the whole process back to step 1 (disposing of any old subscriptions that no longer apply).
>  4. KO notifies any subscribers about the new value of your computed observable.
