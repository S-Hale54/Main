1.a - What is the value of "weight" at position 1?

	2

1.b - What is the value of "new_locn" at position 1?
	
	Western Europe

1.c - What is the value of "weight" at position 2?

	601

1.d - What is the value of "message" at position 2?

	Product 10012 is in stock



2.a - Why does the inner block display the job_id of employee 103, not employee 100?

	The variable job_id is declared again in the inner block and set to 103. Its scope does not reach the outer block 
	where the variable holds a value of 100. 

2.b - Why does the outer block display the job_id of employee 100, not employee 103?

	The variable job_id in the outer block is set to 100 on lines 5-7. It does not change as the program executes because
	another variable with the same name is declared in the inner block.



--3. Modify the code from exercise 2 to display the details of employee 100 in the inner block.

	<<outer_block>>
DECLARE
    v_employee_id dbms_labs.employees.employee_id%TYPE;
    v_job dbms_labs.employees.job_id%TYPE;
BEGIN
    SELECT employee_id, job_id INTO v_employee_id, v_job
    FROM dbms_labs.employees
    WHERE employee_id = 103;
        <<inner_block>>
        DECLARE
            v_employee_id dbms_labs.employees.employee_id%TYPE;
            v_job dbms_labs.employees.job_id%TYPE;
            
            BEGIN
                SELECT employee_id, job_id INTO v_employee_id, v_job
                FROM dbms_labs.employees
                WHERE employee_id = 100;
                
                DBMS_OUTPUT.PUT_LINE(v_employee_id || ' is a(n) ' || v_job);
            END;
    
    DBMS_OUTPUT.PUT_LINE(v_employee_id || ' is a(n) ' || v_job);
END;