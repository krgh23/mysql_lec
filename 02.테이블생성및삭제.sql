-- 테이블을 저장할 스키마 선택하기
USE testdb;

/*
  테이블은 부모 테이블을 먼저 만들고, 자식 테이블(FK를 가진 테이블)을 나중에 만든다.
  테이블 삭제와 생성 순서는 항상 역순으로 작업한다.
*/
-- 테이블 삭제하기 (있으면 삭제한다)
-- tbl_product을 먼저 지우면 tbl_order의 FK의 무결점 위배
-- CASCADE = 참조중인 테이블이 존제하면 함께 삭제하는 CASCADE 옵션
DROP TABLE IF EXISTS tbl_order CASCADE;
DROP TABLE IF EXISTS tbl_product CASCADE;

-- 테이블 만들기 (IF NOT EXISTS = 없으면 만든다.)
CREATE TABLE IF NOT EXISTS tbl_product
(
    -- NOT NULL = pk(기본키) id에는 null값이 있을수 없다, 
    -- AUTO_INCREMENT = 자동으로 1부터 숫자가 올라간다
    -- PRIMARY KEY = 기본키 설정
    -- COMMENT = 커멘트
    prod_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT '제품코드',
    -- VARCHAR(20) = 최대 길이 20자
    -- NULL = NULL을 적어주거나 아에 안적어주면 NULL이 하다.
    prod_name VARCHAR(20) NULL COMMENT '제품이름',
    -- INT(5) = 29,999원까지 설정가능 일부러 제한을 두어 데이터확보
    price INT(5) COMMENT '제품가격',
    -- SMALLINT = 2바이트
    -- DEFAULT 0 = 아무값도 없으면 "0"이 들어간다(기본값)
    stock SMALLINT DEFAULT 0 COMMENT '제품재고'
) ENGINE=INNODB COMMENT '제품';

CREATE TABLE IF NOT EXISTS tbl_order
(
    order_id INT NOT NULL AUTO_INCREMENT COMMENT '주문번호',
    order_user VARCHAR(20) COMMENT '주문자',
    -- 왜레키에는 NOT NULL을 잘 안준다. 줄수는 있다.
    prod_id INT COMMENT '제품번호',
    -- DATETIME 날짜 연산을 한할거면 STRING 사용이 더 좋음 더 빠름
    -- NOW() = 현재 시간
    order_dt DATETIME DEFAULT NOW() COMMENT '주문일자',
    -- PK 나눠서 작성하는법 = order_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY(order_id),
     PRIMARY KEY(order_id),
    -- FOREIGN KEY(칼럼 이름)
    -- REFERENCES = tbl_product 테이블의 prod_id 아이디를 참조한다. 참조와 같은 타입을 갖는다.
    -- 일반적으로 FK는 제일 하단에 배치한다.
    FOREIGN KEY(prod_id) REFERENCES tbl_product(prod_id)
) ENGINE=INNODB COMMENT '주문';

-- 주문 테이블의 자동 증가 순번은 1000 에서 시작한다.
-- ALTER TABLE = 테이블 변경(ALTER = 변경)
ALTER TABLE tbl_order AUTO_INCREMENT = 1000;




