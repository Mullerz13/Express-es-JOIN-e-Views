select * from student s join takes t on s.id = t.id;
/*seleciona o nome dos alunos, o nome do curso, o ano em que foi feito, o semestre e a nota alcançada, a união é feita 
com base no id dos alunos que realizaram determinado do curso e a tabela exibida está ordenada pelo ano de maneira ascendente
isto é, do menor para o maior */
select name, dept_name, year, semester, grade from student s join takes t on s.id = t.id order by year asc;

/*seleciona o id do aluno, seu nome e a quantidade de cursos que realiza, nomeando-a como "Quantidade de cursos"
 especifica o alvo da seleção, nesse caso a tabela student unida a tabela takes de maneira em que o id do estudante seja igual o presente na tabela takes
 a seleção se limita aos registros onde o nome do departamento é Civil Eng.
 Os registros são agrupados pelo id e nome (todos os registros cujo id e nome se equivalem)
 e por fim são ordenados pela quantidade de cursos do maior para o menor por meio do comando desc*/
select s.id, name, count(course_id) as Quantidade_de_cursos
from student s 
join takes t on s.id = t.id 
where dept_name = 'Civil Eng.' 
group by s.id, name
order by  Quantidade_de_cursos desc; 

/*Criação da visão civil_eng_students segue o mesmo conceito da explicação anterior
 * seleciona-se o id do aluno, o nome e a quantidade de cursos que fazem  */
create view civil_eng_students as select s.id, name, count(course_id) as Qtd_cursos
from student s 
join takes t on s.id = t.id 
where dept_name = 'Civil Eng.' 
group by s.id, name;

select * from civil_eng_students;