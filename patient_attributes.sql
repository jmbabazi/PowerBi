SELECT pi.patient_id AS 'ID', pi.identifier AS 'EMR ID', p.gender AS 'Gender' from patient_identifier pi join person p on pi.patient_id=p.person_id;
