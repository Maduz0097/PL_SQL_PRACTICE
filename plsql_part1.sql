
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
