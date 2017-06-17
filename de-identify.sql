UPDATE patient_identifier SET identifier = REPLACE(identifier, 'SO', 'bi') WHERE identifier LIKE '%SO-%';
