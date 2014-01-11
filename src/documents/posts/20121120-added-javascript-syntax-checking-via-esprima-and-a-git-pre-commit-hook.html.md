```
title: Added JavaScript syntax checking via Esprima and a Git pre-commit hook
link: http://codetype.wordpress.com/2012/11/20/added-javascript-syntax-checking-via-esprima-and-a-git-pre-commit-hook/
author: mablair2
description: 
post_id: 487
created: 2012/11/20 12:36:45
created_gmt: 2012/11/20 04:36:45
comment_status: open
post_name: added-javascript-syntax-checking-via-esprima-and-a-git-pre-commit-hook
status: publish
layout: post
```

# Added JavaScript syntax checking via Esprima and a Git pre-commit hook

I came across a brilliant project the other day - [Esprima](http://esprima.org/) from [Ariya Hidayat](https://plus.google.com/103266860731871773002/posts), the author of PhantomJS. What is Esprima? Esprima is a JavaScript Parser written in JavaScript Syntax Validator. It forms the basis of several different tools - a minifier, a code coverage tool, a syntax validator - just to name a few. I was immediately interested in the syntax validation tool. It's not a linter - it just checks that the JavaScript written is syntactically correct. Why would you want this if you already have JsHint and JsLint? 

  1. It is extremely fast. Validating three.js (800 KB source) takes less than a second on a modern machine.
  2. It looks only for syntax errors, it does not care about coding style at all. 
  3. It handles generated files as the result of minification or compilation (CoffeeScript, Dart, TypeScript, etc). 
  4. It tries to be tolerant and not give up immediately on the first error, especially for strict mode violations. 
Esprima is available as an npm package, so installing it only takes a second: `sudo npm install -g esprima` Using Esprima from the command line is simple: `esvalidate file.js` The only thing to note about running from the command line: if the validation succeeds, you won't get much in the way of confirmation. Which can be painful if you are processing a whole directory. You only get useful feedback in the default mode on error. However, if you don't mind reading a little XML: `esvalidate lib/*.js --format=junit` Prints junit XML which at least you can visually parse to see which files were validated. Where would I use this where I might not use JsHint? As a pre-commit hook to screen my checkins. Instead of going through a check-in, building everything, then running JSHint just to hear that something is not up to spec, I can add a little script that will do a quick sanity check of my JS before I go to commit anything to git. If you've never created a pre-commit hook before, it's pretty easy. Two lines in bash will give you a pre-commit file: `touch .git/hooks/pre-commit chmod +x .git/hooks/pre-commit` This is windows version of the code for the pre-commit hook: ` #!/bin/sh files=$(git diff-index --name-only HEAD | grep -l '\\.js$') for file in $files; do esvalidate $file if [ $? -eq 1 ]; then echo "Syntax error: $file" exit 1 fi done ` To make this work on Linux, just remove the remove the #!/bin/sh line. For more information about Esprima, check out [this article](http://ariya.ofilabs.com/2012/10/javascript-validator-with-esprima.html) by the author.