---
title: MySQL分组TopN查询
tags:
  - MySQL
  - 数据库
comments: true
categories: MySQL
abbrlink: 12049
date: 2020-01-06 22:31:13
---
在MySQL8.0中新增了窗口函数的新特性，可以很容易的就实现分组的TopN的查询问题，但是在更低的版本中，需要使用稍微复杂一点的查询语句才能实现同样的效果。

<!-- more -->

### 准备工作

数据库版本

``` mysql
SELECT
	VERSION();
+-----------+
| VERSION() |
+-----------+
| 5.7.22    |
+-----------+
```

表结构，创建一个学生成绩表，包含学生姓名，学科名和学科分数。

``` mysql
CREATE TABLE `test` (
	`id` INT (11) NOT NULL AUTO_INCREMENT,
	`name` VARCHAR (20) DEFAULT NULL,
	`course` VARCHAR (20) DEFAULT NULL,
	`score` INT (11) DEFAULT NULL,
	PRIMARY KEY (`id`)
);
```

插入数据

``` mysql
INSERT INTO test (name, course, score)
VALUES
	('张三', '语文', 80),
	('李四', '语文', 90),
	('王五', '语文', 93),
	('张三', '数学', 77),
	('李四', '数学', 68),
	('王五', '数学', 99),
	('张三', '英语', 90),
	('李四', '英语', 50),
	('王五', '英语', 89);
```
数据内容

``` mysql
SELECT
	*
FROM
	test;

+----+--------+--------+-------+
| id | name   | course | score |
+----+--------+--------+-------+
|  1 | 张三   | 语文   |    80 |
|  2 | 李四   | 语文   |    90 |
|  3 | 王五   | 语文   |    93 |
|  4 | 张三   | 数学   |    77 |
|  5 | 李四   | 数学   |    68 |
|  6 | 王五   | 数学   |    99 |
|  7 | 张三   | 英语   |    90 |
|  8 | 李四   | 英语   |    50 |
|  9 | 王五   | 英语   |    89 |
+----+--------+--------+-------+
```

### Top1

查询分组内的最大值（最小值），查询每门学科的最高成绩对应的学生姓名和分数。
1. 使用自联结

``` mysql
SELECT
	t1.course,
	t1.name,
	t1.score
FROM
	test t1
INNER JOIN (
	SELECT
		course,
		MAX(score) AS max
	FROM
		test
	GROUP BY
		course
) t2 ON t1.course = t2.course
AND t1.score = t2.max;
+--------+--------+-------+
| course |name   | score |
+--------+--------+-------+
| 语文   | 王五   |    93 |
| 数学   | 王五   |    99 |
| 英语   | 张三   |    90 |
+--------+--------+-------+
```

2. 使用关联子查询

``` mysql
SELECT
	t1.course,
	t1.name,
	t1.score
FROM
	test t1
WHERE
	t1.score = (
		SELECT
			MAX(score)
		FROM
			test t2
		WHERE
			t1.course = t2.course
	);
+--------+--------+-------+
| course | name   | score |
+--------+--------+-------+
| 语文   | 王五   |    93 |
| 数学   | 王五   |    99 |
| 英语   | 张三   |    90 |
+--------+--------+-------+
```

### TopN

查询分组内的前（后）N个值，查询每门学科成绩最高的前两名对应的学生姓名和分数。
1. 使用自联结

``` mysql
SELECT
	t1.course,
	t1.name,
	t1.score
FROM
	test t1
LEFT JOIN test t2 ON t1.course = t2.course
AND t1.score < t2.score
GROUP BY
	t1.name,
	t1.score
HAVING
	COUNT(t2.id) < 2
ORDER BY
	t1.course,
	t1.score DESC;
+--------+--------+-------+
| course |name   | score |
+--------+--------+-------+
| 数学   | 王五   |    99 |
| 数学   | 张三   |    77 |
| 英语   | 张三   |    90 |
| 英语   | 王五   |    89 |
| 语文   | 王五   |    93 |
| 语文   | 李四   |    90 |
+--------+--------+-------+
```

2. 使用关联子查询

``` mysql
SELECT
	t1.course,
	t1.name,
	t1.score
FROM
	test t1
WHERE
	2 > (
		SELECT
			COUNT(1)
		FROM
			test t2
		WHERE
			t1.course = t2.course
		AND t1.score < t2.score
	)
ORDER BY
	t1.course,
	t1.score DESC;
+--------+--------+-------+
| course | name   | score |
+--------+--------+-------+
| 数学   | 王五   |    99 |
| 数学   | 张三   |    77 |
| 英语   | 张三   |    90 |
| 英语   | 王五   |    89 |
| 语文   | 王五   |    93 |
| 语文   | 李四   |    90 |
+--------+--------+-------+
```