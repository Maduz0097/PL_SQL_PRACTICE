
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
		SELECT *
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


 	
	
