DROP SCHEMA IF EXISTS filtered_hosp CASCADE;
CREATE SCHEMA filtered_hosp ;
-- Table: Filtered_hosp.patients

-- DROP TABLE IF EXISTS Filtered_hosp.patients;

CREATE TABLE IF NOT EXISTS Filtered_hosp.patients
(
    subject_id integer NOT NULL,
    gender character(1) COLLATE pg_catalog."default" NOT NULL,
    anchor_age smallint,
    anchor_year smallint NOT NULL,
    anchor_year_group character varying(20) COLLATE pg_catalog."default" NOT NULL,
    dod date
);

-- Table: Filtered_hosp.admissions

-- DROP TABLE IF EXISTS Filtered_hosp.admissions;

CREATE TABLE IF NOT EXISTS Filtered_hosp.admissions
(
    subject_id integer NOT NULL,
    hadm_id integer NOT NULL,
    admittime timestamp without time zone NOT NULL,
    dischtime timestamp without time zone,
    deathtime timestamp without time zone,
    admission_type character varying(40) COLLATE pg_catalog."default" NOT NULL,
    admit_provider_id character varying(10) COLLATE pg_catalog."default",
    admission_location character varying(60) COLLATE pg_catalog."default",
    discharge_location character varying(60) COLLATE pg_catalog."default",
    insurance character varying(255) COLLATE pg_catalog."default",
    language character varying(10) COLLATE pg_catalog."default",
    marital_status character varying(30) COLLATE pg_catalog."default",
    race character varying(80) COLLATE pg_catalog."default",
    edregtime timestamp without time zone,
    edouttime timestamp without time zone,
    hospital_expire_flag smallint
);

-- Table: Filtered_hosp.labevents

-- DROP TABLE IF EXISTS Filtered_hosp.labevents;

CREATE TABLE IF NOT EXISTS Filtered_hosp.labevents
(
    labevent_id integer NOT NULL,
    subject_id integer NOT NULL,
    hadm_id integer,
    specimen_id integer NOT NULL,
    itemid integer NOT NULL,
    order_provider_id character varying(10) COLLATE pg_catalog."default",
    charttime timestamp(0) without time zone,
    storetime timestamp(0) without time zone,
    value character varying(200) COLLATE pg_catalog."default",
    valuenum double precision,
    valueuom character varying(20) COLLATE pg_catalog."default",
    ref_range_lower double precision,
    ref_range_upper double precision,
    flag character varying(10) COLLATE pg_catalog."default",
    priority character varying(7) COLLATE pg_catalog."default",
    comments text COLLATE pg_catalog."default"
)
;
-- Table: Filtered_hosp.poe

-- DROP TABLE IF EXISTS Filtered_hosp.poe;

CREATE TABLE IF NOT EXISTS Filtered_hosp.poe
(
    poe_id character varying(25) COLLATE pg_catalog."default" NOT NULL,
    poe_seq integer NOT NULL,
    subject_id integer NOT NULL,
    hadm_id integer,
    ordertime timestamp(0) without time zone NOT NULL,
    order_type character varying(25) COLLATE pg_catalog."default" NOT NULL,
    order_subtype character varying(50) COLLATE pg_catalog."default",
    transaction_type character varying(15) COLLATE pg_catalog."default",
    discontinue_of_poe_id character varying(25) COLLATE pg_catalog."default",
    discontinued_by_poe_id character varying(25) COLLATE pg_catalog."default",
    order_provider_id character varying(10) COLLATE pg_catalog."default",
    order_status character varying(15) COLLATE pg_catalog."default"
);


-- Table: Filtered_hosp.poe_detail

-- DROP TABLE IF EXISTS Filtered_hosp.poe_detail;

CREATE TABLE IF NOT EXISTS Filtered_hosp.poe_detail
(
    poe_id character varying(25) COLLATE pg_catalog."default" NOT NULL,
    poe_seq integer NOT NULL,
    subject_id integer NOT NULL,
    field_name character varying(255) COLLATE pg_catalog."default" NOT NULL,
    field_value text COLLATE pg_catalog."default"
);


-- Table: Filtered_hosp.services

-- DROP TABLE IF EXISTS Filtered_hosp.services;

CREATE TABLE IF NOT EXISTS Filtered_hosp.services
(
    subject_id integer NOT NULL,
    hadm_id integer NOT NULL,
    transfertime timestamp without time zone NOT NULL,
    prev_service character varying(10) COLLATE pg_catalog."default",
    curr_service character varying(10) COLLATE pg_catalog."default"
);



-- Table: Filtered_hosp.transfers

-- DROP TABLE IF EXISTS Filtered_hosp.transfers;

CREATE TABLE IF NOT EXISTS Filtered_hosp.transfers
(
    subject_id integer NOT NULL,
    hadm_id integer,
    transfer_id integer NOT NULL,
    eventtype character varying(10) COLLATE pg_catalog."default",
    careunit character varying(255) COLLATE pg_catalog."default",
    intime timestamp without time zone,
    outtime timestamp without time zone
);


