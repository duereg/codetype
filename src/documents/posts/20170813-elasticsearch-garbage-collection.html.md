```
title: ElasticSearch Garbage Collection issues?
description: Seeing high garbage collection with ElasticSearch?
created: 2017/08/13 14:15:16
post_name: elasticsearch-garbage-collection
status: publish
tags: post, engineering, ElasticSearch, ES, garbage collection
layout: post
```

Seeing high garbage collection with ElasticSearch? My team was seeing periodic 300ms+ garbage collection pauses.
We found out that we had misconfigured our ES instances.

If you're encountering this, make sure you've disabled memory swapping:

https://www.elastic.co/guide/en/elasticsearch/reference/5.0/setup-configuration-memory.html
