SELECT 
    person_id,
    concept_id,
    (SELECT 
            name
        FROM
            concept_name cn
        WHERE
            cn.concept_id = o.concept_id
                AND cn.concept_name_type = 'SHORT'
                AND cn.locale = 'en'
                AND cn.voided = 0) AS sit_qn,
    obs_datetime,
    value_coded,
    (SELECT 
            name
        FROM
            concept_name cn
        WHERE
            cn.concept_id = o.value_coded
                AND cn.concept_name_type = 'SHORT'
                AND cn.locale = 'en'
                AND cn.voided = 0) AS sit_ans
FROM
    obs o
WHERE
    concept_id = (SELECT 
            concept_id
        FROM
            concept_name
        WHERE
            name LIKE '% What is the situation of the patient%')
        AND voided = 0;
