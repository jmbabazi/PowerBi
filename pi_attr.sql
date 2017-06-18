 SELECT 
    pi.patient_id AS 'ID',
    pi.identifier AS 'EMR ID',
    p.gender AS 'Gender',
    FLOOR(DATEDIFF(NOW(), p.birthdate) / 365) AS Age,
    DATE(o.obs_datetime) AS 'Treatment start date',
    o1.value_coded
FROM
    patient_identifier pi
        JOIN
    person p ON pi.patient_id = p.person_id
        JOIN
    obs o ON o.person_id = pi.patient_id
        AND o.concept_id = 1210
        INNER JOIN
    obs o1 ON o1.person_id = pi.patient_id
        AND o1.concept_id = 2264
        AND o1.voided = 0
        AND pi.voided = 0
        AND p.voided = 0
        AND o.voided = 0
ORDER BY o.obs_datetime;
