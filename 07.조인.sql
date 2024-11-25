USE db_company;


/* CROSS JOIN */
-- 조인 조건이 없는 조인 방식. CROSS JOIN 키워드 사용.
-- 조인 조건이 잘못 작성된 경우에도 CROSS JOIN 을 수행.
-- 1. 모든 사원의 부서번호, 부서명, 사원번호, 사원명 조회하기
SELECT d.dept_id, e.dept_id, dept_name, emp_id, emp_name -- dept_id은 tbl_department, tbl_employee 둘다 있어서 명시 해줘야 한다.
  FROM tbl_department d CROSS JOIN tbl_employee e; -- d, e 별명
    
/* INNER JOIN */
-- 두 테이블 모두 갖고 있는 데이터를 조회할때 사용
-- 반드시 올바른 조인 조건을 작성해야 함.

-- 테이블 작성
-- FROM "Drive Table" JOIN "Driven Table" => PK를 가지고있는 TABLE 이 Drive Table이다 (PK FK가 안보일때 일반적으로 데이터양이 적은것을 Drive Table)
--                                           Drive Table 데이터 관계쌍 PK를 가진 테이블을 사용 ( 행 : Row 가 적은 테이블 사용)
--   ON        a       =      b           => 조인 조건 : PK를 a에 배치 FK를 B에 배치
--                                           ON 절에서도 "Drive Table"의 칼럼을 먼저 작성.
-- 2. 모든 사원의 부서번호, 부서명, 사원번호, 사원명 조회하기
SELECT d.dept_id, e.dept_id, dept_name, emp_id, emp_name
  FROM tbl_department d INNER JOIN tbl_employee e
    on d.dept_id = e.dept_id;
    
-- 3. 대구에 근무하는 사원 조회하기
SELECT emp_id, e.dept_id, emp_name, position, gender, hire_date, salary
  FROM tbl_department d INNER JOIN tbl_employee e
    ON d.dept_id = e.dept_id
 WHERE location = '대구';
 
-- 4. 지역별로 근무하는 사원 수 조회하기
SELECT location, COUNT(*)
  FROM tbl_department d INNER JOIN tbl_employee e
    ON d.dept_id = e.dept_id
 GROUP BY location;
 
 -- 5. (db_menu 스키마) 메뉴코드, 메뉴명, 가격, 카테고리이름, 주문가능여부 조회하기.
 USE db_menu;
 SELECT menu_code, menu_name, menu_price, category_name, orderable_status
   FROM tbl_category c INNER JOIN tbl_menu m
     on c.category_code = m.category_code;
     
/* OUTER JOIN */
-- 어느 한 테이블만 가지고 있는 데이터를 조회할때 사용.
-- LEFT /* OUTER 생략가능*/ JOIN : 첫 번째 테이블(왼쪽에 있음)의 모든 데이터는 항상 조회되는 방식.
-- RIGHT /* OUTER 생략가능*/ JOIN : 두 번째 테이블(오른쪽에 있음)의 모든 데이터는 항상 조회되는 방식.

-- 6. 부서별 사원수 조회하기. 근무중이 사원이 없으면 0 을 표시.
USE db_company;
SELECT dept_name, COUNT(emp_id)  -- LEFT RIGHT 사용시 정확한 기제가 필요 
                                 -- COUNT(*)을 하면 부서쪽 데이터가 있어서 카운팅이 잘못됨
                                 -- emp_id 사원번호는 NOT NULL(PK) 임으로 COUNT 칼럼으로 지정한다.
  FROM tbl_department d LEFT JOIN tbl_employee e
    ON d.dept_id = e.dept_id
 GROUP BY d.dept_id, dept_name;
 
-- 5. (db_menu 스키마) 메뉴이름, 모든 카테고리이름조회하기.
USE db_menu;
SELECT menu_name, category_name
  FROM tbl_category c LEFT JOIN tbl_menu m
    on c.category_code = m.category_code;
    
/* SELF JOIN */
-- 테이블 하나를 대상으로 행과 행 사이 관계를 찾는 조인 방식.

-- 8. 카테고리이름, 상위 카테고리 이름 조회하기
SELECT a.category_name AS 카테고리, b.category_name AS 상위카테고리
  FROM tbl_category a INNER JOIN tbl_category b
    on a.ref_category_code = b.category_code
 WHERE a.ref_category_code IS NOT NULL;  -- ref_category_code가 NULL인것을 빼고 조회하여 성능을 향상 시킨다.