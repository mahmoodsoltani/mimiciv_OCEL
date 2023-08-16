insert into filtered_hosp.patients (select * from mimiciv_hosp.patients order by subject_id limit 1000 );
-- #######################################
insert into filtered_hosp.transfers (select * from mimiciv_hosp.transfers where subject_id in 
 					  (select subject_id from filtered_hosp.patients )
 						);
-- #######################################
insert into filtered_hosp.poe (select * from mimiciv_hosp.poe where subject_id in 
  					  (select subject_id from filtered_hosp.patients )
 				);
-- #######################################
insert into filtered_hosp.services (select * from mimiciv_hosp.services where subject_id in 
  					  (select subject_id from filtered_hosp.patients )
 				);
-- -- #######################################
insert into filtered_hosp.labevents (select * from mimiciv_hosp.labevents where subject_id in 
  					  (select subject_id from filtered_hosp.patients )
 				);
-- #######################################
insert into filtered_hosp.admissions (select * from mimiciv_hosp.admissions where subject_id in 
  					  (select subject_id from filtered_hosp.patients )
 				);
insert into filtered_hosp.pharmacy (select * from mimiciv_hosp.pharmacy where poe_id in 
  					  (select poe_id from filtered_hosp.poe )
 				);
insert into filtered_hosp.emar (select * from mimiciv_hosp.emar where poe_id in 
  					  (select poe_id from filtered_hosp.poe )
 				);
