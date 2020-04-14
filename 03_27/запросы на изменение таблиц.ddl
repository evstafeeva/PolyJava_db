CREATE TABLE academic_sessions (
    id    VARCHAR2(10) NOT NULL,
    name  VARCHAR2(30) NOT NULL
);

CREATE TABLE courses (
    id    VARCHAR2(10) NOT NULL,
    name  VARCHAR2(30) NOT NULL
);

CREATE TABLE departments_for_ab (
    id    VARCHAR2(10)  NOT NULL,
    name  VARCHAR2(30)  NOT NULL,
    head  VARCHAR2(30)  NOT NULL
);

CREATE TABLE exams (
    id   VARCHAR2(10)  NOT NULL,
    str_date  DATE
);

CREATE TABLE faculties (
    id          VARCHAR2(10)  NOT NULL,
    frst_name    VARCHAR2(30)  NOT NULL,
    lst_name    VARCHAR2(30)  NOT NULL,
    email       VARCHAR2(30)  NOT NULL,
  
    sly         VARCHAR2(30),
    isu         VARCHAR2(30),

    hourly_rat  VARCHAR2(30)
);

CREATE TABLE faculty_course_details (
    cnt_hours  VARCHAR2(30)     NOT NULL
);

CREATE TABLE faculty_login_details (
    login_dte_tme  DATE NOT NULL
);

CREATE TABLE onlines (
    lgn_id  VARCHAR2(30) NOT NULL,
    pwd     VARCHAR2(30) NOT NULL
);

CREATE TABLE pnt_informations (
    id    VARCHAR2(10)   NOT NULL,
    pnt_1_frst_name  VARCHAR2(30)   NOT NULL,
    pnt_1_lst_name    VARCHAR2(30)   NOT NULL,
    pnt_2_frst_name  VARCHAR2(30)   NOT NULL,
    pnt_2_lst_name    VARCHAR2(30)   NOT NULL
);
CREATE TABLE seateds (
    bldn          VARCHAR2(30) NOT NULL,
    room         VARCHAR2(30) NOT NULL,
    date_time    DATE NOT NULL
);

CREATE TABLE student_attendances (
    number_of_wrk_days    NUMBER(10) NOT NULL,
    number_of_days_off    NUMBER(10) NOT NULL,
    eligbility_for_xm    VARCHAR2(30)
);

CREATE TABLE student_course_details (
    grade   NUMBER(10) NOT NULL
);

CREATE TABLE students (
    id    VARCHAR2(10)   NOT NULL,
    frst_name    VARCHAR2(30) NOT NULL,
    lst_name    VARCHAR2(30) NOT NULL,
    rgs_yea     DATE NOT NULL,
    email       VARCHAR2(30) NOT NULL
);


CREATE TABLE xam_results (
    grade   NUMBER(10)  NOT NULL
);


CREATE TABLE xam_types (
    typ   VARCHAR2(30)  NOT NULL,
    name  VARCHAR2(30)  NOT NULL,
    dsc   VARCHAR2(30)
);


ALTER TABLE courses ADD(
	dpt_id 		      VARCHAR2(10) NOT NULL,
    	onlines_lgn_id        VARCHAR2(10) ,
    	std_bld               VARCHAR2(10) ,
    	std_room              VARCHAR2(10) ,
    	date_time             DATE ,
    	academic_sessions_id  VARCHAR2(10)  NOT NULL);

ALTER TABLE courses
    ADD CONSTRAINT arc_1 CHECK ( ( ( onlines_lgn_id IS NOT NULL )
                                   AND ( std_bld IS NULL )
                                   AND ( std_room IS NULL )
                                   AND ( date_time IS NULL ) )
                                 OR ( ( std_bld IS NOT NULL )
                                      AND ( std_room IS NOT NULL )
                                      AND ( date_time IS NOT NULL )
                                      AND ( onlines_lgn_id IS NULL ) ) );

ALTER TABLE exams ADD xam_types_typ VARCHAR2(10);
ALTER TABLE faculties ADD dpt_id VARCHAR2(10);
ALTER TABLE faculty_course_details ADD 
	(crs_id VARCHAR2(10) NOT NULL,
    	fclt_id VARCHAR2(10) NOT NULL);
ALTER TABLE faculty_login_details ADD fclt_id VARCHAR2(10) NOT NULL;
ALTER TABLE student_attendances ADD 
	(stu_id  VARCHAR2(10) NOT NULL,
    	academic_sessions_id VARCHAR2(10) NOT NULL);
ALTER TABLE student_course_details  ADD 
(        stu_id  VARCHAR2(10) NOT NULL,
        crs_id  VARCHAR2(10) NOT NULL); 
ALTER TABLE students ADD pnt_inf_id VARCHAR2(10);
ALTER TABLE xam_results ADD 
	(stu_id  VARCHAR2(10) NOT NULL,
    	crs_id  VARCHAR2(10) NOT NULL, 
	xam_id  VARCHAR2(10) NOT NULL);


