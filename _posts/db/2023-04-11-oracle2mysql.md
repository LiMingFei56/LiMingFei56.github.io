---
layout: post
title: Oracle to mysql
categories: db
tags: [db]
date: 2023-04-11
---

## Oracle to mysql

1. Oracle 表名和表别名不区分大小写, mysql区分; 字段名称都不区分大小写
2. ID改成自增, 去掉ORACLE序列语句, 不插入ID


### 递归

> 使用WITH语句, [MySQL | Recursive CTE (Common Table Expressions)](https://www.geeksforgeeks.org/mysql-recursive-cte-common-table-expressions/)


oracle:

        SELECT P.SID, P.PRJ_NAME
      FROM TB_SYS_PROJECT P
    CONNECT BY P.PARENT_SID = PRIOR P.SID
     START WITH EXISTS (SELECT 1
                   FROM TB_SYS_ROLE R
                   LEFT JOIN TB_SYS_USER_TO_ROLE UR
                     ON UR.ROLE_SID = R.SID
                  WHERE R.PROJECT_SID = P.SID
                    AND UR.USER_SID = #{userSid})

mysql:

    WITH RECURSIVE CTE AS
    (
    SELECT P.SID, P.PRJ_NAME FROM TB_SYS_PROJECT P LEFT JOIN TB_SYS_ROLE R ON P.SID = R.PROJECT_SID LEFT JOIN TB_SYS_USER_TO_ROLE UR ON R.SID = UR.ROLE_SID WHERE UR.USER_SID = #{userSid}
    UNION ALL
    SELECT P.SID, P.PRJ_NAME FROM TB_SYS_PROJECT P JOIN CTE ON P.PARENT_SID = CTE.SID
    )
    SELECT SID, PRJ_NAME FROM CTE;

### INSTR

    INSTR
    LOCATE
    INSTR4

DELIMITER //
 
  CREATE FUNCTION INSTR4 (p_str VARCHAR(8000), p_substr VARCHAR(255), 
     p_start INT, p_occurrence INT)
  RETURNS INT
  DETERMINISTIC
  BEGIN
    DECLARE v_found INT DEFAULT p_occurrence;
    DECLARE v_pos INT DEFAULT p_start;
 
    lbl:
    WHILE 1=1 
     DO
	-- Find the next occurrence
	SET v_pos = LOCATE(p_substr, p_str, v_pos);
 
	-- Nothing found
	IF v_pos IS NULL OR v_pos = 0 THEN
	  RETURN v_pos;
	END IF;
 
	-- The required occurrence found
	IF v_found = 1 THEN
	  LEAVE lbl;
	END IF;
 
	-- Prepare to find another one occurrence
	SET v_found = v_found - 1;
	SET v_pos = v_pos + 1;
    END WHILE;
 
    RETURN v_pos;
  END;
  //
 
  DELIMITER ;

## Reference
+ [oracle转mysql语句转换](https://www.jianshu.com/p/fc694c73c217)
+ [Oracle转Mysql ------ 关于Oracle序列(Sequence)的转化](https://blog.csdn.net/NewBie_xW/article/details/118548534?spm=1001.2014.3001.5502)
+ [Oracle to MySQL Migration](https://www.sqlines.com/oracle-to-mysql)
+ [Converting and optimizing queries from Oracle Database to Cloud SQL for MySQL](https://cloud.google.com/solutransparentions/converting-optimizing-queries-oracle-database-cloud-sql-mysql)
+ [INSTR Function - Oracle to MySQL Migration](https://www.sqlines.com/oracle-to-mysql/instr)
