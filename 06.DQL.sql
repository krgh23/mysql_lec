USE db_company;

/* SELECT ~ FROM ~ */

-- 1. 부서테이블의 모든 데이터 조회하기
SELECT *  -- * : 모든 칼럼을 의미한다. 실무에서는 사용 금지. (성능 이슈 : 사용시 감사에 걸림)
  FROM tbl_department;

-- 2. 부서 테이블에서 위치만 조회하기
SELECT location
  FROM tbl_department;
  
-- 3. 부서 테이블에서 위치의 중복을 제가하고 조회하기
SELECT DISTINCT location -- 중복 제거 : DISTINCT
  FROM tbl_department;

-- 4. 칼럼에 별명 지정하기
SELECT 
        dept_id   AS 부서번호
      , dept_name AS 부서명
      , location  AS "부서 위치"  -- 별명에 공백불가 하지만 ""으로 묶어주면 가능
  FROM
        tbl_department;
        
-- 5. 오너 명시(데이터베이스, 테이블)
SELECT
        tbl_department.dept_id  -- 테이블명은 생략 가능
      , tbl_department.dept_name
      , tbl_department.location
  FROM
        db_company.tbl_department;  -- USE db_company 로 인하여 데이터베이스는 생략 가능

-- 6. 테이블에 별명 지정하기 (AS 별명 or AS 생략하고 별명만 지정)
SELECT
        d.dept_id
      , d.dept_name
      , d.location
  FROM
        tbl_department d;  -- 별명 'd'




/* WHERE ~ */

-- 7. 대구에 있는 부서 조회하기
SELECT dedept_id, dept_name, location
  FROM tbl_department
 WHERE location = '대구'; -- 비교 연산자 (-, !=, >, >=, <, <=)
 
-- 8. 부서번호가 1이고 연봉이 3000000 이상인 사원 조회하기
SELECT emp_id, dept_id, emp_name, position, gender, hire_date, salary
  FROM tbl_employee
 WHERE dept_id = 1 AND salary >= 3000000; -- 논리 연산자 (AND, OR, NOT)
 
 
-- 9. 연봉이 3000000 ~ 5000000 사이인 사원 조회하기
SELECT emp_id, dept_id, emp_name, position, gender, hire_date, salary
  FROM tbl_employee
 WHERE salary BETWEEN 3000000 AND 5000000;  -- 실무에서는 BETWEEN을 사용 WHERE salary >= 3000000 AND salary <= 5000000; -- 논리 연산자 (AND, OR, NOT)
  
-- 10. 직급이 '과정', '부장' 인 사원 조회하기
SELECT emp_id, dept_id, emp_name, position, gender, hire_date, salary
  FROM tbl_employee
 WHERE position IN ('과장', '부장');  -- 실무에서는 IN을 사용 WHERE position = '과장' OR position = '부장'; 
 
-- 11. 직급이 '과정', '부장' 아닌 사원 조회하기
SELECT emp_id, dept_id, emp_name, position, gender, hire_date, salary
  FROM tbl_employee
 WHERE position NOT IN ('과장', '부장');  -- 실무에서는 NOT IN을 사용 
                                          -- WHERE position != '과장' AND position != '부장'; 
                                          -- WHERE position <> '과장' AND position != '부장'; 
                                          
-- 12. 사원명이 '한'으로 시작하는 사원 조회하기
SELECT emp_id, dept_id, emp_name, position, gender, hire_date, salary
  FROM tbl_employee
 WHERE emp_name LIKE '한%'; -- % : 와일드카드(만능 문자 : 글자 수의 제한이 없는 모든문자를 의미한다. 글자가 없더도 된다.)
                            -- LIKE 연산자 : 와일드 카드 전용 연산자 ('=' 은 사용 불가)

-- 13. 사원명에 '민'이 포함하는 사원 조회하기
SELECT emp_id, dept_id, emp_name, position, gender, hire_date, salary
  FROM tbl_employee
 WHERE emp_name LIKE CONCAT('%', '한', '%'); -- CONCAT('%', '한', '%') 함수결과는 '%민%' 이다. (전달된문자열을모두이어붙인결과를반환)
 
-- 14. (db_menu 스키마) 상위카테고리코드가 없는 카테고리 조회하기
SELECT category_code, category_name, ref_category_code
  FROM db_menu.tbl_category
 WHERE ref_category_code IS NULL; -- IS NULL : NULL 이다. ('=' 사용불가)
 
