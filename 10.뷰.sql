USE db_company;

-- 사원 정보와 부서 정보를 자주 조회하는 경우
-- 조인 쿼리문을 하나의 뷰로 저장해 두면 쉽게 조인을 사용할 수 있다.

-- 뷰 생성(치환)하기 (쿼리문을 저장해 두는 방식)
CREATE OR REPLACE VIEW v_emp AS      -- CREATE OR REPLACE VIEW v_emp AS : 없으면 만들고 있으면 바꿔라 
                                     -- CREATE VIEW v_emp AS : 생성
SELECT emp_id, d.dept_id, dept_name, location, emp_name, position, gender, hire_date, salary
  FROM tbl_department d INNER JOIN tbl_employee e
    ON d.dept_id = e.dept_id;
    
-- 뷰 조회하기
SELECT * FROM v_emp;  -- 실무에서 SELECT * 사용불가
SELECT * FROM v_emp WHERE dept_name = '영업부';
SELECT *
  FROM v_emp a LEFT JOIN tbl_proj_emp b   -- 3개의 뷰 조인하는 방법중 한가지 방법
    on a.emp_id = b.emp_id;

-- INSERT 결과가 뷰에 반영이되는가? OK (UPDATE / DELETE 결과도 모두 반영한다.)
INSERT INTO tbl_employee VALUES (NULL, 3, '홍길동', '사원', 'F', '2015-11-17', '3000000');
COMMIT; 
