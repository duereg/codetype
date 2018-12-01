```
title: ElasticSearch Perf - Highlighter Edition
description: Examine sharding and highlighting strategy with ES
created: 2018/11/21 19:49:00
post_name: elasticsearch-perf-work
status: publish
tags: post, manager, readme, ElasticSearch, ES, sharding, indexes, indices, querying, fetching, indexing, performance, highlighting
layout: post
```

Wanted to share the results of the work we've been doing to improve performance and stabilize our ES cluster.

Short Version: Changing sharding and "highlighting" strategies when doing FreeText searches dramatically impacts performance.

Long Version: We've been load testing various aspects of search to pinpoint features we use that create large amounts of load on the system. Our initial research pointed at normal searches and freetext searches as being problematic.

One of the tests we ran examined "highlighting" in freetext search. "Highlighting" is the selection of relevant criteria when you search for words or phrases in a document.

The graph below is an illustration of some load testing we did around highlighting. The red squares represent, in order of appearance:

1. 5 shards, highlighting freetext results
2. 1 shard, highlighting freetext results
3. 5 shares, no highlighting, freetext results
4. 1 shard, no highlighting, freetext results

<img alt="Load Test: 5 shards vs 1 Shard, Highlighting on/off" src="/images/posts/es-highlighter-1.png" />

Our conclusions from these graphs:

1. 5 shards w/ highlighting takes a long time and a lot of resources
2. 1 shard w/o highlighting is fast and doesn't use many resources

In researching highlighting, we found there are different ways to highlight results. We were using the default highlighter - the "plain" highlighter. There are other highlighters - the "unified" highlighter, for some example - that along with some index changes, promised significant performance improvements.

In this graph, the dots on the left represent the performance of the "plain" highlighter, while the dots on the right represent the "unified" highlighter.

<img alt="Load Test: Plain vs Unified Highlighting" src="/images/posts/es-highlighter-2.png" />

It appears that a "unified" highlighter strategy is more performant than our original "plain" highlighter.

Late today, we launched a new experiment with three indices:

1. Control (5 Shards, "plain" highlighter)
2. Variant 1 (1 Shard, "plain" highlighter)
3. Variant 2 (1 Shard, "unified" highlighter)

Here is a graph of the overall performance of the experiment so far:

<img alt="ElasticSearch Performance graph" src="/images/posts/es-highlighter-3.png" />

Red line (top): Variant 1.
TP95: 1.7 seconds
A single sharded strategy with the "plain" highlighter is much slower, though it consumes less ES resources than the 5 shard strategy.

Orange line (middle): Control.
TP95: 600 ms
5 shards with the "plain" highlighter responds must faster than a single shard, but it consumes more ES resources to run than the 1 shard strategy.

Blue line (bottom): Variant 2.
TP95: 150 ms
A single shard, using the "unified" highlighter, is much more performant, and uses less system resources, than the other two variants.
