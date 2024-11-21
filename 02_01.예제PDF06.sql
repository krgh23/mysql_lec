USE testdb;

DROP TABLE IF EXISTS customer_tbl CASCADE;
DROP TABLE IF EXISTS bank_tbl CASCADE;

CREATE TABLE IF NOT EXISTS bank_tbl
(
    bank_id VARCHAR(20) NOT NULL COMMENT '은행id',
    bank_name VARCHAR(30) COMMENT '은행이름',
    CONSTRAINT pk_bank PRIMARY KEY(bank_id)  -- CONSTRAINT pk_bank 제약 조건의 이름 주는법
) ENGINE=INNODB COMMENT '은행';

CREATE TABLE IF NOT EXISTS customer_tbl
(
    cust_id INT NOT NULL AUTO_INCREMENT COMMENT '고객코드',
    cust_name VARCHAR(30) NOT NULL COMMENT '고객명',
    phone VARCHAR(30) UNIQUE COMMENT '고객전화번호', 
    age SMALLINT CHECK(age >= 0 AND age <= 100) COMMENT '고객나이', -- CHECK(age BETWEEN 0 AND 100)
    bank_id VARCHAR(20) COMMENT '은행id',
    CONSTRAINT pk_customer PRIMARY KEY(cust_id),
    CONSTRAINT fk_bank_customer FOREIGN KEY(bank_id) REFERENCES bank_tbl(bank_id)
) ENGINE=INNODB COMMENT '은행고객';