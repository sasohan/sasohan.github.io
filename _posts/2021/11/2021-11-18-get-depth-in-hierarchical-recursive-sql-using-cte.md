---
layout: post
title: 계층적인 데이터 형태에서 depth를 찾는 sql
date: 2021-11-18 10:30:00 +0900
tags:
  - sql
  - depth
  - hierarchy
  - recursive
  - cte
---

대댓글, 대대댓글이 가능한 댓글 시스템이나 파일 폴더(디렉토리) 시스템의 구조, 쇼핑몰에서 사용하는 계층적인 카테고리를 DB에 저장하기 위해 보통 하나의 테이블에 부모의 아이디(인덱스)를 함께 저장하는 방식으로 구현한다.

카테고리를 예로 들어보자.

아래와 같은 카테고리 구조를 만들고 싶다면,

- 의류
  - 남성의류
    - 남성 상의
      - 셔츠
        - 티셔츠
      - 아우터
    - 남성 하의
  - 여성의류

테이블을 이렇게 구성하고,

```sql
CREATE TABLE `category` (
  `id` int(10) UNSIGNED NOT NULL COMMENT '자신의 고유 아이디',
  `parent_id` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '부모 아이디',
  `name` varchar(128) NOT NULL,
  `description` varchar(1024) NOT NULL
) ENGINE=InnoDB;
```

데이터를 이렇게 넣어주면 된다.

| id  | parent_id | name      | description |
| :-: | :-------: | :-------- | :---------- |
|  1  |     0     | 의류      | 패완얼      |
|  2  |     1     | 남성의류  | 남성        |
|  3  |     1     | 여성의류  | 여성        |
|  4  |     2     | 남성 상의 | 윗도리      |
|  5  |     2     | 남성 하의 | 아랫도리    |
|  6  |     4     | 셔츠      |             |
|  7  |     4     | 아우터    |             |
|  8  |     6     | 티셔츠    |             |

<hr />

이 때, 만약 각각의 카테고리가 얼마나 하위에 있는지를 알 수 있도록 `depth`를 구해야 한다면 어떻게 하면 될까.

이런 경우 `depth`가 얼마나 깊을지 모르므로 `join`을 반복해서 쓰는 건 불가능하다.

그래서 어떻게든 재귀적(recursive) 탐색을 할 수 있는 쿼리를 구성하거나 일단 데이터를 꺼낸 후 랭귀지 단에서 처리를 하는 경우도 많은데,

`CTE`를 이용하면 비교적 쉽게 `depth`를 구할 수 있다.

```sql
WITH RECURSIVE cte (id, parent_id, name, description, depth) AS (
  SELECT
    id, parent_id, name, description, 1 AS depth
  FROM
    category
  WHERE
    parent_id = 0
  UNION ALL
  SELECT
    uc.id, uc.parent_id, uc.name, uc.description, (depth + 1) AS depth
  FROM
    category AS uc
    INNER JOIN cte ON uc.parent_id = cte.id
)
SELECT * FROM cte ORDER BY depth ASC, name ASC;
```

이렇게 하면 아래처럼 결과를 구할 수 있다.

| id  | parent_id | name      | description | depth |
| :-: | :-------: | :-------- | :---------- | :---: |
|  1  |     0     | 의류      | 패완얼      |   1   |
|  2  |     1     | 남성의류  | 남성        |   2   |
|  3  |     1     | 여성의류  | 여성        |   2   |
|  4  |     2     | 남성 상의 | 윗도리      |   3   |
|  5  |     2     | 남성 하의 | 아랫도리    |   3   |
|  6  |     4     | 셔츠      |             |   4   |
|  7  |     4     | 아우터    |             |   4   |
|  8  |     6     | 티셔츠    |             |   5   |

`CTE`는 `Common Table Expression`의 약자이고, 하나의 명령문(sql) 내에서 여러 번 참조할 수 있도록 이름을 붙여 임시로 결과를 만들어 두는 기능이다.
