-- Table: filtered_hosp.transfers

DROP TABLE IF EXISTS filtered_hosp.repaired_transfers;
DROP TABLE IF EXISTS filtered_hosp.final_repaired_transfers;

CREATE TABLE IF NOT EXISTS filtered_hosp.repaired_transfers
(
    transfer_id int NOT NULL PRIMARY KEY,
    subject_id integer NOT NULL,
    hadm_id integer,
    eventtype character varying(10) COLLATE pg_catalog."default",
    careunit character varying(255) COLLATE pg_catalog."default",
    intime timestamp without time zone,
    outtime timestamp without time zone
);
CREATE SEQUENCE filtered_hosp.transfer_id;

ALTER TABLE filtered_hosp.repaired_transfers
    ALTER COLUMN transfer_id SET DEFAULT nextval('filtered_hosp.transfer_id');
ALTER SEQUENCE filtered_hosp.transfer_id OWNED BY filtered_hosp.repaired_transfers.transfer_id;
CREATE TABLE IF NOT EXISTS filtered_hosp.final_repaired_transfers
(
    transfer_id int NOT NULL PRIMARY KEY,
    subject_id integer NOT NULL,
    hadm_id integer,
    eventtype character varying(10) COLLATE pg_catalog."default",
    careunit character varying(255) COLLATE pg_catalog."default",
    intime timestamp without time zone,
    outtime timestamp without time zone
);
CREATE SEQUENCE filtered_hosp.transfer_id_2;

ALTER TABLE filtered_hosp.final_repaired_transfers
    ALTER COLUMN transfer_id SET DEFAULT nextval('filtered_hosp.transfer_id_2');
ALTER SEQUENCE filtered_hosp.transfer_id_2 OWNED BY filtered_hosp.final_repaired_transfers.transfer_id;

insert into filtered_hosp.repaired_transfers (subject_id,hadm_id,eventtype,careunit,intime,outtime )
select distinct subject_id,hadm_id,eventtype,careunit,intime,outtime 
from filtered_hosp.transfers 
where transfer_id not in (with numberd as (select row_number() over (PARTITION BY subject_id
                        ,hadm_id order by intime)as rn,* from (select row_number() OVER (
                        PARTITION BY subject_id
                        ,hadm_id,eventtype,careunit
                        order by intime),* from filtered_hosp.transfers 
						order by intime)as c)
select distinct n1.transfer_id from numberd as n1, numberd as n2 where 
n1.subject_id = n2.subject_id and n1.hadm_id=n2.hadm_id and n1.eventtype=n2.eventtype
and n1.careunit=n2.careunit  and n1.row_number = n2.row_number-1 and n1.rn=n2.rn-1)
and hadm_id is not null
order by hadm_id,intime;

insert into filtered_hosp.final_repaired_transfers (select * from filtered_hosp.repaired_transfers);

update filtered_hosp.repaired_transfers  set  intime=(
select outtime+interval '1 seconds' from filtered_hosp.repaired_transfers as r1 
where 
r1.subject_id = filtered_hosp.repaired_transfers.subject_id and
	r1.hadm_id = filtered_hosp.repaired_transfers.hadm_id
and r1.transfer_id=filtered_hosp.repaired_transfers.transfer_id-1);

update filtered_hosp.repaired_transfers set intime =
(select intime from filtered_hosp.final_repaired_transfers as frt
 where frt.transfer_id = filtered_hosp.repaired_transfers.transfer_id )
where filtered_hosp.repaired_transfers.intime is null;

update filtered_hosp.repaired_transfers set outtime = intime where outtime is null;
DROP TABLE IF EXISTS filtered_hosp.final_repaired_transfers;

-- select * from filtered_hosp.repaired_transfers where  hadm_id=20075017 order by intime
-- select * from filtered_hosp.transfers  where  hadm_id=20075017 order by intime