-- 15. (db_menu 스키마) 상위카테고리코드가 있는 카테고리 조회하기
SELECT category_code, category_name, ref_category_code
  FROM db_menu.tbl_category
 WHERE ref_category_code IS NOT NULL; -- IS NOT NULL = NOT NULL 이다. ('!=' 사용불가)




/* GROUP BY ~ HAVING ~ */
-- GROUP BY 는 성능을 낮춤으로 WHERE절 사용이 가능할때는 sampling 데이터를 줄여서 사용한다.
-- 함수가 사용될때 GROUP BY 를 사용 (GROUP BY에 가지고있는걸 SELECT가 조회할수있다.)
-- 통계함수가 조건에서 사용될때 HAVING 절 사용
/*
      SUM() : 합계
      AVG() : 평균
      MAX() : 최대
      MIN() : 최소
    COUNT() : 개수
*/
-- 16. 직급별로 그룹화하여 급여의 평균 조회하기
SELECT position, AVG(salary)  -- GROUP BY 절에 명시한 칼럼만 SELECT절에서 조회할 수 있다.
  FROM tbl_employee
 GROUP BY position;   -- 직급별로 그룹화 작업

-- 17. 부서별로 사원 수 조회하기
SELECT dept_id AS 부서번호, COUNT(*) AS 사원수  -- COUNT(*) : 모든칼럼을 조회하여 어느 한 칼럼이라도 값을 가지고 있으면 카운트에 포함한다. (NULL값이 있을떄 사용)
  FROM tbl_employee
 GROUP BY dept_id;

-- 18. 직급별 급여의 평균이 5000000 이상인 직급 조회하기
SELECT position, AVG(salary)
  FROM tbl_employee
 GROUP BY position
HAVING AVG(salary) >= 5000000;  -- HAVING 절에서 통계 함수를 이용한 조건식을 사용할 수 있다.

-- 사용 불가능한 쿼리문
SELECT position, AVG(salary)
  FROM tbl_employee
 WHERE AVG(salary) >= 5000000  -- 통계 함수는 WHERE 절에서 사용할 수 없다.
 GROUP BY position;
 
-- 19. 직급별 사원 수 구하기. 직급이 '과장'인 직급만 조회하기.
SELECT position, COUNT(*)
  FROM tbl_employee       -- sampling 데이터가 10000개
 WHERE position = '과장'  -- '과장' 데이터로 sampling 데이터를 줄여서 그룹, (통계 함수가 사용되지 않는 일발 조건. WHERE 절로 작성권장)
 GROUP BY position;       -- 과장이 10000개중 1000명이라면 1000명만 그룹핑 되어 성능이 좋아진다.

SELECT position, COUNT(*)
  FROM tbl_employee       -- sampling 데이터가 10000개
 GROUP BY position        -- sampling 데이터 전체를 대상으로 그룹
HAVING position = '과장'; -- HAVING 절에서 사용시 전체(10000개)를 대상으로 그룹핑 하여 코스트가 높음(시간많이걸림)


/* ORDER BY ~ */

-- 20. 사원명 순으로 사원 조회하기
SELECT emp_id, dept_id, emp_name, position, gender, hire_date, salary
  FROM tbl_employee
 ORDER BY emp_name ASC; -- ASCending(어센딩) : 오름차순 정렬 (사전 편찬 수 : 알파벳, 가나다) - 디폴트(생략 가능) / DESCending(디센딩) : 내림차순 정렬
 
-- 21. 직급의 오름차순, 동일 직급은 고용일의 내림차순 정렬
SELECT emp_id, dept_id, emp_name, position, gender, hire_date, salary
  FROM tbl_employee
 ORDER BY position, hire_date DESC; -- position ASC, hire_ date DESC
 
/* LIMIT ~ */
-- 일반적 패턴 : 원하는 기준으로 정렬한 뒤 일부만 조회

-- 22. 가장 먼저 입사한 사원 조회하기
SELECT emp_id, dept_id, emp_name, position, gender, hire_date, salary
  FROM tbl_employee
 ORDER BY hire_date
 LIMIT 0, 1; -- 첫번째 행(0) 부터 1개 행 조회. LIMIT 1;

-- 23. 급여가 2 ~ 3번째로 높은 사원 조회하기.
SELECT emp_id, dept_id, emp_name, position, gender, hire_date, salary
  FROM tbl_employee
 ORDER BY salary DESC
 LIMIT 1, 2; -- 2행(1)부터 2개 행 조회