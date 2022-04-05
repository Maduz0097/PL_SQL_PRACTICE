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