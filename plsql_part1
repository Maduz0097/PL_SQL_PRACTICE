
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
