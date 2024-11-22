/*
    다대다 관계
    두 엔티티 사이에 다대다 관계가 존재할 수 있다.
    예시 : 학생과 과목, 고객과 상품 등
    다대다 관계는 두 엔티티의 직접 연결이 불가능하므로, 새로운 엔티티를 추가하여 2개의 일대다 관계로 구성한다.
    예시 : 학생과 과목(학생 - 수강신청 - 과목), 고객과 상품(고객 - 구매내역 - 상품)
*/

-- 학생 - 수강신청 - 과목

USE testdb;

DROP TABLE IF EXISTS tbl_enroll;
DROP TABLE IF EXISTS tbl_course;
DROP TABLE IF EXISTS tbl_student;

CREATE TABLE IF NOT EXISTS tbl_student
(
    stud_id   CHAR(5) NOT NULL COMMENT '학번',
    stud_name VARCHAR(10) COMMENT '학생명',
    age       TINYINT COMMENT '나이',
    CONSTRAINT pk_student PRIMARY KEY(stud_id)
) ENGINE=INNODB COMMENT '학생';

CREATE TABLE IF NOT EXISTS tbl_course
(
    course_id   CHAR(1) NOT NULL COMMENT '과목코드',
    course_name VARCHAR(10) COMMENT '과목명',
    prof_name   VARCHAR(10) COMMENT '교수명',
    CONSTRAINT pk_course PRIMARY KEY(course_id)
) ENGINE=INNODB COMMENT '과목';

CREATE TABLE IF NOT EXISTS tbl_enroll
(
    stud_id   CHAR(5) NOT NULL COMMENT '학번',
    course_id CHAR(1) NOT NULL COMMENT '과목코드',
    CONSTRAINT pk_enroll PRIMARY KEY(stud_id, course_id),
    CONSTRAINT fk_student_enroll FOREIGN KEY(stud_id) REFERENCES tbl_student(stud_id),
    CONSTRAINT fk_course_enroll FOREIGN KEY(course_id) REFERENCES tbl_course(course_id)
) ENGINE=INNODB COMMENT '수강신청';