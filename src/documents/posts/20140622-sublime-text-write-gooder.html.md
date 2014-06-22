```
title: WriteGooder for Sublime Text
description: WriteGooder for Sublime Text
created: 2014/06/22 01:05:19
post_name: write-gooder-for-sublime-text
status: publish
tags: post, development, software, coding, web, html, JavaScript, CoffeeScript, EMCAScript, Ember, Ember.js, Ember.data, sublime, text, write-good, write-gooder
layout: post
```

Simple grammar checking for your documentation.

**Prerequisites:** [write-gooder](http://github.com/duereg/write-gooder) and [Sublime Package Control](http://wbond.net/sublime_packages/package_control/installation)

**Mac OS X:** Installing node with homebrew or macports is assumed. The path to write-gooder is hardcoded in this plugin as `/usr/local/share/npm/bin:/usr/local/bin:/opt/local/bin`. You can change the path to the executable in settings.

**Linux:** Make sure write-gooder is in your environment path.

**Windows:** Installing node with the Windows Installer from nodejs.org is assumed.

##Install write-gooder with npm

  npm install -g duereg/write-gooder

##Install WriteGooder with Package Control in Sublime Text

1. `command`-`shift`-`P` *or* `control`-`shift`-`P` in Linux/Windows*
2. type `install p`, select `Package Control: Install Package`
3. type `WriteGooder`, select `WriteGooder`

**Note:** Without Sublime Package Control, you could manually copy this project to your Packages directory as 'WriteGooder'.

##Run WriteGooder on an active Markdown file in Sublime Text

- `control`-`shift`-`W` *or Tools/Contextual menus or the Command Palette*
- `F4` jump to next error row/column
- `shift`-`F4` jump to previous error row-column
