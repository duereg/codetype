```
title: A/B Testing and Random Selection
description: A/B Testing or Random Selection in the browser and on the server
created: 2013/12/11 11:46:19
post_name: a-b-testing-and-random-selection
status: publish
tags: post, development, software, coding, web, html, JavaScript, CoffeeScript, EMCAScript, Testing, Laboratory
layout: post
```

# A/B Testing and Random Selection

Are you looking for an A/B framework? Something you can use in the browser to toggle a user experience - do they see marketing promotion #1, or a picture of a cat?

Or are you interested in random selection - you want to send our 5000 emails of differing types, and see how users respond?

Either way, enter [laboratory](http://www.github.com/goodeggs/laboratory). A simple framework that allows random selection or A/B testing. With the added bonus of being usable anywhere you can load JavaScript.

An example for random selection:

``` coffeescript
laboratory = new Laboratory()

laboratory.addExperiment("FuzzyBunnies")
  .variant "variant0", 50,
    name: "Peter Rabbit"
    type: "Wooly"
  .variant "variant1", 50,
    subject: "Briar Rabbit"
    type: "Silky"

experiment = laboratory.run("FuzzyBunnies")
experiment.value # Either Peter or Briar Rabbit
```

In this example, the user would get either Peter or Briar. If you ran the experiment again you'd get another set of random values irregardless of the user.

To use the A/B features you need to provide laboratory with some kind of storage mechanism to store the selected options for the user. On the client side, we usually use a thin wrapper over localStore.

Your storage needs to implement two methods:

``` coffeescript
class Store
  # stores the experiment results (as the variant name selected) for this user
  addResult: (experimentName, variantName) -> {}

  # retrieves a variant result if the user has already seen this experiment
  get: (experimentName) -> {}
```

If you want to give the user the same experiment every time they come to your site simply pass in your storage to the laboratory when you declare it.

``` coffeescript
laboratory = new Laboratory(new Store())
```
