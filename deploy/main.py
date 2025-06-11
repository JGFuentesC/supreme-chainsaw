import pandas as pd
import pickle
from flask import jsonify

lr = pickle.load(open('lr.pkl', 'rb'))

def get_proba(data:dict)->float:
    column_mapping = {
    'customerServiceCalls': 'V_CS_CALLS',
    'totalDayCharges': 'V_T_DAY_CHG',
    'totalInternationalCharges': 'V_T_INT_CHG', 
    'numVoicemailMessages': 'V_N_VM_MESS',
    'hasVoicemailPlan': 'C_VMP_Yes'}
    df = pd.DataFrame([data])
    df.rename(columns=column_mapping, inplace=True)
    return float(lr.predict_proba(df)[0,1])

def main(request):
    if not request:
        return jsonify({'error': 'Request is empty'}), 400
        
    data = request.get_json()
    if not data:
        return jsonify({'error': 'Request body is empty'}), 400
    
    required_fields = ['customerServiceCalls', 'totalDayCharges', 
                      'totalInternationalCharges', 'numVoicemailMessages',
                      'hasVoicemailPlan']
    
    missing_fields = [field for field in required_fields if field not in data]
    if missing_fields:
        return jsonify({'error': f'Missing required fields: {missing_fields}'}), 400
        
    # Validate data types
    for field in required_fields:
        if not isinstance(data[field], float):
            return jsonify({'error': f'Invalid data type for field {field}'}), 400
    try:
        proba = get_proba(data)
        response = {'churnProbability': proba}
        return jsonify(response)
    except Exception as e:
        print(f"Error: {e}")
        return jsonify({'error': 'Internal server error'}), 500