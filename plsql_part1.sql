
--hello world

BEGIN
 dbms_output.put_line('Hello World');
 END;
 /
 
 --variable declaration
 
 DECLARE
 message VARCHAR2(20)
 := 'helloworld';
 
 BEGIN
 dbms_output.put_line(message);
 END;
 /
 
 --substitution variable -- user input
 
 BEGIN
  dbms_output.put_line('[' || '&input' || ']');
END;
/

--session variable/bind variable

VARIABLE bind_variable VARCHAR2(20);
BEGIN : bind_variable:='hello';
dbms_output.put_line('[' || :bind_variable || ']');
END;
/

--DATE

DECLARE
 daytime VARCHAR2(50);
  BEGIN
  daytime := TO_CHAR(sysdate,'yyyy-MM-ddth hh24:mi:ss');
  DBMS_OUTPUT.PUT_LINE(daytime);
   END;
 /
 
--SQL Query EXECUTE in PL SQL Block

DECLARE
 v_name VARCHAR2(20);
 
 BEGIN
  SELECT first_name into v_name FROM employees WHERE employee_id = 150;
  DBMS_OUTPUT.PUT_LINE(v_name);
  END;
  /
  
 2.
 
 DECLARE
 v_fname VARCHAR2(50);
 v_lname VARCHAR2(50);
 vn_employee_id VARCHAR2(50);
 
 BEGIN
 vn_employee_id:=150;
 
 SELECT first_name,last_name into v_fname,v_lname FROM employees WHERE employee_id = vn_employee_id;
  DBMS_OUTPUT.PUT_LINE(v_fname);
    DBMS_OUTPUT.PUT_LINE(v_lname);
 END;
 /
 --DECLARE variables using table datatype
 
 DECLARE
 lv_fname EMPLOYEES.FIRST_NAME%TYPE;
 lv_lname EMPLOYEES.LAST_NAME%TYPE;
 lv_hire_date EMPLOYEES.HIRE_DATE%TYPE;
 lv_commission_pct EMPLOYEES.COMMISSION_PCT%TYPE;
 lv_employee_id EMPLOYEES.EMPLOYEE_ID%TYPE;
 BEGIN
 lv_employee_id:=100;

 SELECT
  first_name,last_name,hire_date,commission_pct 
  INTO 
  lv_fname,lv_lname,lv_hire_date,lv_commission_pct 
  FROM employees WHERE employee_id  = 100;
  
  DBMS_OUTPUT.PUT_LINE(lv_fname || ' ' || lv_lname);
    DBMS_OUTPUT.PUT_LINE(lv_hire_date || ' ' || lv_commission_pct);

 END;
 /
 
 --DECLARE ALL TABLE DATA INTO ONE VARIABLE
 
 DECLARE
  vrec_emp EMPLOYEES%ROWTYPE;
  BEGIN
  vrec_emp.employee_id := 150;
  SELECT * 
  INTO vrec_emp
  FROM employees
  WHERE employee_id = vrec_emp.employee_id;
  
  DBMS_OUTPUT.PUT_LINE(vrec_emp.first_name || ' '
 || vrec_emp.last_name);

END;
/ 
 -- FInd the service in years of the senior employee who have attached to the department 90.
DECLARE
    lv_fname EMPLOYEES.FIRST_NAME%TYPE;
    lv_lname EMPLOYEES.LAST_NAME%TYPE;
    lv_syears INT;
BEGIN
    SELECT first_name, last_name, ROUND((SYSDATE - HIRE_DATE) / 365)
    INTO lv_fname, lv_lname, lv_syears
    FROM employees
    WHERE hire_date = (
        SELECT MIN(hire_date)
        FROM employees
    );

    dbms_output.put_line(lv_fname  || ' ' || lv_lname);
    dbms_output.put_line(lv_syears);
END;
/

--SQL Attributes

/*
1. ROWCOUNT - %ROWCOUNT
2. FOUND/ NOTFOUND - %FOUND / %NOTFOUND
*/


-- update department 10 employees name to SAM

BEGIN 
UPDATE EMPCOPYPL SET FIRST_NAME = 'SAM' WHERE DEPARTMENT_ID = 10;
DBMS_OUTPUT.PUT_LINE('Updated' || SQL%ROWCOUNT || '');
END;
/
 -- ROW COUNT is 1
 
