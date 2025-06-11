CREATE OR REPLACE MODEL telco.automl_churn
OPTIONS(MODEL_TYPE = 'AUTOML_CLASSIFIER' ,
BUDGET_HOURS = 1,
OPTIMIZATION_OBJECTIVE = 'MAXIMIZE_AU_ROC',
input_label_cols=['TARGET']
)
AS select * except (ID) from `telco.churn`;