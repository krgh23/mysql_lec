USE db_company;

/* 클러스터 인덱스 : PK에 부여된 인덱스 */
-- 1. (인덱스 태우기) 부서번호가 1인 부서 조회하기
SELECT dept_id, dept_name, location
  FROM tbl_department
 WHERE dept_id = 1;  -- 인덱스가 설정된 칼럼으로 조회(PK) (Execution Plan : Single Row)
                     -- 인덱스의 동등비교는 인덱스를 태운다
                     
SELECT dept_id, dept_name, location
  FROM tbl_department
 WHERE dept_id * 2 = 2; -- 인덱스가 설정된 칼럼을 조작하면(함수, 연산 등) 더 이상 인덱스를 타지 않는다. (Execution Plan : Full Table San)
                        -- 인덱스를 태우려면 왼쪽은 건들지 말고 오른쪽만 조작가능
 
 -- 2. (인덱스 안 태우기) 부서명이 '영업부'인 부서 조회하기
 SELECT dept_id, dept_name, location
  FROM tbl_department
 WHERE dept_name = '영업부'; -- 일반 칼럼으로 조회 (Execution Plan : Full Table San)

-- 3. 부서번호가 1 이상인 부서 조회하기
SELECT dept_id, dept_name, location
  FROM tbl_department
 WHERE dept_id >= 1;  -- 인덱스의 범위 조건은 검색 엔진이 Index Range Scan 또는 Full Table San 중 선택해서 동작한다.(직접선택불가)
                      -- 인덱스 범위 스캔 (Execution Plan : Index Range Scan)



/* 보조 인덱스 만들기 */
CREATE INDEX ix_name
    ON tbl_employee(emp_name ASC);

SELECT emp_id, dept_id, emp_name, position, gender, hire_date, salary 
  FROM tbl_employee
 WHERE emp_name LIKE '이은영';  -- 정상적으로 인덱스 태우기

SELECT emp_id, dept_id, emp_name, position, gender, hire_date, salary 
  FROM tbl_employee
 WHERE emp_name LIKE '이%';  -- (Execution Plan : Index Range Scan)
 
SELECT emp_id, dept_id, emp_name, position, gender, hire_date, salary 
  FROM tbl_employee
 WHERE SUBSTRING(emp_name, 1, 1) = '이';  -- emp_name LIKE '이%'와 결과는 같지만 인덱스 칼럼을 함수처리 하여 인덱스를 타지 않는다
                                          -- (Execution Plan : Full Table San) 
                                          -- SUBSTRING(emp_name, 1, 1) : 1번째 글자부터 1글자만 추출(첫번째 글자 위치 '0'이 아님 주의)