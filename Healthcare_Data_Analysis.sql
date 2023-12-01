-- DATA ANALYSIS USING SQL ON HealthCare Database 
	-- This dataset is not based on real facts, please don't consider the result sets to be actual and utilize it for any purpose.
    
-- Creating Database named Healthcare.
CREATE DATABASE Healthcare;

-- Selecting Healthcare database to query.
USE Healthcare;

-- Viewing Data on Database
SELECT * FROM healthcare;

-- Describing characteristics of table.
DESC Healthcare;

-- 1.  Counting Total Record in Database
SELECT COUNT(*) FROM Healthcare;		

-- 2. Finding maximum age of patient admitted.
select max(age) as Maximum_Age from Healthcare;

-- 3. Finding Average age of hospitalized patients.
select round(avg(age),0) as Average_Age from Healthcare;	

-- 4. Calculating Patients Hospitalized Age-wise from Maximum to Minimum
SELECT AGE, COUNT(AGE) AS Total
FROM Healthcare
GROUP BY age
ORDER BY AGE DESC;
	-- Findings : The output will display a list of unique ages present in the "Healthcare" table along with the count of occurrences for each age, sorted from oldest 	to youngest.
    
    
-- 5. Calculating Maximum Count of patients on basis of total patients hospitalized with respect to age.
SELECT AGE, COUNT(AGE) AS Total
FROM Healthcare
GROUP BY age
ORDER BY Total DESC,age DESC;

-- 6. Ranking Age on the number of patients Hospitalized   
SELECT AGE, COUNT(AGE) As Total, dense_RANK() OVER(ORDER BY COUNT(AGE) DESC, age DESC) as Ranking_Admitted 
FROM Healthcare
GROUP BY age
HAVING Total > Avg(age);

-- 7. Finding Count of Medical Condition of patients and lisitng it by maximum no of patients.
SELECT Medical_Condition, COUNT(Medical_Condition) as Total_Patients 
FROM healthcare
GROUP BY Medical_Condition
ORDER BY Total_patients DESC;
	-- Findings : This query retrieves a breakdown of medical conditions recorded in a healthcare dataset along with the total number of patients diagnosed with each condition. It groups the data by distinct medical conditions, counting the occurrences of each condition across the dataset. The result is presented in descending order based on the total number of patients affected by each medical condition, providing an insight into the prevalence or frequency of various health issues within the dataset

-- 8. Finding Rank & Maximum number of medicines recommended to patients based on Medical Condition pertaining to them.    
SELECT Medical_Condition, Medication, COUNT(medication) as Total_Medications_to_Patients, RANK() OVER(PARTITION BY Medical_Condition ORDER BY COUNT(medication) DESC) as Rank_Medicine
FROM Healthcare
GROUP BY 1,2
ORDER BY 1; 
	-- Finding : The output provides insight into the most common medications used for various medical conditions, assigning a rank to each medication based on how frequently its prescribed within its corresponding condition.
    

-- 9. Most preffered Insurance Provide  by Patients Hospatilized
SELECT Insurance_Provider, COUNT(Insurance_Provider) AS Total 
FROM Healthcare
GROUP BY Insurance_Provider
ORDER BY Total DESC;
	-- Findings : This information helps identify the most prevalent insurance providers among the patient population, offering valuable data for resource allocation, understanding coverage preferences, and potentially indicating trends in healthcare accessibility based on insurance networks
    

-- 10. Finding out most preffered Hospital 
SELECT Hospital, COUNT(hospital) AS Total 
FROM Healthcare
GROUP BY Hospital
ORDER BY Total DESC;
	-- Findings : It provides insight into which hospitals have the highest frequency of records within the healthcare dataset. The resulting list showcases hospitals based on their patient count or the number of entries related to each hospital, allowing for an understanding of the distribution or prominence of healthcare services among different medical facilities.
    

