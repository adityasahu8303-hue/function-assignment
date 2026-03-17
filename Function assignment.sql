USE subquery;
Create Table Student_performance (
student_id INT PRIMARY KEY,
name VARCHAR(50), 
course VARCHAR(30),
score INT,
attendance INT,
mentor VARCHAR(50),
join_date DATE,
city VARCHAR(50)
);

INSERT INTO Student_performance(student_id, name, course, score, attendance, mentor, join_date, city)
VALUES
(101, "Aarav Mehta", "Data science", 88, 92, "Dr. Sharma", "2023-06-12", "Mumbai"),
(102, "Riya Singh", "Data science", 76, 85, "Dr. Sharma", "2023-07-01", "Delhi"),
(103, "Kabir Khanna", "Python", 91, 96, "Ms. Nair", "2023-06-20", "Mumbai"),
(104, "Tanvi Patel", "SQL", 84, 89, "Mr.Iyer", "2023-05-30", "Bengaluru"),
(105, "Ayesha Khan", "Python", 67, 81, "Ms. Nair", "2023-07-10", "Hderabad"),
(106, "Dev Sharma", "SQL", 73, 78, "Mr. Iyer", "2023-05-28", "Pune"),
(107, "Arjun Verma", "Tableau", 95, 98, "Ms. Kanpoor", "2023-06-15", "Delhi"),
(108, "Meera pillai", "Tableau", 82, 87, "Ms. Kapoor", "2023-06-18", "Kochi"),
(109, "Nikhil Rao", "Data science", 79, 82, "Dr. Sharma", "2023-07-05", "Chennai"),
(110, "Priya Desai", "SQL", 92, 94, "Mr. Iyer", "2023-05-27", "Bengaluru"),
(111, "Siddharth Jain", "Python", 85, 90, "Ms. Nair", "2023-07-02", "Mumbai"),
(112, "Sneha Kulkarni", "Tableau", 74, 83, "Ms. Kapoor", "2023-06-10", "Pune"),
(113, "rohan Gupta", "SQl", 89, 91, "Mr. Iyer", "2023-05-25", "Delhi"),
(114, "Ishita Joshi", "Data Science", 93, 97, "Dr. Sharma", "2023-06-25", "Bengaluru"),
(115, "Yuvraj Rao", "Python", 71, 84, "Ms. Nair", "2023-07-12", "Hyderabad");

Select * from student_performance;

## Question 1 : Create a ranking of students based on score (highest first).
select Student_id, name, course, 
rank() over(order by score desc) as score_rank,
score
from student_performance;

##Question 2 : Show each student's score and the previous student’s score (based on score order)
Select 
name, 
lag(score) over(order by score DESC ) as previous_score,
score from student_performance;

##Question 3 : Convert all student names to uppercase and extract the month name from join_date.
Select name, upper(name) as cap_letter,
monthname(join_date) as monthg_name
from student_performance;

## Question 4 : Show each student's name and the next student’s attendance (ordered by attendance).
Select name,
attendance,
lead(attendance) Over (Order by attendance DESC) as next_attendance
from student_performance;

##Question 5 : Assign students into 4 performance groups using NTILE().
Select name, score,
NTILE(4) OVER(ORDER BY score DESC) AS performance_group
from student_performance;

##Question 6 : For each course, assign a row number based on attendance (highest first).

Select name, 
course, 
attendance,
row_number() over(PARTITION BY  course order by attendance DESC) AS row_num
from student_performance;

## Question 7 : Calculate the number of days each student has been enrolled (from join_date to today).(Assume current date = '2025-01-01')
Select name,
join_date,
datediff( "2025-01-01", join_date) as enrolled_day
from student_performance;

##Question 8 : Format join_date as “Month Year” (e.g., “June 2023”).
Select name,
date_format(join_date, "%M %Y")as format_date
from student_performance;

##Question 9 : Replace the city ‘Mumbai’ with ‘MUM’ for display purposes.
select name,
CASE 
WHEN CITY="Mumbai" THEN "Mum"
ELSE CITY
END AS city
from student_performance;

##Question 10 : For each course, find the highest score using FIRST_VALUE().
select name, course,
score,
first_value(score) OVER(Partition by course ORDER BY score DESC) as highest_score
from student_performance;