BEGIN 
UPDATE EMPCOPYPL SET FIRST_NAME = 'SAM' WHERE DEPARTMENT_ID = 5000;
DBMS_OUTPUT.PUT_LINE('Updated' || SQL%ROWCOUNT || '');
END;
/

-- ROW COUNT is 0

 
BEGIN 
DBMS_OUTPUT.PUT_LINE('before' || SQL%ROWCOUNT);
DELETE FROM EMPCOPYPL WHERE EMPLOYEE_ID = 100;
DBMS_OUTPUT.PUT_LINE('deleted' || SQL%ROWCOUNT || '');
END;
/

-- ROW COUNT is 1



--IF THEN ELSE

BEGIN 
DBMS_OUTPUT.PUT_LINE('before' || SQL%ROWCOUNT);
DELETE
FROM EMPCOPYPL
WHERE EMPLOYEE_ID = 001;
DBMS_OUTPUT.PUT_LINE(SQL%ROWCOUNT);

IF SQL%FOUND THEN
DBMS_OUTPUT.put_line('inside if');
ELSE 
DBMS_OUTPUT.PUT_LINE('inside else');
END IF;

END;
/

BEGIN 
DBMS_OUTPUT.PUT_LINE('before' || SQL%ROWCOUNT);
DELETE
FROM EMPCOPYPL
WHERE EMPLOYEE_ID = 001;
DBMS_OUTPUT.PUT_LINE(SQL%ROWCOUNT);

IF SQL%NOTFOUND THEN
DBMS_OUTPUT.put_line('inside if');
ELSE 
DBMS_OUTPUT.PUT_LINE('inside else');
END IF;

END;
/

-- increase the salary of the employee with employee id 100 based on the following conditions
/*
salary > 7000 -> increase by 15%
salary > 5000 -> increase by 10%
salary > 2500 -> increase by 5%
otherwise increase by 2%

print first name,salary and updated salary of this employee
*/

DECLARE
    lv_fname EMPCOPYPL.FIRST_NAME%TYPE;
    lv_salary EMPCOPYPL.SALARY%TYPE;
	u_salary EMPCOPYPL.SALARY%TYPE;
    
BEGIN
    SELECT first_name,salary
    INTO lv_fname, lv_salary
    FROM EMPCOPYPL
    WHERE EMPLOYEE_ID=101;
	

IF lv_salary > 7000 THEN
 u_salary := lv_salary * 1.15;
 ELSIF lv_salary > 5000 THEN
 u_salary := lv_salary * 1.10;
 ELSIF lv_salary > 2500 THEN
 u_salary := lv_salary * 1.05;
 ELSE
 u_salary := lv_salary * 1.02;
 END IF;

 dbms_output.put_line(lv_fname  || ' ' || lv_salary || ' ' || u_salary );
    
END;
/

-- case STATEMENT




DECLARE
    lv_fname EMPCOPYPL.FIRST_NAME%TYPE;
    lv_salary EMPCOPYPL.SALARY%TYPE;
	u_salary EMPCOPYPL.SALARY%TYPE;
    
BEGIN
    SELECT first_name,salary
    INTO lv_fname, lv_salary
    FROM EMPCOPYPL
    WHERE EMPLOYEE_ID=101;

case
 WHEN lv_salary > 7000 THEN  u_salary := lv_salary * 1.15;
 WHEN lv_salary > 5000 THEN  u_salary := lv_salary * 1.10;
 WHEN lv_salary > 2500 THEN  u_salary := lv_salary * 1.05;
 ELSE u_salary := lv_salary * 1.02;
END case;

 dbms_output.put_line(lv_fname  || ' ' || lv_salary || ' ' || u_salary );
    
END;
/

--increase the salary of the employee with employee id 150 based on the following conditions:
/*
service > 25 --> increase salary by 25%
service > 20 --> salary 20%
service > 15 --> salary 15%
service > 10 --> salary 10%
otherwise 5%


*/




DECLARE
    lv_fname EMPCOPYPL.FIRST_NAME%TYPE;
    lv_salary EMPCOPYPL.SALARY%TYPE;
	u_salary EMPCOPYPL.SALARY%TYPE;
    lv_syears INT;
BEGIN
    SELECT first_name,salary, ROUND((SYSDATE - HIRE_DATE) / 365)
    INTO lv_fname, lv_salary, lv_syears
    FROM EMPCOPYPL WHERE EMPLOYEE_ID = 150;

