COLAB LINK to THE PYTHON FILE(SCRIPT)

https://colab.research.google.com/drive/1aAkoU6hf8_0WfhS04HnCS0yrCQ9cEI8W#scrollTo=tC3FZkO2edXi



--- SQL


--1Which Geo-political zone has the highest number of health
-- professionals and the area with the lowest

-- create a new column
ALTER TABLE health_dataset 
ADD COLUMN geo_political_zone Varchar(40) DEFAULT 0;

--Updated the column

UPDATE health_dataset 
SET geo_political_zone = CASE
    WHEN "State" like '%Abia%' THEN 'South_East'
	WHEN "State" like '%Imo%' THEN 'South_East'
	WHEN "State" like '%Enugu%' THEN 'South_East'
    WHEN "State" like '%Ebonyi%' THEN 'South_East'
    WHEN "State" like '%Anambra%' THEN 'South_East'
    WHEN "State" like '%Lagos%' THEN 'South_West' 
    WHEN "State" like '%Oyo%' THEN 'South_West' 
    WHEN "State" like '%Ekiti%' THEN 'South_West' 
    WHEN "State" like '%Ondo%' THEN 'South_West' 
    WHEN "State" like '%Ogun%' THEN 'South_West' 
    WHEN "State" like '%Osun%' THEN 'South_West' 
    WHEN "State" like '%Akwa-Ibom%' THEN 'South_South'
    WHEN "State" like '%Edo%' THEN 'South_South'
    WHEN "State" like '%Bayelsa%' THEN 'South_South'
    WHEN "State" like '%Delta%' THEN 'South_South'
    WHEN "State" like '%Cross River%' THEN 'South_South'
    WHEN "State" like '%Rivers%' THEN 'South_South'
    WHEN "State" like '%Kwara%' THEN 'North_Central' 
    WHEN "State" like '%Kogi%' THEN 'North_Central' 
    WHEN "State" like '%FCT%' THEN 'North_Central' 
    WHEN "State" like '%Nasarawa%' THEN 'North_Central' 
    WHEN "State" like '%Niger%' THEN 'North_Central' 
    WHEN "State" like '%Benue%' THEN 'North_Central' 
    WHEN "State" like '%Plateau%' THEN 'North_Central'
    WHEN "State" like '%Adamawa%' THEN 'North_East' 
    WHEN "State" like '%Bauchi%' THEN 'North_East' 
    WHEN "State" like '%Borno%' THEN 'North_East' 
    WHEN "State" like '%Gombe%' THEN 'North_East' 
    WHEN "State" like '%Taraba%' THEN 'North_East' 
    WHEN "State" like '%Yobe%' THEN 'North_East' 

    ELSE 'North_West'
END;


--geo ploitical zone with highest number of health facl

select geo_political_zone , doctor + pharmacists + pharm_tech + dentist + dent_tech + nurse + midwifes + nurse_midwife + lab_tech + lab_scientist + HR_HM_officer + community_h_officer + H_extention_worker + junior_com_h_w + env_h_w + health_attendance_assist as "total"
 from
	(select geo_political_zone,
	SUM(doctors) doctor,
	SUM(pharmacists ) pharmacists,
	sum(pharmacy_technicians) pharm_tech,
	sum(dentist) dentist,
	sum("Dental_Technicians") dent_tech,
	sum(nurses) nurse,
	sum(midwifes)midwifes,
	sum(nurse_midwife) nurse_midwife,
	sum("Lab_Technicians") lab_tech,
	sum(lab_scientists) lab_scientist,
	sum("Health_Records/HIM_Officers")HR_HM_officer,
	sum(community_health_officer)community_h_officer,
	sum("Health_extension_worker") H_extention_worker,
	sum("J_comm_health_worker") junior_com_h_w,
	sum(enviromental_health_worker) env_h_w,
	sum(health_attendance_assist) health_attendance_assist
from health_dataset hd 	
group by geo_political_zone)hd1
order by total desc
limit 1

-- geo ploitical zone with lowest number of health


