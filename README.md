# SQL - Data Analysis - Healthcare Dataset 
![SQL](https://img.shields.io/badge/Language-%20SQL-yellow/Workbench)
![SQL](https://img.shields.io/badge/Workbench-%20MySQL-green)

This dataset is taken from Kaggle (https://www.kaggle.com/datasets/prasad22/healthcare-dataset).

The SQL queries conducted on the Healthcare database provided comprehensive insights into various facets of patient demographics, medical conditions, treatments, financial aspects, and hospital performances. These findings facilitate informed decision-making processes and offer valuable insights for healthcare management and analysis. 

### 1. **Data Overview & Basic Statistics**
      - The dataset was explored to gather a comprehensive view of patient information and healthcare records. Queries included counting total records, finding the maximum and average ages of hospitalized patients, and analyzing patient demographics based on age.

### 2. **Medical Conditions & Medications**
      - Detailed insights were derived regarding prevalent medical conditions, medications prescribed for specific conditions, and the frequency of their occurrence. This information assists in understanding the distribution and treatment of various health issues within the dataset.

### 3. **Insurance Providers & Hospitals**
     - The project delved into patient preferences for insurance providers and hospitals based on frequency. This data aids in resource allocation, understanding coverage preferences, and evaluating the prominence of healthcare services across different facilities.

### 4. **Financial Analysis & Duration of Hospitalization**
     - Financial aspects were scrutinized by examining average billing amounts associated with different medical conditions and calculating the total billing amount and duration of hospital stays for patients across various hospitals. This helps in understanding costs, hospital efficiency, and patient care duration.

### 5. **Blood Type Analysis & Donation Matching**
     - The distribution of blood types among patients was explored, highlighting potential correlations between age groups and blood type occurrences. Additionally, a stored procedure, 'Blood_Matcher,' was created to identify potential donors and recipients based on specific criteria of blood types, age, and hospital affiliation or non-affiliation.

### 6. **Yearly Admissions & Insurance Analysis**
     - The analysis extended to identifying hospitals with patient admissions in specific years (2024 and 2025) and understanding billing patterns across different insurance providers. This aids in understanding patient inflow trends and disparities in billing practices among insurance companies.

### 7. **Patient Risk Categorization**
     - A column was created to categorize patients into high, medium, or low-risk categories based on their medical conditions and test results. This categorization allows for a quick assessment of patient status and required follow-up actions.

## Each column provides specific information about the patient, their admission, and the healthcare services provided, making this dataset suitable for various data analysis and modeling tasks in the healthcare domain. Here's a brief explanation of each column in the dataset -

### 1. Name: This column represents the name of the patient associated with the healthcare record.
### 2. Age: The age of the patient at the time of admission, expressed in years.
### 3. Gender: Indicates the gender of the patient, either "Male" or "Female."
### 4. Blood Type: The patient's blood type, which can be one of the common blood types (e.g., "A+", "O-", etc.).
### 5. Medical Condition: This column specifies the primary medical condition or diagnosis associated with the patient, such as "Diabetes," "Hypertension," "Asthma," and more.
### 6. Date of Admission: The date on which the patient was admitted to the healthcare facility.
### 7. Doctor: The name of the doctor responsible for the patient's care during their admission.
### 8. Hospital: Identifies the healthcare facility or hospital where the patient was admitted.
### 9. Insurance Provider: This column indicates the patient's insurance provider, which can be one of several options, including "Aetna," "Blue Cross," "Cigna," "UnitedHealthcare," and "Medicare."
### 10. Billing Amount: The amount of money billed for the patient's healthcare services during their admission. This is expressed as a floating-point number.
### 11. Room Number: The room number where the patient was accommodated during their admission.
### 12. Admission Type: Specifies the type of admission, which can be "Emergency," "Elective," or "Urgent," reflecting the circumstances of the admission.
### 13. Discharge Date: The date on which the patient was discharged from the healthcare facility, based on the admission date and a random number of days within a realistic range.
### 14. Medication: Identifies a medication prescribed or administered to the patient during their admission. Examples include "Aspirin," "Ibuprofen," "Penicillin," "Paracetamol," and "Lipitor."
### 15. Test Results: Describes the results of a medical test conducted during the patient's admission. Possible values include "Normal," "Abnormal," or "Inconclusive," indicating the outcome of the test.
