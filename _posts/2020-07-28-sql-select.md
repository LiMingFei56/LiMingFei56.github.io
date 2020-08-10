---
layout: post
title: "Sql 查询"
categories: sql
tags: [sql]
date: 2020-07-28
excerpt: "Sql 查询"
---

## Sql 查询

### group by 取最新的一条

1. 先order by 再 groub by (order by 需要使用limit, 不然无效)
select * from (select * from ab as a order by time desc limit 10000) as b group by time;

2. 使用max()
select * from ab as a, (select max(time) as time from ac group by time) as b, where a.time = b.time

### 联合多个查询结果

UNION 和 UNION ALL

UNION 会去重复 和 排序, 所以UNION ALL性能比UNION好

### Reference