-- 11. Identifying Average Billing Amount by Medical Condition.
SELECT Medical_Condition, ROUND(AVG(Billing_Amount),2) AS Avg_Billing_Amount
FROM Healthcare
GROUP BY Medical_Condition;
	-- Findings :  It offers insights into the typical costs associated with various medical conditions. This information can be valuable for analyzing the financial impact of different health issues, identifying expensive conditions, or assisting in resource allocation within healthcare facilities.
    

-- 12. Finding Billing Amount of patients admitted and number of days spent in respective hospital.
SELECT Medical_Condition, Name, Hospital, DATEDIFF(Discharge_date,Date_of_Admission) as Number_of_Days, 
SUM(ROUND(Billing_Amount,2)) OVER(Partition by Hospital ORDER BY Hospital DESC) AS Total_Amount
FROM Healthcare
ORDER BY Medical_Condition;
 
 
-- 13. Finding Total number of days sepnt by patient in an hospital for given medical condition
SELECT Name, Medical_Condition, ROUND(Billing_Amount,2) as Billing_Amount, Hospital, DATEDIFF(Discharge_Date, Date_of_Admission) as Total_Hospitalized_days
FROM Healthcare;
	-- Findings : This query retrieves a dataset showing the names of patients, their respective medical conditions, billed amounts (rounded to two decimal places), the hospitals they visited, and the duration of their hospital stay in days. Insights gleaned include: 
		-- Individual Patient Details: It presents a comprehensive view of patients, their medical conditions, billed amounts, and hospitals involved, aiding in understanding the scope of medical services availed by patients.
		-- Financial Overview: The rounded billing amounts provide an overview of the costs incurred by patients for their treatments, assisting in analyzing the financial aspect of healthcare services.
		-- Hospital Performance: By knowing the length of hospital stays, an evaluation of the efficiency of hospitals in managing patient care and treatment duration is possible.
		-- Potential Patterns: Patterns in medical conditions, billed amounts, and duration of hospitalization may emerge, offering insights into prevalent health issues and associated costs in the healthcare dataset.


-- 14. Finding Hospitals which were successful in discharging patients after having test results as 'Normal' with count of days taken to get results to Normal
SELECT Medical_Condition, Hospital, DATEDIFF(Discharge_Date, Date_of_Admission) as Total_Hospitalized_days,Test_results
FROM Healthcare
WHERE Test_results LIKE 'Normal'
ORDER BY Medical_Condition, Hospital;

-- 15. Calculate number of blood types of patients which lies betwwen age 20 to 45
SELECT Age, Blood_type, COUNT(Blood_Type) as Count_Blood_Type
FROM Healthcare
WHERE AGE BETWEEN 20 AND 45
GROUP BY 1,2
ORDER BY Blood_Type DESC;
	-- Findings: This query filters healthcare data for individuals aged between 20 and 45, grouping them by their age and blood type. It then counts the occurrences of each blood type within this age range. The output provides a breakdown of blood type distribution among individuals aged 20 to 45, revealing the prevalence of different blood types within this specific age bracket. The results may offer insights into any potential correlations between age groups and blood type occurrences within the dataset.
    

-- 16. Find how many of patient are Universal Blood Donor and Universal Blood reciever
SELECT DISTINCT (SELECT Count(Blood_Type) FROM healthcare WHERE Blood_Type IN ('O-')) AS Universal_Blood_Donor, 
(SELECT Count(Blood_Type) FROM healthcare WHERE Blood_Type  IN ('AB+')) as Universal_Blood_reciever
FROM healthcare;
	-- Findings : This query extracts specific counts of individuals with particular blood types ('O-' and 'AB+') from the healthcare dataset. It compares the count of 'O-' blood type individuals (considered universal donors) against the count of 'AB+' blood type individuals (considered universal recipients). The result showcases the stark contrast in the prevalence of these two blood types within the dataset, highlighting the potential availability of universal donors compared to universal recipients.
    

-- 17. Create a procedure to find Universal Blood Donor to an Universal Blood Reciever, with priority to same hospital and afterwards other hospitals
DELIMITER $$

