SELECT 
    pi.patient_id,
    p.gender,
    p.birthdate,
    FLOOR(DATEDIFF(CURDATE(), p.birthdate) / 365) AS age,
    CONCAT(10 * FLOOR(FLOOR(DATEDIFF(CURDATE(), p.birthdate) / 365) / 10),
            '-',
            10 * FLOOR(FLOOR(DATEDIFF(CURDATE(), p.birthdate) / 365) / 10) + 10) AS age_range
FROM
    person p
        INNER JOIN
    patient_identifier pi ON pi.patient_id = p.person_id;
