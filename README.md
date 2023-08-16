# mimiciv_OCEL
Create OCEL from MIMICIV dataset 
#Repaire_transfer.sql
  In this query, we merge events with the same subject_id, hadm_id, careunit, eventtype value, and they occur sequentially.
  
  steps:
    
    1) Remove repeated rows

    2) Update Intime of last row

   Sample repaire for subject_id = 10021395 and hadm_id=20075017
  
Original table:
![image](https://github.com/mahmoodsoltani/mimiciv_OCEL/assets/36055083/c9841230-1b01-4749-ac92-6ae01de9ff75)

Merged table:
![image](https://github.com/mahmoodsoltani/mimiciv_OCEL/assets/36055083/759150f6-9078-4aeb-a7d3-114697798247)