CREATE PROCEDURE Blood_Matcher(IN Name_of_patient VARCHAR(200))
BEGIN 
SELECT D.Name as Donor_name, D.Age as Donor_Age, D.Blood_Type as Donors_Blood_type,D.Hospital as Donors_Hospital, 
R.Name as Reciever_name, R.Age as Reciever_Age, R.Blood_Type as Recievers_Blood_type, R.Hospital as Receivers_hospital
FROM Healthcare D 
INNER JOIN Healthcare R ON (D.Blood_type = 'O-' AND R.Blood_type = 'AB+') AND ((D.Hospital = R.Hospital) OR (D.Hospital != R.Hospital))
WHERE (R.Name REGEXP Name_of_patient) AND (D.AGE BETWEEN 20 AND 40);
END $$

DELIMITER ;

CALL Blood_Matcher('Matthew Cruz');	-- Enter the Name of patient as Argument

	-- Findings : This stored procedure named `Blood_Matcher` is designed to identify potential donors and recipients based on specific blood types ('O-' and 'AB+') within a certain age range (20 to 40 years old). It retrieves the names, ages, blood types, and hospitals of potential donors and recipients from the Healthcare database. The condition checks for a match between the blood types and hospitals of donors and recipients, or if they are from different hospitals. Additionally, it filters recipient names matching the input provided in the procedure call using regular expression. Overall, this procedure aims to find potential matches for blood donation between donors and recipients meeting specific criteria of blood type, age, and hospital affiliation or non-affiliation.
    

-- 18. Provide a list of hospitals along with the count of patients admitted in the year 2024 AND 2025?
SELECT DISTINCT Hospital, Count(*) as Total_Admitted
FROM healthcare
WHERE YEAR(Date_of_Admission) IN (2024, 2025)
GROUP BY 1
ORDER by Total_Admitted DESC; 
	-- Findings : This query provides insights into the total admissions in different hospitals for the years 2024 and 2025. It retrieves the count of distinct admissions per hospital within the specified timeframe. The results are ordered in descending order based on the total number of admissions, highlighting hospitals with the highest influx of patients during these years. This data can aid in identifying healthcare facilities experiencing higher patient volumes across the specified period, aiding in resource allocation or further analysis of healthcare demand.
    
    
-- 19. Find the average, minimum and maximum billing amount for each insurance provider?
SELECT Insurance_Provider, ROUND(AVG(Billing_Amount),0) as Average_Amount, ROUND(Min(Billing_Amount),0) as Minimum_Amount, ROUND(Max(Billing_Amount),0) as Maximum_Amount
FROM healthcare
GROUP BY 1;
	-- Findings : This query provides insights into billing amounts across different insurance providers in the healthcare dataset. It calculates the average, minimum, and maximum billing amounts per insurance provider. By examining these metrics, we can understand the typical billing amount range associated with each insurance provider. This information helps identify patterns in healthcare expenses linked to specific insurance companies, highlighting variations in billing practices or potential cost disparities among providers.


-- 20. Create a new column that categorizes patients as high, medium, or low risk based on their medical condition.
SELECT Name, Medical_Condition, Test_Results,
CASE 
		WHEN Test_Results = 'Inconclusive' THEN 'Need More Checks / CANNOT be Discharged'
        WHEN Test_Results = 'Normal' THEN 'Can take discharge, But need to follow Prescribed medications timely' 
        WHEN Test_Results =  'Abnormal' THEN 'Needs more attention and more tests'
        END AS 'Status', Hospital, Doctor
FROM Healthcare;
	-- Findings : This query provides a summary of patients status based on their test results for various medical conditions. It categorizes patients into distinct statuses: those requiring additional checks and unable to be discharged due to inconclusive results, individuals fit for discharge but needing strict adherence to prescribed medications for normal results, and those needing more attention and further tests for abnormal findings. It also displays associated details like the patient's name, hospital, and attending doctor, offering an overview of patient conditions, discharge possibilities, and necessary follow-up actions.