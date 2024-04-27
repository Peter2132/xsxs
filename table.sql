create table Teachers(
	ID_Teacher serial primary key,
	Surname varchar(30) not null,
	FirstName varchar(30) not null,
	MiddleName varchar(30)
);

create table Students(
	ID_Student serial constraint PK_Student primary key,
	Surname varchar(30) not null,
	FirstName varchar(30) not null,
	MiddleName varchar(30) default('-'),
	Age int not null
);



CREATE TABLE Courses(
	ID_Course serial PRIMARY KEY ,
	Title VARCHAR (50) NOT NULL,
	DescriptionCourses TEXT,
	Teacher_ID INT NOT NULL,
	FOREIGN KEY (Teacher_ID) REFERENCES Teachers(ID_Teacher)
);


CREATE TABLE StudentsCourses(
	ID_StudentsCourses serial PRIMARY KEY ,
	Student_ID INT NOT NULL REFERENCES Students(ID_Student),
	Course_ID INT NOT NULL REFERENCES Courses(ID_Course)
);


CREATE TABLE StudentCards(
	ID_StudentCards serial PRIMARY KEY,
	Number1 INT NOT NULL,
	Date1 DATE,
	Year1 INT NOT NULL,
	FOREIGN KEY(ID_StudentCards) REFERENCES Students(ID_Student)
);

Alter table Teachers
add OPBD varchar(30);

ALTER TABLE Teachers
ALTER COLUMN OPBD SET DATA TYPE INT USING OPBD::INT;

ALTER TABLE Teachers
ALTER COLUMN OPBD SET NOT NULL;

ALTER TABLE Teachers RENAME TO REPODS;

ALTER TABLE REPODS RENAME COLUMN OPBD TO TEST;

insert into Teachers (Surname, FirstName, MiddleName)
values
('Kirill','Oppov','Pokov');

select * from teachers
update teachers set middlename = 'petrovich' 
where id_teacher = 1;

delete from teachers where id_teacher = 2;

insert into repods(surname, firstname, middlename,test)
values
('grigor','grigorivesh','grigor',1),
('atrtemov','artemovich','artem',1),
('fref','fd','fd',1);
select * from repods;
insert into students(surname, firstname, middlename, age)
values
('DGDGG','JJJ','dcec', 23),
('rr','r','rrr',29),
('cwecw','cw','cd',24),
('xxx','xx','x',20),
('a','aa','aaa',26);

select * from teachers;

alter table courses
alter column teacher_id drop not null;

insert into courses(title, teacher_id)
values
('C#',5),
('Python',3),
('SQL',null);

select * from students;
select * from courses;

alter table studentscourses
alter column student_id drop not null;

alter table studentscourses
alter column course_id drop not null;

insert into studentscourses(course_id, student_id)
values
(22,2),
(22,null),
(23,5),
(null,1);


select students.surname, courses.title, repods.firstname, repods.middlename,repods.firstname
from studentscourses
left join students on studentscourses.student_id = students.id_student
left join courses on studentscourses.course_id = courses.id_course
left join repods on courses.teacher_id = repods.id_teacher;

select students.surname, courses.title, repods.firstname, repods.middlename,repods.firstname
from studentscourses
right join students on studentscourses.student_id = students.id_student
right join courses on studentscourses.course_id = courses.id_course
right join repods on courses.teacher_id = repods.id_teacher;

select students.surname, courses.title, repods.firstname, repods.middlename,repods.firstname
from studentscourses
full join students on studentscourses.student_id = students.id_student
full join courses on studentscourses.course_id = courses.id_course
full join repods on courses.teacher_id = repods.id_teacher;



