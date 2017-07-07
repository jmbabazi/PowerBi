SELECT 
    pi.patient_id AS 'ID',
    pi.identifier AS 'EMR ID',
    p.gender AS 'Gender',
    floor(datediff(now(), p.birthdate)/365) AS Age,
    DATE(o.obs_datetime) AS 'Treatment start date'
FROM
    patient_identifier pi
        JOIN
    person p ON pi.patient_id = p.person_id
JOIN obs o ON o.person_id=pi.patient_id and o.concept_id=1210 
and pi.voided=0 and p.voided=0 and o.voided=0
order by o.obs_datetime;
