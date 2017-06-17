SELECT 
    pi.patient_id AS 'ID',
    pi.identifier AS 'EMR ID',
    p.gender AS 'Gender'
FROM
    patient_identifier pi
        JOIN
    person p ON pi.patient_id = p.person_id;
