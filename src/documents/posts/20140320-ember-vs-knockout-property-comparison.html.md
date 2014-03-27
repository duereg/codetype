```
title: Ember vs Knockout - Property Comparison
description: Ember vs Knockout - Property Comparison
created: 2014/03/20 08:54:43
post_name: ember-vs-knockout-property-comparison
status: publish
layout: post
```

# Ember and Knockout Model Comparison
## A small, appropriate comparison

At [ModCloth](http://modcloth.com), I've been working on an internal application that uses [Ember.js](http://emberjs.com/) as its front end framework. In going through a crash course on Ember I've noticed certain architectural decisions they've made in building their Observable Models in comparison to other frameworks - most specifically, to [Knockout](http://knockoutjs.com/).

TANGENT

[Ember.js](http://emberjs.com/) and [Knockout](http://knockoutjs.com/) are great contrasts in the library vs framework debate in JS development.

Ember is a
> A __framework__ for creating ambitious web applications.

(emphasis is mine).

Knockout is __library__ whose goal is to
> Simplify dynamic JavaScript UIs with the Model-View-View Model (MVVM) pattern.

Ember is [outspoken and proud of its framework status](https://www.youtube.com/watch?v=jScLjUlLTLI). Knockout makes it very clear that is a small library that is just a tool to build _dynamic JavaScript UIs_.

Ember, while a year younger than Knockout, has SIX TIMES as many commits as Knockout. It's also 4 times the size (71kb vs 17kb, once minified and gzipped).

/TANGENT

In the end, Knockout covers a small subset of the same functionality of Ember. I'm going to focus on one particular aspect of their overlapping functionality - how they deal with Observable Models.

### Read-only computed properties

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

The differences here are trivial. Ember doesn't need you to tell it what properties to observe (it observes are properties you initially add to your models). Then Ember uses getters and setters for each property.

Knockout wants you to explicitly state what properties you want to observe. Knockout then uses the named observable function instead of getters and setter.

### Read/write computed properties

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

I think this scenario shows where Knockout really shine. I find the Knockout code easily readable. The fact that the Ember code needs comments to explain what part of the code is the setter vs getter is damning.

Also, the fact that the Ember code has to explicitly call out what properties it is watching is frustrating as well.

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

I think Ember gets the node here for the chainable extension method. Knockout's choice of passing in a extended configuration, while readable, seems a bit clunky to me.

## Conclusion

The biggest difference I see in the two frameworks in regards to Observable Models is the need of Ember to register property dependencies. This seems like a huge drawback to me - what if you change your code and forget to update the dependencies? Or what if you have a typo in writing in the dependencies?

Since Knockout is slightly older than Ember, it makes me wonder why the Ember creators didn't simply take Knockout as a component and incorporate it into their framework. Solving the same problem again after someone has already spent a lot of time solving the problem reminds me of this famous XKCD cartoon:

![Competing Standards](http://imgs.xkcd.com/comics/standards.png)

##Side Note - How does Knockout get away without explicitly defining dependencies?

### Knockout's Algorithm for Dependency Tracking

It’s actually very simple and rather lovely. The tracking algorithm goes like this:

>  1. Whenever you declare a computed observable, KO immediately invokes its evaluator function to get its initial value.
>  2. While your evaluator function is running, KO keeps a log of any observables (or computed observables) that your  evaluator reads the value of.
>  3. When your evaluator is finished, KO sets up subscriptions to each of the observables (or computed observables) that   you’ve touched. The subscription callback is set to cause your evaluator to run again, looping the whole process back to step 1 (disposing of any old subscriptions that no longer apply).
>  4. KO notifies any subscribers about the new value of your computed observable.