select geo_political_zone , doctor + pharmacists + pharm_tech + dentist + dent_tech + nurse + midwifes + nurse_midwife + lab_tech + lab_scientist + HR_HM_officer + community_h_officer + H_extention_worker + junior_com_h_w + env_h_w + health_attendance_assist as "total"
 from
	(select geo_political_zone,
	SUM(doctors) doctor,
	SUM(pharmacists ) pharmacists,
	sum(pharmacy_technicians) pharm_tech,
	sum(dentist) dentist,
	sum("Dental_Technicians") dent_tech,
	sum(nurses) nurse,
	sum(midwifes)midwifes,
	sum(nurse_midwife) nurse_midwife,
	sum("Lab_Technicians") lab_tech,
	sum(lab_scientists) lab_scientist,
	sum("Health_Records/HIM_Officers")HR_HM_officer,
	sum(community_health_officer)community_h_officer,
	sum("Health_extension_worker") H_extention_worker,
	sum("J_comm_health_worker") junior_com_h_w,
	sum(enviromental_health_worker) env_h_w,
	sum(health_attendance_assist) health_attendance_assist
from health_dataset hd 	
group by geo_political_zone)hd1
order by total 
limit 1

--2.What is the distribution of health professionals across the country?
-- Do we have more Doctors, Nurses or Lab scientists?

select sum(doctor) total_doctor,
	   sum(nurse)	total_nurse,
	   sum(lab_scientist)total_lab_scientist
from
	   (select "State",
		SUM(doctors) doctor,
		SUM(pharmacists ) pharmacists,
		sum(pharmacy_technicians) pharm_tech,
		sum(dentist) dentist,
		sum("Dental_Technicians") dent_tech,
		sum(nurses) nurse,
		sum(midwifes)midwifes,
		sum(nurse_midwife) nurse_midwife,
		sum("Lab_Technicians") lab_tech,
		sum(lab_scientists) lab_scientist,
		sum("Health_Records/HIM_Officers")HR_HM_officer,
		sum(community_health_officer)community_h_officer,
		sum("Health_extension_worker") H_extention_worker,
		sum("J_comm_health_worker") junior_com_h_w,
		sum(enviromental_health_worker) env_h_w,
		sum(health_attendance_assist) health_attendance_assist
	from health_dataset hd 
	group by "State") hd1


--3. What's the average number of beds per facility? 
--Are there facilities that do not have beds at all?
-- If yes, which facility and what state?

-- average beds
select facility_name,
	   avg(beds)
from health_dataset hd 
group by facility_name

---facilities with no bed
select facility_name,
	   avg(beds)
from health_dataset hd 
group by facility_name
having avg(beds) = 0

--which facility and what state?

select"State", facility_name,
	   avg(beds)
from health_dataset hd 
group by facility_name, "State"
having avg(beds) = 0

--4.Which year had the highest number of health facilities inaugurated?

select start_date,
		count(start_date) health_facilities_inaugurated
from health_dataset hd 
group by start_date 
order by health_facilities_inaugurated desc
limit 1

--5. Do privately owned facilities have more health personnel than Public?

select ownership,
	   count(ownership) facility_owner_count
from health_dataset hd 
group by ownership 
order by facility_owner_count desc

--6.Which state has the highest number of privately owned health facilities?

select "State",
		ownership,
	   count(ownership) count_of_state_owned_facility
from health_dataset hd 
group by ownership, "State"
having ownership ='Private'
order by count_of_state_owned_facility desc
limit 1

--7.Are there regions and facilities with no health personnel?
-- What year were they inaugurated? Are they privately or publicly owned, and what is the Facility level?