-- Table: Filtered_hosp.pharmacy

-- DROP TABLE IF EXISTS Filtered_hosp.pharmacy;

CREATE TABLE IF NOT EXISTS Filtered_hosp.pharmacy
(
    subject_id integer NOT NULL,
    hadm_id integer NOT NULL,
    pharmacy_id integer NOT NULL,
    poe_id character varying(25) COLLATE pg_catalog."default",
    starttime timestamp(3) without time zone,
    stoptime timestamp(3) without time zone,
    medication text COLLATE pg_catalog."default",
    proc_type character varying(50) COLLATE pg_catalog."default" NOT NULL,
    status character varying(50) COLLATE pg_catalog."default",
    entertime timestamp(3) without time zone NOT NULL,
    verifiedtime timestamp(3) without time zone,
    route character varying(50) COLLATE pg_catalog."default",
    frequency character varying(50) COLLATE pg_catalog."default",
    disp_sched character varying(255) COLLATE pg_catalog."default",
    infusion_type character varying(15) COLLATE pg_catalog."default",
    sliding_scale character varying(1) COLLATE pg_catalog."default",
    lockout_interval character varying(50) COLLATE pg_catalog."default",
    basal_rate real,
    one_hr_max character varying(10) COLLATE pg_catalog."default",
    doses_per_24_hrs real,
    duration real,
    duration_interval character varying(50) COLLATE pg_catalog."default",
    expiration_value integer,
    expiration_unit character varying(50) COLLATE pg_catalog."default",
    expirationdate timestamp(3) without time zone,
    dispensation character varying(50) COLLATE pg_catalog."default",
    fill_quantity character varying(50) COLLATE pg_catalog."default"
);


-- Table: Filtered_hosp.emar

-- DROP TABLE IF EXISTS Filtered_hosp.emar;

CREATE TABLE IF NOT EXISTS Filtered_hosp.emar
(
    subject_id integer NOT NULL,
    hadm_id integer,
    emar_id character varying(25) COLLATE pg_catalog."default" NOT NULL,
    emar_seq integer NOT NULL,
    poe_id character varying(25) COLLATE pg_catalog."default" NOT NULL,
    pharmacy_id integer,
    enter_provider_id character varying(10) COLLATE pg_catalog."default",
    charttime timestamp without time zone NOT NULL,
    medication text COLLATE pg_catalog."default",
    event_txt character varying(100) COLLATE pg_catalog."default",
    scheduletime timestamp without time zone,
    storetime timestamp without time zone NOT NULL
);

-- Table: mimiciv_hosp.emar_detail

-- DROP TABLE IF EXISTS mimiciv_hosp.emar_detail;

CREATE TABLE IF NOT EXISTS filtered_hosp.emar_detail
(
    subject_id integer NOT NULL,
    emar_id character varying(25) COLLATE pg_catalog."default" NOT NULL,
    emar_seq integer NOT NULL,
    parent_field_ordinal character varying(10) COLLATE pg_catalog."default",
    administration_type character varying(50) COLLATE pg_catalog."default",
    pharmacy_id integer,
    barcode_type character varying(4) COLLATE pg_catalog."default",
    reason_for_no_barcode text COLLATE pg_catalog."default",
    complete_dose_not_given character varying(5) COLLATE pg_catalog."default",
    dose_due character varying(100) COLLATE pg_catalog."default",
    dose_due_unit character varying(50) COLLATE pg_catalog."default",
    dose_given character varying(255) COLLATE pg_catalog."default",
    dose_given_unit character varying(50) COLLATE pg_catalog."default",
    will_remainder_of_dose_be_given character varying(5) COLLATE pg_catalog."default",
    product_amount_given character varying(30) COLLATE pg_catalog."default",
    product_unit character varying(30) COLLATE pg_catalog."default",
    product_code character varying(30) COLLATE pg_catalog."default",
    product_description character varying(255) COLLATE pg_catalog."default",
    product_description_other character varying(255) COLLATE pg_catalog."default",
    prior_infusion_rate character varying(40) COLLATE pg_catalog."default",
    infusion_rate character varying(40) COLLATE pg_catalog."default",
    infusion_rate_adjustment character varying(50) COLLATE pg_catalog."default",
    infusion_rate_adjustment_amount character varying(30) COLLATE pg_catalog."default",
    infusion_rate_unit character varying(30) COLLATE pg_catalog."default",
    route character varying(10) COLLATE pg_catalog."default",
    infusion_complete character varying(1) COLLATE pg_catalog."default",
    completion_interval character varying(50) COLLATE pg_catalog."default",
    new_iv_bag_hung character varying(1) COLLATE pg_catalog."default",
    continued_infusion_in_other_location character varying(1) COLLATE pg_catalog."default",
    restart_interval character varying(2305) COLLATE pg_catalog."default",
    side character varying(10) COLLATE pg_catalog."default",
    site character varying(255) COLLATE pg_catalog."default",
    non_formulary_visual_verification character varying(1) COLLATE pg_catalog."default"
);