case 
WHEN lv_syears > 25 THEN u_salary := lv_salary * 1.25;
WHEN lv_syears > 20 THEN u_salary := lv_salary * 1.20;
WHEN lv_syears > 15 THEN u_salary := lv_salary * 1.15;
WHEN lv_syears > 10 THEN u_salary := lv_salary * 1.10;
ELSE u_salary := lv_salary * 1.05;
END CASE;
    dbms_output.put_line(lv_fname || ' ' || lv_syears || ' ' || lv_salary || ' ' || u_salary);
    
END;
/
-- loops

DECLARE 
   x number := 1; 
BEGIN 
   LOOP 
      dbms_output.put_line(x); 
      x := x + 1; 
      IF x > 10 THEN 
         exit; 
      END IF; 
   END LOOP; 
   
END; 
/
-- star patterns with while LOOP

declare
n number:=5;
i number := 5;
j number := 5;
begin
for i in 1..n
loop
for j in 1..i
loop
dbms_output.put('*');
end loop;
dbms_output.new_line;
end loop;
end;
/

-- using while LOOP

DECLARE
    i INT;
    k INT;
BEGIN
    i := 10;
    WHILE i > 0
    LOOP
        k := 0;
        WHILE k < i
        LOOP
            dbms_output.put('*');
            k := k + 1;
        END LOOP;

        dbms_output.new_line;
        i := i - 1;
    END LOOP;
END;
/


-- EXAMPLE 11 :

BEGIN 
FOR x IN 1..10 LOOP
DBMS_OUTPUT.PUT_LINE(x);
END LOOP;
END;
/

BEGIN
 FOR x IN REVERSE 
 1..10 LOOP
 DBMS_OUTPUT.PUT_LINE(x);
 END LOOP;
 END;
 /


-- collections in PL/SQL

DECLARE 
 TYPE salary IS TABLE OF NUMBER
 INDEX BY VARCHAR2(20);
 salary_list salary;
 name VARCHAR2(20);
 counter NUMBER;
 
 BEGIN 
 --  adding elements to the TABLE
 
 salary_list('Rajnish') := 62000;
 salary_list('Minakshi') := 75000;
 salary_list('Martin') := 100000;
 salary_list('James') := 78000;
 counter := salary_list.COUNT;
 name := salary_list.FIRST; 
   WHILE name IS NOT null LOOP 
      dbms_output.put_line 
      ('Salary of ' || name || ' is ' || TO_CHAR(salary_list(name))); 
      name := salary_list.NEXT(name); 
   END LOOP; 
   dbms_output.put_line(counter);
END; 
/


-- example 2
/*
DECLARE
   TYPE typ_emp_det IS TABLE of EMPLOYEES.EMPLOYEE_ID%TYPE 
   INDEX BY BINARY_INTEGER;
   vrec_emp typ_emp_det;
   num BINARY_INTEGER;
   
   BEGIN
       vrec_emp(2):= 1995;
	   vrec_emp(5):= 1993;
	   vrec_emp(9) := 1986;
	   vrec_emp(21) := 2000;
	   vrec_emp(45) := 2018;
	   
	   num := vrec_emp.FIRST;
	   
	   WHILE vrec_emp IS NOT NULL LOOP
	   dbms_output.put_line(vrec_emp(num));
	   num := vrec_emp.NEXT(num);
	   
	   END LOOP;
	   
	   END;
	   /
	*/   
--method 1 --

DECLARE
	TYPE typ_emp IS TABLE OF EMPLOYEES%ROWTYPE INDEX BY BINARY_INTEGER;
	vtbl_employees typ_emp;
	v_index BINARY_INTEGER;
	
	min_employee_id EMPLOYEES.EMPLOYEE_ID%type;
	max_employee_id EMPLOYEES.EMPLOYEE_ID%type;
	
	vrec_employee EMPLOYEES%ROWTYPE;
BEGIN
	SELECT MIN(employee_id), MAX(employee_id)
	INTO min_employee_id, max_employee_id
	FROM employees
	ORDER BY employee_id;
	
	FOR i IN min_employee_id .. max_employee_id LOOP
		SELECT employee_id,first_name,last_name
		INTO vrec_employee
		FROM employees
		WHERE employee_id = i;
		
		vtbl_employees(i) := vrec_employee;
	END LOOP;
	
	v_index := vtbl_employees.first;
	WHILE v_index IS NOT NULL
	LOOP
		DBMS_OUTPUT.PUT_LINE(vtbl_employees(v_index).employee_id || ' ' || vtbl_employees(v_index).first_name || ' ' || vtbl_employees(v_index).last_name);
		
		v_index := vtbl_employees.next(v_index);
	END LOOP;
