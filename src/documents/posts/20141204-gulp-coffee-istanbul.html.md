```
title: Code coverage for CoffeeScript and JavaScript without pre-compiling
description: Code coverage for CoffeeScript and JavaScript using gulp and istanbul without pre-compiling
created: 2014/12/04 13:58:48
post_name: gulp-coffee-istanbul
status: publish
tags: post, development, software, coding, web, html, JavaScript, CoffeeScript, EMCAScript, testing, mocha, istanbul, coverage
layout: post
```

If you're not aware of your code coverage when building a serious application, you're not building a serious app.

So I love [istanbul](https://github.com/gotwarlost/istanbul) and [gulp-istanbul](https://github.com/SBoudrias/gulp-istanbul).

One problem - you have to compile your CoffeeScript, then point you tests at the compiled assets to get coverage metrics.

Not anymore. Introducing [gulp-coffee-istanbul](https://github.com/duereg/gulp-coffee-istanbul). This allows in place CoffeeScript test coverage.

Have tests in coffee? Great. Have tests in JS? Great too. Same with your dependencies - it'll take both, in place, and run coverage.

A quick and dirty example:

```coffee
istanbul = require('gulp-coffee-istanbul')
# We'll use mocha here, but any test framework will work
mocha = require('gulp-mocha')

jsFiles = ['config/**/*.js', 'controllers/**/*.js', 'models/**/*.js', 'app.js']
specFiles = ['spec/**/*.coffee']
coffeeFiles = ['src/**/*.coffee']

gulp.task 'test', ->
  gulp.src jsFiles.concat(coffeeFiles)
    .pipe istanbul({includeUntested: true}) # Covering files
    .pipe istanbul.hookRequire()
    .on 'finish', ->
      gulp.src specFiles
        .pipe mocha reporter: 'spec'
        .pipe istanbul.writeReports() # Creating the reports after tests run
```

Which will give you

![Output from gulp showing js and coffee coverage](/images/posts/coffee-istanbul.png)

Notice that both coffee and js files are shown in the output.

