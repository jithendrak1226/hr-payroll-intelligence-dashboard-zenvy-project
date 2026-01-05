use zenvy_payroll;
create view payroll_analysis as
select
    e.employee_id,
    e.employee_name,
    e.department,
    e.designation,
    e.status,
    e.base_salary,

    a.month,
    a.working_days,
    a.present_days,
    a.overtime_hours,

    p.net_salary,
    p.overtime_pay,
    p.bonus,
    p.payment_date,

    case
        when e.status = 'exited' or a.present_days = 0 then 1
        else 0
    end as ghost_flag,

    case
        when a.overtime_hours > 30 then 1
        else 0
    end as overtime_abuse_flag

from employees e
left join attendance a
    on e.employee_id = a.employee_id
left join payroll p
    on e.employee_id = p.employee_id;