END;
/

--method 2
	
DECLARE
	TYPE typ_emp IS TABLE OF EMPLOYEES%ROWTYPE INDEX BY BINARY_INTEGER;
	vtbl_employees typ_emp;
	v_index BINARY_INTEGER;
	
	min_employee_id EMPLOYEES.EMPLOYEE_ID%type;
	max_employee_id EMPLOYEES.EMPLOYEE_ID%type;
	
	vrec_employee EMPLOYEES%ROWTYPE;
BEGIN
	SELECT MIN(employee_id), MAX(employee_id)
	INTO min_employee_id, max_employee_id
	FROM employees
	ORDER BY employee_id;
	
	FOR i IN min_employee_id .. max_employee_id LOOP
		SELECT employee_id,first_name,last_name
		INTO vtbl_employees(i).employee_id,vtbl_employees(i).first_name,vtbl_employees(i).last_name
		FROM employees
		WHERE employee_id = i;
		
		
	END LOOP;
	
	v_index := vtbl_employees.first;
	WHILE v_index IS NOT NULL
	LOOP
		DBMS_OUTPUT.PUT_LINE(vtbl_employees(v_index).employee_id || ' ' || vtbl_employees(v_index).first_name || ' ' || vtbl_employees(v_index).last_name);
		
		v_index := vtbl_employees.next(v_index);
	END LOOP;
END;
/

-- CURSOR - acting like a pointer

-- declare a CURSOR
-- open STATEMENT
-- fetch statment
-- close STATEMENT

-- example 1 output 1st record
DECLARE
 CURSOR cur_emp IS 
 SELECT employee_id,first_name FROM employees;
 vn_id EMPLOYEES.EMPLOYEE_ID%TYPE;
 vn_name EMPLOYEES.FIRST_NAME%TYPE;
 
BEGIN 
 OPEN cur_emp;
 FETCH cur_emp INTO vn_id,vn_name;
 DBMS_OUTPUT.PUT_LINE(vn_id || ' ' || vn_name);
 CLOSE cur_emp;
 END;
/

--example 2 fetch all using LOOP

DECLARE
 CURSOR cur_emp IS 
 SELECT employee_id,first_name FROM employees;
 vn_id EMPLOYEES.EMPLOYEE_ID%TYPE;
 vn_name EMPLOYEES.FIRST_NAME%TYPE;
 vn_min EMPLOYEES.EMPLOYEE_ID%TYPE;
 vn_max EMPLOYEES.EMPLOYEE_ID%TYPE;
 
 
BEGIN 
 OPEN cur_emp;
 SELECT MIN(employee_id),MAX(employee_id)INTO vn_min,vn_max FROM employees ;
 FOR i IN vn_min..vn_max LOOP
 FETCH cur_emp INTO vn_id,vn_name;
 DBMS_OUTPUT.PUT_LINE(vn_id || ' ' || vn_name);
 END LOOP;
 CLOSE cur_emp;
 END;
/

-- example 3 fetch all records using not found


DECLARE

 CURSOR cur_emp IS 
 SELECT employee_id,first_name FROM employees;
 vn_id EMPLOYEES.EMPLOYEE_ID%TYPE;
 vn_name EMPLOYEES.FIRST_NAME%TYPE;
 
 BEGIN
 
  OPEN cur_emp;
  LOOP
  FETCH cur_emp INTO vn_id,vn_name;
  EXIT WHEN cur_emp%NOTFOUND;
 DBMS_OUTPUT.PUT_LINE(vn_id || ' ' || vn_name);
  END LOOP;
  
  END;
  /
  
  -- explicit cursor usage 
  
  DECLARE
  REC  EMPLOYEES%ROWTYPE;
  cursor emp_cur IS SELECT * FROM employees; 
BEGIN
  FOR rec IN emp_cur LOOP
    SYS.DBMS_OUTPUT.PUT_LINE(REC.EMPLOYEE_ID || ' ' ||  REC.FIRST_NAME   );
  END LOOP;
END;
/

-- cursor example 
/*  employee_id,first_name,salary,new_salary,service

if service > 25,new salary is increased by 30% 
if service > 20, new salary by 20%
if new salary is increased by 10%

*/