select geo_political_zone, start_date ,facility_level,
	   ownership, doctor + pharmacists + pharm_tech + dentist + dent_tech + nurse + midwifes + nurse_midwife + lab_tech + lab_scientist + HR_HM_officer + community_h_officer + H_extention_worker + junior_com_h_w + env_h_w + health_attendance_assist as "total"
 from
	(select  geo_political_zone,
	    ownership,
	    start_date ,
	    facility_level,
	    SUM(doctors) doctor,
		SUM(pharmacists ) pharmacists,
		sum(pharmacy_technicians) pharm_tech,
		sum(dentist) dentist,
		sum("Dental_Technicians") dent_tech,
		sum(nurses) nurse,
		sum(midwifes)midwifes,
		sum(nurse_midwife) nurse_midwife,
		sum("Lab_Technicians") lab_tech,
		sum(lab_scientists) lab_scientist,
		sum("Health_Records/HIM_Officers")HR_HM_officer,
		sum(community_health_officer)community_h_officer,
		sum("Health_extension_worker") H_extention_worker,
		sum("J_comm_health_worker") junior_com_h_w,
		sum(enviromental_health_worker) env_h_w,
		sum(health_attendance_assist) health_attendance_assist
from health_dataset hd 
group by geo_political_zone ,facility_level ,ownership ,start_date)dh1


---8.Which facility has the lowest hour of operation? What's the operation hour?

select facility_name,
	  min( hour_of_opertion)
from health_dataset hd
group by hour_of_opertion,facility_name
having hour_of_opertion  not like '%0%'

SELECT HOUR(hour_of_opertion) AS hour_value FROM health_dataset hd ;


--9 Which state has the highest number of unlicensed health facilities?

select "State",
licemce_status,
count(licemce_status) licence_count
from health_dataset hd 
group by "State", licemce_status
having licemce_status ='Not Licensed'
order by licence_count desc
limit 1


---10.Which state has the highest number of licensed health facilities?

select "State",
licemce_status,
count(licemce_status) licence_count
from health_dataset hd 
group by "State", licemce_status
having licemce_status ='Licensed'
order by licence_count desc
limit 1

--11.What is the ratio of Doctors to Nurses in each State?
 
select "State",
	count(doctors)/count(nurses) ratio
from health_dataset hd 
group by "State"
having count(doctors)!=0 and count(nurses)!=0



--12 Facilities within 1km of each other in same LGA

SELECT
    *,
    111.045 * DEGREES(ACOS(COS(RADIANS(LagLat)) * 
    COS(RADIANS(latitude)) * COS(RADIANS(LagLong - "Longitude")) 
    + SIN(RADIANS(LagLat)) * SIN(RADIANS(latitude)))) AS KM
FROM
    (
        select
        	"LGA"
        	facility_name,
            latitude,
            "Longitude",
            LAG(latitude) OVER (ORDER BY facility_uid) AS LagLat,
            LAG("Longitude") OVER (ORDER BY facility_uid) AS LagLong
        FROM
            health_dataset hd 
    ) sub
  where 111.045 * DEGREES(ACOS(COS(RADIANS(LagLat)) * 
  COS(RADIANS(latitude)) * COS(RADIANS(LagLong - "Longitude")) + 
  SIN(RADIANS(LagLat)) * SIN(RADIANS(latitude)))) >= 0
	and 111.045 * DEGREES(ACOS(COS(RADIANS(LagLat)) * 
	COS(RADIANS(latitude)) * COS(RADIANS(LagLong - "Longitude")) +
	SIN(RADIANS(LagLat)) * SIN(RADIANS(latitude)))) <= 1
   
   
-- 13 First established Facility per LGA


SELECT 
    "LGA", 
    facility_name, 
    start_date
FROM 
(SELECT 
        "LGA", 
        facility_name, 
        start_date,
        ROW_NUMBER() OVER (PARTITION BY "LGA" ORDER BY start_date) AS exterblished_year
    FROM health_dataset) dh1
WHERE exterblished_year = 1
ORDER BY "LGA"

--14.How many facilities per LGA & Ward with their curresponding total per LGA and Ward separately

SELECT 
    "LGA", 
    ward, 
    COUNT(*) AS facilities_per_ward_and_LGA,
    SUM(COUNT(*)) OVER (PARTITION BY "LGA") AS total_facilities_per_lga,
    SUM(COUNT(*)) OVER (PARTITION BY "LGA", Ward) AS total_facilities_per_ward
FROM health_dataset
GROUP BY "LGA", ward
ORDER BY "LGA", ward



