/*Questão 01. Crie um procedimento chamado student_grade_points segundo os critérios abaixo:

a. Utilize como parâmetro de entrada o conceito. Exemplo: A+, A-, ...

b. Retorne os atributos das tuplas: Nome do estudante, Departamento do estudante, Título do curso, Departamento do curso, Semestre do curso, Ano do curso, Pontuação alfanumérica, Pontuação numérica.

c. Filtre as tuplas utilizando o parâmetro de entrada.*/
CREATE PROCEDURE student_grade_points
  /*a.*/
    @grade VARCHAR(2)
AS
BEGIN
  /*b.*/
    SELECT
        s.name AS student_name,
        s.dept_name AS student_dept,
        c.title AS course_title,
        c.dept_name AS course_dept,
        t.semester,
        t.year,
        t.grade AS alphanumeric_grade,
        CASE t.grade
            WHEN 'A+' THEN 4.3
            WHEN 'A' THEN 4.0
            WHEN 'A-' THEN 3.7
            WHEN 'B+' THEN 3.3
            WHEN 'B' THEN 3.0
            WHEN 'B-' THEN 2.7
            WHEN 'C+' THEN 2.3
            WHEN 'C' THEN 2.0
            WHEN 'C-' THEN 1.7
            WHEN 'D' THEN 1.0
            WHEN 'F' THEN 0.0
            ELSE NULL
        END AS numeric_grade
    FROM takes t
    JOIN student s ON t.ID = s.ID
    JOIN course c ON t.course_id = c.course_id
    WHERE t.grade = @grade
END;

/*Execução do procedimento filtrado por meio do parâmetro*/
EXEC student_grade_points 'A+';
EXEC student_grade_points 'A';
EXEC student_grade_points 'A-';
EXEC student_grade_points 'B+';
EXEC student_grade_points 'B';
EXEC student_grade_points 'B-';
EXEC student_grade_points 'C+';
EXEC student_grade_points 'C';
EXEC student_grade_points 'C-';
EXEC student_grade_points 'D';
EXEC student_grade_points 'F';

/*Questão 02.

Crie uma função chamada return_instructor_location segundo os critérios abaixo:

a. Utilize como parâmetro de entrada o nome do instrutor.

b. Retorne os atributos das tuplas: Nome do instrutor, Curso ministrado, Semestre do curso, Ano do curso, prédio e número da sala na qual o curso foi ministrado

c. Exemplo: SELECT * FROM dbo.return_instructor_location('Gustafsson');*/
CREATE FUNCTION return_instructor_location (
  /*a.*/
    @instructor_name VARCHAR(100)
)
RETURNS TABLE
AS 
  /*b.*/
RETURN (
    SELECT
        i.name AS instructor_name,
        c.title AS course_title,
        s.semester,
        s.year,
        s.building,
        s.room_number
    FROM instructor i
    JOIN teaches t ON i.ID = t.ID
    JOIN section s ON t.course_id = s.course_id AND t.sec_id = s.sec_id AND t.semester = s.semester AND t.year = s.year
    JOIN course c ON t.course_id = c.course_id
    WHERE i.name = @instructor_name
);

-- c.
SELECT * FROM dbo.return_instructor_location('Gustafsson');
