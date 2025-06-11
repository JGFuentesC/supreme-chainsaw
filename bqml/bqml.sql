CREATE OR REPLACE MODEL 
telco.logistic_churn  
options (

  model_type = 'LOGISTIC_REG',
  CATEGORY_ENCODING_METHOD =  'ONE_HOT_ENCODING',
  ENABLE_GLOBAL_EXPLAIN = TRUE,
  DATA_SPLIT_METHOD = 'AUTO_SPLIT',
  input_label_cols=['TARGET']

) as 
select * except (ID) from `telco.churn`;

select * from ml.predict(MODEL telco.logistic_churn ,
(select * from `telco.churn`))