DECLARE 
  -- REC  EMPLOYEES%ROWTYPE;
  cursor emp_cur IS SELECT EMPLOYEE_ID,FIRST_NAME,SALARY,(ROUND(SYSDATE - hire_date) / 365) AS service, (
			CASE
				WHEN (ROUND(SYSDATE - hire_date) / 365) > 25
					THEN salary * 1.30
				WHEN (ROUND(SYSDATE - hire_date) / 365) > 20
					THEN salary * 1.20
				ELSE salary * 1.10
			END) AS new_salary
  FROM employees; 
  TYPE typ_emp IS TABLE OF emp_cur%ROWTYPE INDEX BY BINARY_INTEGER;
	vtbl_employees typ_emp;
	
	v_index BINARY_INTEGER;
  
  BEGIN
    FOR rec IN emp_cur LOOP
	 vtbl_employees(rec.employee_id) := rec;
	 
	END LOOP;
	
	FOR X IN vtbl_employees.FIRST..vtbl_employees.LAST LOOP
	DBMS_OUTPUT.PUT_LINE(vtbl_employees(X).employee_id || ' ' || vtbl_employees(X).first_name || ' ' || vtbl_employees(X).salary || ' ' || vtbl_employees(X).service || ' ' || vtbl_employees(X).new_salary);
	END LOOP;
	
END;
/

  
DECLARE
	CURSOR cur_emp (p_dept_id INT) IS
		SELECT employee_id, first_name
		FROM employees
		WHERE department_id = p_dept_id;
	
	vn_emp_id EMPLOYEES.employee_id%TYPE;
	vn_emp_first_name EMPLOYEES.first_name%TYPE;
BEGIN
	OPEN cur_emp(100);
	
	LOOP
		FETCH cur_emp
		INTO vn_emp_id, vn_emp_first_name;
		
		EXIT WHEN cur_emp%NOTFOUND;
		
		dbms_output.put_line(vn_emp_id || ' ' || vn_emp_first_name);
	END LOOP;
	
	CLOSE cur_emp;
END;
/



DECLARE
	CURSOR cur_emp (p_dept_id INT) IS
		SELECT employee_id, first_name
		FROM employees
		WHERE department_id = p_dept_id;
BEGIN
	FOR vn_emp IN cur_emp(100)
	LOOP
		dbms_output.put_line(vn_emp.employee_id || ' ' || vn_emp.first_name);
	END LOOP;
END;
/



DECLARE
	CURSOR cur_emp IS
		SELECT UNIQUE department_id
		FROM employees
		WHERE ROUND((SYSDATE - HIRE_DATE) / 365) >= 25;
	CURSOR cur_dept (p_dept_id INT) IS
		SELECT department_name
		FROM departments
		WHERE department_id = p_dept_id;
		
	vn_dept_name DEPARTMENTS.DEPARTMENT_NAME%TYPE;
BEGIN
	FOR vn_emp IN cur_emp
	LOOP
		OPEN cur_dept(vn_emp.department_id);
		
		FETCH cur_dept
		INTO vn_dept_name;
		
		dbms_output.put_line(vn_dept_name);
		
		CLOSE cur_dept;
	END LOOP;
END;
/



DECLARE
	CURSOR cur_emp IS
		SELECT department_id, employee_id
		FROM employees
		WHERE ROUND((SYSDATE - HIRE_DATE) / 365) >= 25;
	CURSOR cur_dept (p_dept_id INT) IS
		SELECT department_name
		FROM departments
		WHERE department_id = p_dept_id;
		
	vn_dept_name DEPARTMENTS.DEPARTMENT_NAME%TYPE;
BEGIN
	FOR vn_emp IN cur_emp
	LOOP
		OPEN cur_dept(vn_emp.department_id);
		
		FETCH cur_dept
		INTO vn_dept_name;
		
		dbms_output.put_line(vn_dept_name || ' ' || vn_emp.employee_id);
		
		CLOSE cur_dept;
	END LOOP;
END;
/



DECLARE
	vc_fname EMPLOYEES.FIRST_NAME%TYPE;