-- 15What facilities/facility have their tenure above the average facility tenure in their Ward as of today

SELECT 
    ward,
    facility_name,
    CAST(start_date AS DATE) AS start_date
FROM health_dataset
WHERE start_date ~ '^[0-9]{4}-[0-9]{2}-[0-9]{2}$';



SELECT 
    hd.facility_name,
    hd.ward,
    CAST(start_date AS DATE) AS start_date,
    DATE_PART('year', AGE(CURRENT_DATE, hd.start_date::DATE)) AS tenure_in_years
FROM health_dataset hd
WHERE start_date ~ '^[0-9]{4}-[0-9]{2}-[0-9]{2}$'
AND DATE_PART('year', AGE(CURRENT_DATE, hd.start_date::DATE)) > (
    SELECT 
        AVG(DATE_PART('year', AGE(CURRENT_DATE, start_date::DATE))) AS avg_tenure
    FROM health_dataset
    WHERE start_date ~ '^[0-9]{4}-[0-9]{2}-[0-9]{2}$'
    AND ward = hd.ward
)
ORDER BY hd.ward, hd.facility_name;






--16.Write a query to select earliet and latest Facilities per ward

SELECT 
    ward, 
    MIN(start_date) AS earliest_date, 
    MAX(start_date) AS latest_date,
    MIN(facility_name) AS earliest_facility,
    MAX(facility_name) AS latest_facility
FROM health_dataset
GROUP BY ward;


--17 When (in years) is the duration between the latest and earliest Facility per ward in each LGA.

ALTER TABLE health_dataset
ADD COLUMN year_col INT;

UPDATE health_dataset
SET year = 
    CASE 
        WHEN start_date ~ '^[0-9]{4}-[0-9]{2}-[0-9]{2}$' 
            THEN EXTRACT(YEAR FROM CAST(start_date AS DATE)) 
        ELSE NULL 
    END;

   
SELECT 
    "LGA" , 
    ward, 
    DATE_PART('year', AGE(MAX(start_date)::DATE, MIN(start_date)::DATE)) AS tenure_duration
FROM health_dataset
GROUP BY "LGA" , ward;

--18

SELECT 
    "State", 
    year, 
    AVG(num_facilities) OVER (
        PARTITION BY "State" 
        ORDER BY year 
        ROWS BETWEEN 2 PRECEDING AND CURRENT row)AS moving_avg
FROM 
    (SELECT 
        "State", 
        year, 
        COUNT(*) AS num_facilities
    FROM  health_dataset
    WHERE year IS NOT NULL
    GROUP by "State",year
) dh1
ORDER BY "State", year;

--19. Find (in months) average month it takes for new facilities to be established per LGA. 


   ALTER TABLE health_dataset
ADD COLUMN month INT;

UPDATE health_dataset
SET month = 
    CASE 
        WHEN start_date ~ '^[0-9]{4}-[0-9]{2}-[0-9]{2}$' 
            THEN EXTRACT(month FROM CAST(start_date AS DATE)) 
        ELSE NULL 
    END;


SELECT 
    "LGA", 
    AVG(DATE_PART('month', TO_DATE(month || '-01-2022', 'MM-DD-YYYY'))) AS avg_month_to_establish
FROM 
    health_dataset
GROUP BY 
    "LGA";




 ---20
   
   
   
Based on the data  I have scraped and explored, 
the South-South region appears to have the lowest number of healthcare facilities
compared to other regions. As such, I would advise the Minister of Health
to focus on strengthening the healthcare infrastructure in this region,
and increasing the number of health professionals available 
to provide services to the entire national population.
This could involve investing in new hospital construction or renovation,
providing funding for the hiring and training of additional healthcare workers,
and implementing programs to improve access to healthcare services in underserved communities.
By prioritizing these efforts in the South-South region which has the lowest facility and 
Imploring the minister to try and reduce or eradicate the number of unlicensed 
as they may not be totally fit as professionals to attend to patients.
we can work towards ensuring that all Nigerians have access to the healthcare
they need to live healthy and fulfilling lives.












 
 
 