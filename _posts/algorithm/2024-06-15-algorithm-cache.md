---
layout: post
title: cache
categories: algorithm
tags: [algorithm]
date: 2024-06-15
---

## cache

1. LRUCache (Least Recently Used Cache)

    Eviction Policy: Evicts the least recently used items first when the cache reaches its maximum size.
    Usage: Useful when you want to keep the most recently accessed items in the cache.

2. RRCache (Random Replacement Cache)

    Eviction Policy: Randomly evicts cache entries when the cache reaches its maximum size.
    Usage: Useful when you want a simple cache with random eviction.

3. LFUCache (Least Frequently Used Cache)

    Eviction Policy: Evicts the least frequently used items first when the cache reaches its maximum size.
    Usage: Useful when you want to keep the most frequently accessed items in the cache.

4. TTLCache (Time-to-Live Cache)

    Eviction Policy: Evicts items that have exceeded their time-to-live (TTL) and may also use an LRU policy if the cache is full.
    Usage: Useful when cached data should expire after a certain period.

5. Cache (Simple Cache)

    Eviction Policy: No eviction policy. It has a fixed size and does not automatically remove items.
    Usage: Useful for fixed-size caches without any specific eviction logic.



## Reference
