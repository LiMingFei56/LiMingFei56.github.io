---
layout: post
title: "informix 添加自增字段"
categories: web
tags: [db]
date: 2020-05-05
excerpt: "informix 添加自增字段""
---

## informix 添加自增字段"
[Create autoserial column in informix](https://stackoverflow.com/questions/30605602/create-autoserial-column-in-informix)

    alter table my_table add id integer before some_field;

    create sequence myseq;
    update my_table set id = myseq.nextval;
    drop sequence myseq;

    alter table my_table modify (id serial not null);
