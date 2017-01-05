```
title: Superagent/Request Memory Leaks
description: Superagent/Request Memory Leaks
created: 2016/10/17 11:18:16
post_name: superagent-request-memory-leaks
status: publish
tags: post, development, performance, node, request, superagent, memory, leak
layout: post
```

## Superagent/Request Memory Leaks

The last several weeks [Thomas Hunter](https://thomashunter.name/) and myself have spent some of our nights and weekends trying to track down memory leaks in an API we both work on.

We were seeing a distinct pattern, that when the API was put under a certain amount of load, that we would start slowly bleeding memory.

We've found three results:
  - [Superagent](https://github.com/visionmedia/superagent), when put under a certain threshold of load and then connections timeout, can leak memory.
    - The PR to fix this issue has been merged: https://github.com/visionmedia/superagent/pull/1084

  - [Request](https://github.com/request/request), when put under a certain threshold of load and then connections timeout, can leak memory.
    - The PR to fix this issue has been merged: https://github.com/request/request/pull/2420

  - Superagent, when not explicitly assigned a timeout parameter, can hold connections open and therefore leak memory
    - The fix for this is to call req.timeout(YOUR_TIMEOUT_VALUE) to resolve.

The fixes for these issues are all in the latest versions of the libraries
