## informix 添加自增字段"
source: `{{ page.path }}`

[Create autoserial column in informix](https://stackoverflow.com/questions/30605602/create-autoserial-column-in-informix)

    alter table my_table add id integer before some_field;

    create sequence myseq;
    update my_table set id = myseq.nextval;
    drop sequence myseq;

    alter table my_table modify (id serial not null);
