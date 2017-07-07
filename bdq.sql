select patient_id, date_activated, scheduled_date, auto_expire_date, date_stopped, concept_id
from orders where concept_id=1251 and voided=0;
