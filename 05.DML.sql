USE db_company;

ALTER TABLE tbl_employee AUTO_INCREMENT = 1001;

-- 행 삽입하기
-- 단일 행 삽입
-- INSERT INTO 테이블(칼럼, ... (생략가능 생략하면 모든 칼럼의 값을 전달함)) VALUES (값, ...)
-- 다중 행 삽입
-- INSERT INTO 테이블(칼럼, ...) VALUES (값, ...), (값, ...), ...;
INSERT INTO tbl_department(dept_name, location) VALUES ('영업부', '대구');
INSERT INTO tbl_department(dept_name, location) VALUES ('인사부', '서울');
INSERT INTO tbl_department(dept_name, location) VALUES ('총무부', '대구');
INSERT INTO tbl_department(dept_name, location) VALUES ('기획부', '서울');
    
-- tbl_employee 의 첫 번째 칼럼 emp_id 에는 NULL 값을 전달해서 emp_id 칼럼의 AUTO_INCREMENT 동작을 보장한다. // 실행하면 '가'저장됨
INSERT INTO tbl_employee VALUES (NULL, 1, '구창민', '과장', 'M', '95-05-01', 5000000);
INSERT INTO tbl_employee VALUES (NULL, 1, '김민서', '사원', 'M', '17-09-01', 2500000);
INSERT INTO tbl_employee VALUES (NULL, 2, '이은영', '부장', 'F', '90-09-01', 5500000);
INSERT INTO tbl_employee VALUES (NULL, 2, '한성일', '과장', 'M', '93-04-01', 5000000);

-- 영구적으로 저장 (Transaction(트랜잭션) - PDF06)
-- ACID = 원자성(Atomicity), 일관성(Consistency), 격리성(Isolation), 지속성(Durability)
COMMIT;

-- 이전 커밋으로 복귀 // AUTO_INCREMENT은 한번쓰면 롤백이 되지않음
-- ROLLBACK;

-- 수정/삭제를 위한 테스트 데이터
INSERT INTO tbl_employee VALUES (NULL, 1, '테스트', '테스트부서', 'F', DATE(NOW()), 500000);

-- 행 수정하기
-- UPDATE 테이블 SET 칼럼 = 값, ... WHERE 조건식;  // pk를 쓸수 있는 상황에서는 pk를 쓰는게 가장좋음(속도 빠름)
UPDATE tbl_employee SET emp_name = '코알라' WHERE emp_id = 1005;
UPDATE tbl_employee SET salary = salary * 1.5 WHERE emp_id = '1005'; -- mySQL에는 문자를 숫자로 연산해주는 기능이 있음

-- 행 삭제하기
-- DELETE FROM 테이블 WHERE 조건식; // pk를 쓸수 있는 상황에서는 pk를 쓰는게 가장좋음(속도 빠름)
DELETE FROM tbl_employee WHERE emp_id >= 1005;

ROLLBACK; -- 이전커밋까지 취소됨 // AUTO_INCREMENT은 한번쓰면 롤백이 되지않음


