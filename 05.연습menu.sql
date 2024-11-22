USE db_menu;

DROP TABLE IF EXISTS tbl_payment_order;
DROP TABLE IF EXISTS tbl_order_menu;
DROP TABLE IF EXISTS tbl_menu;
DROP TABLE IF EXISTS tbl_order;
DROP TABLE IF EXISTS tbl_payment;
DROP TABLE IF EXISTS tbl_department;



CREATE TABLE IF NOT EXISTS tbl_category
(
    category_code     INT NOT NULL AUTO_INCREMENT COMMENT '카테고리코드',
    category_name     VARCHAR(30) COMMENT '카테고리명',
    ref_category_code INT COMMENT '상위카테고리코드',
    CONSTRAINT pk_department PRIMARY KEY(category_code),
    CONSTRAINT fk_department FOREIGN KEY(ref_category_code) REFERENCES tbl_category(category_code)
) ENGINE=InnoDB COMMENT '카테고리';

CREATE TABLE IF NOT EXISTS tbl_menu
(
    menu_code        INT NOT NULL AUTO_INCREMENT COMMENT '메뉴코드',
    menu_name        VARCHAR(30) COMMENT '메뉴명',
    menu_price       INT COMMENT '메뉴가격',
    orderable_status CHAR(1) COMMENT '주문가능상태',
    category_code    INT COMMENT '카테고리코드',
    CONSTRAINT pk_menu PRIMARY KEY(menu_code),
    CONSTRAINT fk_department_menu FOREIGN KEY(category_code) REFERENCES tbl_category(category_code)
) ENGINE=InnoDB COMMENT '메뉴';

CREATE TABLE IF NOT EXISTS tbl_order
(
    order_code        INT NOT NULL AUTO_INCREMENT COMMENT '주문코드',
    order_date        VARCHAR(8) COMMENT '주문일자',
    order_time        VARCHAR(8) COMMENT '주문시간',
    total_order_price INT COMMENT '총주문금액',
    CONSTRAINT pk_order PRIMARY KEY(order_code)
) ENGINE=InnoDB COMMENT '주문';

CREATE TABLE IF NOT EXISTS tbl_order_menu
(
    menu_code        INT NOT NULL COMMENT '메뉴코드',
    order_code       INT NOT NULL COMMENT '주문코드',
    order_amount     INT COMMENT '수량',
    CONSTRAINT pk_order_menu PRIMARY KEY(menu_code, order_code),
    CONSTRAINT fk_menu_order_menu FOREIGN KEY(menu_code) REFERENCES tbl_menu(menu_code),
    CONSTRAINT fk_order_menu FOREIGN KEY(order_code) REFERENCES tbl_order(order_code)
) ENGINE=InnoDB COMMENT '주문메뉴';


CREATE TABLE IF NOT EXISTS tbl_payment_order
(
    order_code        INT NOT NULL AUTO_INCREMENT COMMENT '주문코드',
    payment_code      INT NOT NULL COMMENT '결제코드',
    CONSTRAINT pk_payment_order PRIMARY KEY(order_code, payment_code)
) ENGINE=InnoDB COMMENT '주문결제';

CREATE TABLE IF NOT EXISTS tbl_payment
(
    payment_code      INT NOT NULL COMMENT '결제코드',
    payment_date      VARCHAR(8) COMMENT '결제일',
    payment_time      VARCHAR(8) COMMENT '결제시간',
    payment_price      INT COMMENT '결제금액',
    payment_type      VARCHAR(8) COMMENT '결제구분',
    CONSTRAINT tbl_payment PRIMARY KEY(payment_code)
) ENGINE=InnoDB COMMENT '주문';

INSERT INTO tbl_category VALUES (NULL, '양식', null);
INSERT INTO tbl_category VALUES (NULL, '리조또', 1);
INSERT INTO tbl_category VALUES (NULL, '피자', 1);
INSERT INTO tbl_category VALUES (NULL, '파스타', 1);
INSERT INTO tbl_category VALUES (NULL, '토마토리조또', 2);
INSERT INTO tbl_category VALUES (NULL, '크림리조또', 2);
INSERT INTO tbl_category VALUES (NULL, '이탈리아피자', 3);
INSERT INTO tbl_category VALUES (NULL, '미국피자', 3);
INSERT INTO tbl_category VALUES (NULL, '토마토파스타', 4);
INSERT INTO tbl_category VALUES (NULL, '크림파스타', 4);
INSERT INTO tbl_category VALUES (NULL, '오일파스타', 4);

INSERT INTO tbl_menu VALUES (NULL, '크림버섯리조또', 10000, 'T', 6);
INSERT INTO tbl_menu VALUES (NULL, '토마토소고기리조또', 20000, 'T', 5);
INSERT INTO tbl_menu VALUES (NULL, '크림버섯파스타', 10000, 'T', 10);
INSERT INTO tbl_menu VALUES (NULL, '토마토소고기파스타', 20000, 'T', 9);

COMMIT;


