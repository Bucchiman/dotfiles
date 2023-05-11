/*
 * FileName:     {{_file_name_}}
 * Author:       {{_author_}}
 * CreatedDate:  {{_date_}}
 * LastModified: 2023-02-26 13:30:39 +0900
 * Reference:    8ucchiman.jp
 * Description:  ---
 */


CREATE TABLE item(
    CODE CHAR(6),
    NAME VARCHAR(40),
    TYPE VARCHAR(10),
    PRICE INT,
    COST INT,
    PRIMARY KEY(CODE)
);

{{_cursor_}}