BEGIN
	BEGIN
		SELECT first_name
		INTO vc_fname
		FROM EMPLOYEES
		WHERE employee_id = 1500;
		
		dbms_output.put_line(vc_fname);
		
		EXCEPTION
			WHEN NO_DATA_FOUND THEN
				dbms_output.put_line('Employee does not exist');
			WHEN OTHERS THEN
				dbms_output.put_line('In Others');
	END;

	BEGIN
		SELECT first_name
		INTO vc_fname
		FROM employees
		WHERE department_id = 80;
		
		EXCEPTION
			WHEN TOO_MANY_ROWS THEN
				dbms_output.put_line('Too many rows to a single value');
			WHEN OTHERS THEN
				dbms_output.put_line('In Others');
	END;
END;
/  
  
DECLARE
 e_emp_remaining EXCEPTION;
 
 PRAGMA EXCEPTION_INIT(e_emp_remaining,-02292);
 
 BEGIN
 
 DELETE FROM departments
 WHERE department_id = &enterdept;
 COMMIT;
 EXCEPTION
 WHEN e_emp_remaining THEN
  DBMS_OUTPUT.PUT_LINE('Cannot remove department');
  DBMS_OUTPUT.PUT_LINE('displaying sql code relevent to EXCEPTION :' || SQLCODE);
  DBMS_OUTPUT.PUT_LINE('displaying sql message relevent to EXCEPTION : ' || SQLERRM);
  DBMS_OUTPUT.PUT_LINE('displaying sql user relevent to :' || USER);
  DBMS_OUTPUT.PUT_LINE('displaying sql date relevent to EXCEPTION:'|| SYSDATE);
  
  END;
  /
  
  DECLARE
  invalid_salary EXCEPTION;
 CURSOR cur_emp IS 
 SELECT employee_id,first_name,salary,(salary + 1500) AS new_salary FROM employees;

BEGIN 
 FOR rec IN cur_emp LOOP
 BEGIN
    IF rec.new_salary > 4000
	THEN
	RAISE invalid_salary;
	ELSE
	DBMS_OUTPUT.PUT_LINE(rec.new_salary);
	END IF;
	 EXCEPTION WHEN invalid_salary THEN
  DBMS_OUTPUT.PUT_LINE('invalid_salary');
  END;
  END LOOP;
 
 END;
/


-- CREATE TABLE EMPUPDATE AS SELECT * FROM EMPLOYEES;

-- the salary of employee with employee id 100 should be updated as 5000 if the updated salary is 
-- less than the existing salary, else give an EXCEPTION


DECLARE 
   less_salary EXCEPTION;
   updated_salary EMPLOYEES.salary%TYPE;
   existing_salary EMPLOYEES.salary%TYPE;
   
   BEGIN
   SELECT salary INTO existing_salary FROM EMPUPDATE WHERE EMPLOYEE_ID = 100;
   IF existing_salary < 5000 THEN
   UPDATE EMPUPDATE SET salary = 5000 WHERE EMPLOYEE_ID = 100;
   DBMS_OUTPUT.PUT_LINE('GREATER SALARY');
   ELSE
   RAISE less_salary;
   END IF;
    EXCEPTION WHEN less_salary THEN 
	DBMS_OUTPUT.PUT_LINE('LESS SALARY');
 END;
 /

DECLARE 
department_pk_violation EXCEPTION;
PRAGMA EXCEPTION_INIT(department_pk_violation,-00001);

vn_dept_name DEPARTMENTS.DEPARTMENT_NAME%TYPE;

BEGIN 

SELECT department_name INTO vn_dept_name FROM DEPARTMENTS WHERE DEPARTMENT_NAME = 'Management';

EXCEPTION WHEN NO_DATA_FOUND THEN 
BEGIN 
INSERT INTO DEPARTMENTS VALUES (80,'Management',100,1700);
EXCEPTION WHEN department_pk_violation THEN 
DBMS_OUTPUT.PUT_LINE('PK VIOLATION');
END;

END;
/

CREATE OR REPLACE PROCEDURE pro1 AS 
 emp_id NUMBER;
 fname employees.first_name%TYPE;
 lname employees.last_name%TYPE;
 
 BEGIN 
 SELECT employee_id,first_name,last_name INTO emp_id,fname,lname FROM EMPLOYEES WHERE employee_id = '206';
 
 DBMS_OUTPUT.PUT_LINE(emp_id);
 DBMS_OUTPUT.PUT_LINE(fname);
 DBMS_OUTPUT.PUT_LINE(lname);
 
 END;
 /



//PROCEDURES