ALTER TABLE courses ADD CONSTRAINT unique_name_crs UNIQUE (name);
ALTER TABLE departments_for_ab  ADD CONSTRAINT unique_name_dprt UNIQUE (name);
ALTER TABLE students  ADD CONSTRAINT unique_email_std UNIQUE (email);
ALTER TABLE faculties ADD CONSTRAINT unique_email_fclt UNIQUE (email);
ALTER TABLE academic_sessions ADD CONSTRAINT unique_name_session UNIQUE (name);



ALTER TABLE academic_sessions ADD CONSTRAINT academic_sessions_pk PRIMARY KEY ( id );
ALTER TABLE courses ADD CONSTRAINT crs_pk PRIMARY KEY ( id );
ALTER TABLE exams ADD CONSTRAINT xam_pk PRIMARY KEY ( id );
ALTER TABLE faculties ADD CONSTRAINT fclt_pk PRIMARY KEY ( id );
ALTER TABLE faculty_course_details ADD CONSTRAINT fclt_crs_details_pk PRIMARY KEY ( crs_id,
                                                                                  fclt_id );
ALTER TABLE faculty_login_details ADD CONSTRAINT fclt_login_details_pk PRIMARY KEY ( fclt_id );
ALTER TABLE onlines ADD CONSTRAINT onlines_pk PRIMARY KEY ( lgn_id );
ALTER TABLE seateds
    ADD CONSTRAINT std_pk PRIMARY KEY ( bldn,
                                        room,
                                        date_time);
ALTER TABLE student_attendances ADD CONSTRAINT stu_attendances_pk PRIMARY KEY ( stu_id );
ALTER TABLE student_course_details ADD CONSTRAINT stu_crs_details_pk PRIMARY KEY ( stu_id,
                                                                                   crs_id );
ALTER TABLE students ADD CONSTRAINT stu_pk PRIMARY KEY ( id );
ALTER TABLE xam_results
    ADD CONSTRAINT xam_results_pk PRIMARY KEY ( crs_id,
                                                stu_id,
                                                xam_id );
ALTER TABLE xam_types ADD CONSTRAINT xam_types_pk PRIMARY KEY ( typ );




ALTER TABLE courses
    ADD CONSTRAINT crs_academic_sessions_fk FOREIGN KEY ( academic_sessions_id )
        REFERENCES academic_sessions ( id );

ALTER TABLE courses
    ADD CONSTRAINT crs_onlines_fk FOREIGN KEY ( onlines_lgn_id )
        REFERENCES onlines ( lgn_id );

ALTER TABLE courses
    ADD CONSTRAINT crs_std_fk FOREIGN KEY ( std_bld,
                                            std_room,
                                            date_time )
        REFERENCES seateds ( bldn,
                             room,
                             date_time );

ALTER TABLE faculty_course_details
    ADD CONSTRAINT fclt_crs_details_crs_fk FOREIGN KEY ( crs_id )
        REFERENCES courses ( id );

ALTER TABLE faculty_course_details
    ADD CONSTRAINT fclt_crs_details_fclt_fk FOREIGN KEY ( fclt_id )
        REFERENCES faculties ( id );

ALTER TABLE faculty_login_details
    ADD CONSTRAINT fclt_login_details_fclt_fk FOREIGN KEY ( fclt_id )
        REFERENCES faculties ( id );

ALTER TABLE student_attendances
    ADD CONSTRAINT stu_attend_acadm_sessions_fk FOREIGN KEY ( academic_sessions_id )
        REFERENCES academic_sessions ( id );

ALTER TABLE student_attendances
    ADD CONSTRAINT stu_attendances_stu_fk FOREIGN KEY ( stu_id )
        REFERENCES students ( id );

ALTER TABLE student_course_details
    ADD CONSTRAINT stu_crs_details_crs_fk FOREIGN KEY ( crs_id )
        REFERENCES courses ( id );

ALTER TABLE student_course_details
    ADD CONSTRAINT stu_crs_details_stu_fk FOREIGN KEY ( stu_id )
        REFERENCES students ( id );

ALTER TABLE xam_results
    ADD CONSTRAINT xam_results_crs_fk FOREIGN KEY ( crs_id )
        REFERENCES courses ( id );

ALTER TABLE xam_results
    ADD CONSTRAINT xam_results_stu_fk FOREIGN KEY ( stu_id )
        REFERENCES students ( id );

ALTER TABLE xam_results
    ADD CONSTRAINT xam_results_xam_fk FOREIGN KEY ( xam_id )
        REFERENCES exams ( id );

ALTER TABLE exams
    ADD CONSTRAINT xam_xam_types_fk FOREIGN KEY ( xam_types_typ )
        REFERENCES xam_types ( typ );
