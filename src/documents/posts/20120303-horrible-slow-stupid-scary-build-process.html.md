```
title: Horrible, Slow, Stupid, Scary Build Process
link: http://codetype.wordpress.com/2012/03/03/horrible-slow-stupid-scary-build-process/
author: mablair2
description:
post_id: 210
created: 2012/03/03 11:58:14
created_gmt: 2012/03/03 03:58:14
comment_status: open
post_name: horrible-slow-stupid-scary-build-process
status: publish
tags: post, development, software, coding, web, build, deployment
layout: post
```

So we've rolled out a new build process at work. I've started working with a new company, and when I arrived, the build process for a new environment consisted of a 20 page manual somebody had written. The process of putting a build on an environment was slow, the manual had steps missing that everyone just 'knew', the process had multiple failure points, and was more or less a complete disaster. Every other release to PRODUCTION would have some release process error that would force devs to spend all night at work on release night, sometimes having to come in during the weekend as well.

Using the manual deploy to production, it took me four hours to deploy our code. I made a small mistake along the way, and it took two hours to recover.

With the latest release to production, we used the first iteration of a new release process. We automated the whole process, taking no more than three manual steps. While not the one step recommended in [The Joel Test](http://www.joelonsoftware.com/articles/fog0000000043.html), a noticeable improvement and an increase in productively and reliability.

From start to finish, the new process takes about a half hour. Much shorter than the manual process.

Why am I writing about this? Today we had a meeting about the new release process. Assigned to the next release to production was one of my co-workers, who has been with this company for a while. They made the following comment:

> "The old build process was horrible, slow, stupid and scary, but at least I knew it."

And was serious. I guess I don't have to wonder anymore why no one had fixed the build process earlier.
