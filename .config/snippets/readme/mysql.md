<!--
 FileName:      sql
 Author:        8ucchiman
 CreatedDate:   2023-05-11 12:46:50
 LastModified:  2023-01-25 10:56:12 +0900
 Reference:     8ucchiman.jp
 Description:   ---
-->


# DDL(データ定義言語)
- CREATE
- DROP
- ALTER(データベースやテーブルの変更)

# DML(データ操作言語)
- SELECT
- INSERT
- UPDATE
- DELETE

# DCL(データ制御言語)
- BEGIN(トランザクション開始)
- COMMIT
- ROLLBACK



# 型の種類

| type   | 説明                |
|------  |---------------------|
|CHAR    | 固定長文字列(0~255) |
|VARCHAR | 可変長文字列(~2000) |
|INT     |       数値型        |
|DATE    |       日付型        |


# Primary Key
カラムをPrimary Keyに指定することで固有のIDとして識別できる

```
    +- primary key
    v
    ID | NAME
    1    山田
    2    佐藤 ✓
    3    鈴木 
    4    田中
    5    佐藤 ✓
```


# データベース
- SHOW DATABASES;  # DB一覧
- 

# テーブル
- SHOW TABLES;  # テーブル一覧



# Command
- SHOW PROCESSLIST;       # 現在接続しているデータベース表示
- SELECT database();      # 現在接続しているデータベース表示
- USE [database_name]     # 使いたいデータベース接続
- SHOW DATABASES;         # DB一覧
- SHOW TABLES;            # テーブル一覧
- DROP TABLE [table_name] # テーブル削除
- CREATE TABLE item(CODE CHAR(6), NAME VARCHAR(40), TYPE VARCHAR(10), PRICE INT, COST INT, PRIMARY KEY(CODE));  # テーブル作成
- SELECT * FROM FOOD;     # FOODテーブルからデータを取得
- SELECT NAME FROM FOOD;  # FOODテーブルから指定したカラムのデータを取得
- SELECT * FROM FOOD WHERE NAME='tomato';   # FOODテーブルからNAMEカラムが'tomato'の行を検索
- SELECT * FROM FOOD WHERE NAME='tomato' AND CATEGORY='vegetable';   # FOODテーブルからNAMEカラムが'tomato'かつCATEGORYカラムが'vegetable'の行を検索
- SELECT * FROM USERS WHERE AGE!=20;   # USERSテーブルからAGE!=20の行を選択
- SELECT * FROM USERS WHERE AGE BETWEEN 20 AND 28;  # USERSテーブルから年齢が20~28歳の行を選択
- SELECT * FROM USERS WHERE AGE IN (20, 35);        # 指定したいずれかの値が含まれているデータを検索
- SELECT * FROM USERS WHERE AGE NOT IN (20, 35);    # 指定したいずれかの値が含まれていないデータを検索
- SELECT * FROM USERS WHERE NAME LIKE 'Mich%';      # 指定した文字列が含まれているデータの検索。%は0文字以上の文字列
- SELECT * FROM USERS WHERE AGE IS [NOT] NULL;      # 値がNULLのデータの検索
- SELECT * FROM USERS WHERE CATEGORY = (SELECT NAME FROM CATEGORY WHERE ID = 1);   # サブクエリ検索
- SELECT * FROM USERS ORDER BY AGE ASC;             # 昇順で並び替え
- SELECT * FROM USERS ORDER BY AGE DESC;
- SELECT COUNT(*) FROM USERS;                       # レコード数を取得
- SELECT COUNT(AGE) FROM USERS;                     # AGEの値がNULL以外のレコード数を取得
- SELECT `MAX`(AGE) FROM USERS;                       # 最大値を取得
- SELECT `MIN`(AGE) FROM USERS;
- SELECT `SUM`(AGE) FROM USERS;
- SELECT `AVG`(AGE) FROM USERS;
- SELECT GENDER FROM USERS GROUP BY GENDER;         # レコードのグループ化
- SELECT GENDER, COUNT(*) FROM USERS GROUP BY GENDER;
- SELECT GENDER, COUNT(*) FROM USERS GROUP BY GENDER `HAVING` COUNT(*) > 2;     # `グループ化後`, グループ化したデータの絞り込み条件

- SELECT GENDER MAX(AGE) FROM USERS WHERE AGE>20 GROUP BY GENDER HAVING MAX(AGE) <30;   # 優先度は`FROM, WHERE, GROUP BY, HAVING, SELECT, ORDER BY`
- SELECT AGE+1 AS AGE FROM USERS WHERE NAME = '佐藤'   # 演算
- SELECT NAME||'('||GENDER||')' AS NAME, AGE FROM USERS WHERE NAME='佐藤'    # 佐藤 -> 佐藤(Man)
- INSERT INTO Customers (CustomerName, ContactName, Address, City, PostalCode, Country) VALUES ('Cardinal', 'Tom B. Erichsen', 'Skagen 21', 'Stavanger', '4006', 'Norway');          # INSERT INTO table_name (column1, column2, column3, ...) VALUES (value1, value2, value3, ...);


- CREATE DATABASE [database_name]
- LOAD data local infile '/root/sheet.csv' into table edb.ecomponents fields terminated by ',';  # csvファイルをインポート
- SET GLOBAL local_infile=1; # https://stackoverflow.com/questions/59993844/error-loading-local-data-is-disabled-this-must-be-enabled-on-both-the-client
- \! ls
