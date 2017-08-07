SELECT 
    person_id,
    GROUP_CONCAT(DISTINCT (patient_identifier.identifier)) AS 'EMR ID',
    (SELECT DISTINCT
            (obs_datetime) AS treatment_start_date
        FROM
            obs
        WHERE
            obs.concept_id = (SELECT 
                    concept_id
                FROM
                    concept_name cn
                WHERE
                    cn.name LIKE '%TUBERCULOSIS DRUG TREATMENT START DATE%'
                        AND cn.voided = 0
                        AND cn.concept_name_type = 'FULLY_SPECIFIED')
                AND obs.voided = 0
                AND obs.person_id = patient_identifier.patient_id) AS 'Treatment start date',
    GROUP_CONCAT(IF(obs.concept_id = (SELECT 
                    concept_id
                FROM
                    concept_name cn
                WHERE
                    cn.name LIKE '%ti_patients_const_four_drug_regimen_not_possible%'
                        AND cn.voided = 0
                        AND cn.concept_name_type = 'FULLY_SPECIFIED')
                AND obs.voided = 0,
            value_coded,
            NULL)) AS indication_for_new_drugs_4_effective_drugs_not_possible_coded,
    GROUP_CONCAT(IF(obs.concept_id = (SELECT 
                    concept_id
                FROM
                    concept_name cn
                WHERE
                    cn.name LIKE '%ti_patients_const_four_drug_regimen_not_possible%'
                        AND cn.voided = 0
                        AND cn.concept_name_type = 'FULLY_SPECIFIED'),
            (SELECT 
                    name
                FROM
                    concept_name
                WHERE
                    concept_name.concept_id = obs.value_coded
                        AND concept_name_type = 'SHORT'
                        AND locale = 'en'
                        AND concept_name.voided = 0
                        AND obs.voided = 0),
            NULL)) AS indication_for_new_drugs_4_effective_drugs_not_possible,
    GROUP_CONCAT(IF(obs.concept_id = (SELECT 
                    concept_id
                FROM
                    concept_name cn
                WHERE
                    cn.name LIKE '%ti_oth_patient_high_risk_unfavourable%'
                        AND cn.voided = 0
                        AND cn.concept_name_type = 'FULLY_SPECIFIED')
                AND obs.voided = 0,
            value_coded,
            NULL)) AS indication_for_new_drugs_high_risk_of_unfavourable_outcome_coded,
    GROUP_CONCAT(IF(obs.concept_id = (SELECT 
                    concept_id
                FROM
                    concept_name cn
                WHERE
                    cn.name LIKE '%ti_oth_patient_high_risk_unfavourable%'
                        AND cn.voided = 0
                        AND cn.concept_name_type = 'FULLY_SPECIFIED'),
            (SELECT DISTINCT
                    name
                FROM
                    concept_name
                WHERE
                    concept_name.concept_id = obs.value_coded
                        AND concept_name_type = 'SHORT'
                        AND locale = 'en'
                        AND concept_name.voided = 0
                        AND obs.voided = 0),
            NULL)) AS indication_for_new_drugs_high_risk_of_unfavourable_outcome
FROM
    obs
        RIGHT JOIN
    patient_identifier ON obs.person_id = patient_identifier.patient_id
GROUP BY patient_identifier.identifier
ORDER BY patient_identifier.identifier;