CREATE OR REPLACE PROCEDURE procedure_name(parameter_list) IS
[declaration statements]
BEGIN
[execution_statements]
EXCEPTION
[exception_handeling]
END;
/


EXAMPLE 1

CREATE OR REPLACE PROCEDURE PRO2 AS 

EMP_ID NUMBER;
FNAME EMPLOYEES.FIRST_NAME%TYPE;
LNAME EMPLOYEES.LAST_NAME%TYPE;

BEGIN
 SELECT EMPLOYEE_ID,FIRST_NAME,LAST_NAME
 INTO EMP_ID,FNAME,LNAME FROM EMPLOYEES
 WHERE EMPLOYEE_ID='206';
 
 DBMS_OUTPUT.PUT_LINE(EMP_ID);
 DBMS_OUTPUT.PUT_LINE(FNAME);
 DBMS_OUTPUT.PUT_LINE(LNAME);
 
 END;
 /
 
 EXECUTE PRO2();
 
 
 CREATE OR REPLACE PROCEDURE PRO3 AS
 
 EMP_ID NUMBER;
 FNAME EMPLOYEES.FIRST_NAME%TYPE;
 LNAME EMPLOYEES.LAST_NAME%TYPE;
 
 BEGIN
 
 EMP_ID:=100;
 WHILE EMP_ID < 207 LOOP
     SELECT FIRST_NAME,LAST_NAME
	 INTO FNAME,LNAME
	 FROM EMPLOYEES
	 WHERE EMPLOYEE_ID=EMP_ID;
	 
	 DBMS_OUTPUT.PUT_LINE(EMP_ID);
	 DBMS_OUTPUT.PUT_LINE(FNAME || ' ' || LNAME);
	 DBMS_OUTPUT.PUT_LINE('_____________');
	 EMP_ID:=EMP_ID+1;
	 
	 
	 END LOOP;
	 
	 END;
	 /
	 
	 
	 
CREATE OR REPLACE PROCEDURE PRO4 IS

SELECT * FROM EMPLOYEES;

BEGIN
 FOR EMP_REC IN CUR_EMP
 LOOP 
 DBMS_OUTPUT.PUT_LINE(EMP_REC.FIRST_NAME || ' ' || EMP_REC.LAST_NAME || ' ' || EMP_REC.DEPARTMENT_ID);
 END LOOP;
 
 END;
 /
 
 CREATE OR REPLACE PROCEDURE pro5 AS
    CURSOR cur_emp IS
        (SELECT first_name, last_name, department_id
        FROM employees);

    v_first_name EMPLOYEES.FIRST_NAME%TYPE;
    v_last_name EMPLOYEES.LAST_NAME%TYPE;
    v_dept_id EMPLOYEES.DEPARTMENT_ID%TYPE;
BEGIN
    OPEN cur_emp;

    LOOP
        FETCH cur_emp INTO v_first_name, v_last_name, v_dept_id;

        DBMS_OUTPUT.PUT_LINE(v_first_name  ' '  v_last_name  ' '  v_dept_id);

        IF cur_emp%NOTFOUND THEN
            EXIT;
        END IF;
    END LOOP;

    CLOSE cur_emp;
END;
/


CREATE OR REPLACE PROCEDURE PROC_GETSERVICE(P_HIREDATE DATE) IS
 VD_HIREDATE DATE;
 VN_SERVICE NUMBER;
 
 BEGIN
 VD_HIREDATE := P_HIREDATE;
 VN_SERVICE := TRUNC((SYSDATE - VD_HIREDATE)/365);
 DBMS_OUTPUT.PUT_LINE(VN_SERVICE);
 END;
 /

CREATE OR REPLACE PROCEDURE PROC_GETSERVICE (P_HIREDATE DATE, P_SERVICE OUT NUMBER) IS 
VD_HIREDATE DATE;
VN_SERVICE NUMBER;

BEGIN 
VD_HIREDATE := P_HIREDATE;
VN_SERVICE:=TRUNC((SYSDATE-VD_HIREDATE)/365);
DBMS_OUTPUT.PUT_LINE(VN_SERVICE);
P_SERVICE := VN_SERVICE;
END;
/
DECLARE 
 VN_SERVICE NUMBER;
 BEGIN
  PROC_GETSERVICE('23-MAY-1995',VN_SERVICE);
  DBMS_OUTPUT.PUT_LINE(VN_SERVICE);
  END;
  /
