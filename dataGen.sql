-- Data Population Script for Medi-Captions Database

-- Patient Table
INSERT INTO Patient (Active, Gender, BirthDate, DeceasedBoolean, DeceasedDateTime, MaritalStatus, MultipleBirthBoolean, MultipleBirthInteger, Photo)
VALUES
(true, 'Male', '1990-01-01', false, NULL, 'Single', false, NULL, 'https://example.com/photo1.jpg'),
(true, 'Female', '1985-05-15', false, NULL, 'Married', false, NULL, 'https://example.com/photo2.jpg'),
(true, 'Non-Binary', '1998-10-20', false, NULL, 'Divorced', true, 2, 'https://example.com/photo3.jpg'),
(true, 'Male', '1980-03-12', true, '2022-01-15 08:30:00', 'Widowed', false, NULL, 'https://example.com/photo4.jpg'),
(true, 'Female', '1995-08-03', false, NULL, 'Single', false, NULL, 'https://example.com/photo5.jpg'),
(true, 'Male', '1992-11-27', false, NULL, 'Married', false, NULL, 'https://example.com/photo6.jpg'),
(true, 'Female', '1987-04-08', false, NULL, 'Single', false, NULL, 'https://example.com/photo7.jpg'),
(true, 'Male', '1999-09-18', false, NULL, 'Single', false, NULL, 'https://example.com/photo8.jpg'),
(true, 'Female', '1983-06-25', true, '2022-02-10 12:45:00', 'Widowed', false, NULL, 'https://example.com/photo9.jpg'),
(true, 'Male', '1994-12-07', false, NULL, 'Married', false, NULL, 'https://example.com/photo10.jpg');

-- PatientName Table
INSERT INTO PatientName (PatientID, FamilyName, GivenName, MiddleName, Prefix, Suffix, UsageType)
VALUES
(1, 'Doe', 'John', 'Robert', 'Mr.', NULL, 'Official'),
(2, 'Smith', 'Jane', 'Marie', 'Mrs.', NULL, 'Official'),
(3, 'Taylor', 'Alex', NULL, 'Dr.', 'Jr.', 'Official'),
(4, 'Johnson', 'Michael', 'David', 'Mr.', NULL, 'Official'),
(5, 'Anderson', 'Emily', 'Grace', 'Miss', NULL, 'Official'),
(6, 'Brown', 'Daniel', 'Thomas', 'Mr.', NULL, 'Official'),
(7, 'Davis', 'Sophia', 'Lynn', 'Mrs.', 'II', 'Official'),
(8, 'Wilson', 'Chris', 'Robert', 'Mr.', NULL, 'Official'),
(9, 'Martin', 'Ella', 'Rose', 'Miss', NULL, 'Official'),
(10, 'Clark', 'Matthew', 'Ryan', 'Mr.', NULL, 'Official');

-- PatientTelecom Table
INSERT INTO PatientTelecom (PatientID, SystemType, Value, UsageType, PreferenceOrder)
VALUES
(1, 'phone', '+1234567890', 'Home', 1),
(2, 'email', 'jane.smith@example.com', 'Work', 1),
(3, 'phone', '+9876543210', 'Mobile', 1),
(4, 'email', 'michael.johnson@example.com', 'Home', 1),
(5, 'phone', '+2345678901', 'Work', 1),
(6, 'email', 'daniel.brown@example.com', 'Mobile', 1),
(7, 'phone', '+3456789012', 'Home', 1),
(8, 'email', 'chris.wilson@example.com', 'Work', 1),
(9, 'phone', '+4567890123', 'Mobile', 1),
(10, 'email', 'matthew.clark@example.com', 'Home', 1);

-- PatientAddress Table
INSERT INTO PatientAddress (PatientID, UsageType, Type, Text, Line, City, District, State, PostalCode, Country, PeriodStart, PeriodEnd)
VALUES
(1, 'Home', 'Physical', '123 Main St', 'Apt 45', 'Cityville', 'District A', 'State X', '12345', 'Country Z', '2022-01-01', NULL),
(2, 'Work', 'Postal', '456 Business Ave', 'Suite 101', 'Townsville', 'District B', 'State Y', '67890', 'Country W', '2022-01-01', NULL),
(3, 'Home', 'Physical', '789 Residential Blvd', 'Unit 23', 'Villagetown', 'District C', 'State Z', '45678', 'Country X', '2022-01-01', NULL),
(4, 'Work', 'Postal', '321 Office Lane', 'Floor 5', 'Cityopolis', 'District D', 'State Y', '98765', 'Country Z', '2022-01-01', NULL),
(5, 'Home', 'Physical', '543 Living Street', 'Apt 12', 'Townberg', 'District E', 'State X', '23456', 'Country Y', '2022-01-01', NULL),
(6, 'Work', 'Postal', '876 Corporate Road', 'Suite 304', 'Cityburg', 'District F', 'State Z', '78901', 'Country X', '2022-01-01', NULL),
(7, 'Home', 'Physical', '234 Homely Lane', 'Unit 67', 'Villageville', 'District G', 'State X', '34567', 'Country Z', '2022-01-01', NULL),
(8, 'Work', 'Postal', '567 Office Park', 'Floor 2', 'Citytown', 'District H', 'State Y', '89012', 'Country W', '2022-01-01', NULL),
(9, 'Home', 'Physical', '890 Residential Circle', 'Unit 89', 'Villagetown', 'District I', 'State Z', '12345', 'Country Y', '2022-01-01', NULL),
(10, 'Work', 'Postal', '123 Corporate Blvd', 'Suite 405', 'Townopolis', 'District J', 'State X', '67890', 'Country Z', '2022-01-01', NULL);

-- PatientContact Table
INSERT INTO PatientContact (PatientID, Relationship, Name, Telecom, Address, Gender, Organization, PeriodStart, PeriodEnd)
VALUES
(1, 'Emergency Contact', 'Mary Doe', '+1987654321', '789 Emergency St, Cityville', 'Female', 'Hospital A', '2022-01-01', NULL),
(2, 'Next of Kin', 'Bob Smith', 'bob.smith@example.com', '456 Kinship St, Townsville', 'Male', 'Clinic B', '2022-01-01', NULL),
(3, 'Emergency Contact', 'Alex Taylor', '+1234567890', '123 Urgent Lane, Villagetown', 'Non-Binary', 'Health Center C', '2022-01-01', NULL),
(4, 'Next of Kin', 'Sarah Johnson', 'sarah.johnson@example.com', '321 Family Ave, Cityopolis', 'Female', 'Medical Center D', '2022-01-01', NULL),
(5, 'Emergency Contact', 'Mark Anderson', '+2345678901', '543 Help St, Townberg', 'Male', 'Hospital E', '2022-01-01', NULL),
(6, 'Next of Kin', 'Olivia Brown', 'olivia.brown@example.com', '876 Support Blvd, Cityburg', 'Female', 'Clinic F', '2022-01-01', NULL),
(7, 'Emergency Contact', 'Jake Davis', '+3456789012', '234 Urgent Circle, Villageville', 'Male', 'Health Center G', '2022-01-01', NULL),
(8, 'Next of Kin', 'Emma Wilson', 'emma.wilson@example.com', '567 Support Lane, Citytown', 'Female', 'Medical Center H', '2022-01-01', NULL),
(9, 'Emergency Contact', 'Grace Martin', '+4567890123', '890 Urgent Road, Villagetown', 'Female', 'Hospital I', '2022-01-01', NULL),
(10, 'Next of Kin', 'Luke Clark', 'luke.clark@example.com', '123 Emergency Ave, Townopolis', 'Male', 'Clinic J', '2022-01-01', NULL);


-- PatientCommunication Table
INSERT INTO PatientCommunication (PatientID, Language, Preferred)
VALUES
(1, 'English', true),
(2, 'Spanish', true),
(3, 'French', false),
(4, 'German', true),
(5, 'Chinese', false),
(6, 'Japanese', true),
(7, 'Korean', false),
(8, 'Arabic', true),
(9, 'Russian', false),
(10, 'Italian', true);


-- Practitioner Table
INSERT INTO Practitioner (Active, Gender, BirthDate, Photo)
VALUES
(true, 'Male', '1975-04-20', 'https://example.com/practitioner1.jpg'),
(true, 'Female', '1980-07-15', 'https://example.com/practitioner2.jpg'),
(true, 'Non-Binary', '1992-12-10', 'https://example.com/practitioner3.jpg'),
(true, 'Male', '1968-09-05', 'https://example.com/practitioner4.jpg'),
(true, 'Female', '1972-02-28', 'https://example.com/practitioner5.jpg'),
(true, 'Male', '1985-11-15', 'https://example.com/practitioner6.jpg'),
(true, 'Female', '1990-06-08', 'https://example.com/practitioner7.jpg'),
(true, 'Male', '1977-01-25', 'https://example.com/practitioner8.jpg'),
(true, 'Female', '1982-08-18', 'https://example.com/practitioner9.jpg'),
(true, 'Male', '1995-03-07', 'https://example.com/practitioner10.jpg');


-- PractitionerName Table
INSERT INTO PractitionerName (PractitionerID, FamilyName, GivenName, MiddleName, Prefix, Suffix, UsageType)
VALUES
(1, 'Smith', 'John', 'Robert', 'Dr.', 'Jr.', 'Official'),
(2, 'Johnson', 'Anna', 'Marie', 'Dr.', 'III', 'Official'),
(3, 'Taylor', 'Alex', NULL, 'Dr.', NULL, 'Official'),
(4, 'Williams', 'Michael', 'David', 'Dr.', 'Sr.', 'Official'),
(5, 'Davis', 'Emily', 'Grace', 'Dr.', NULL, 'Official'),
(6, 'Brown', 'Daniel', 'Thomas', 'Dr.', NULL, 'Official'),
(7, 'Miller', 'Sophia', 'Lynn', 'Dr.', 'II', 'Official'),
(8, 'Wilson', 'Chris', 'Robert', 'Dr.', NULL, 'Official'),
(9, 'Martin', 'Ella', 'Rose', 'Dr.', NULL, 'Official'),
(10, 'Clark', 'Matthew', 'Ryan', 'Dr.', NULL, 'Official');


-- PractitionerTelecom Table
INSERT INTO PractitionerTelecom (PractitionerID, ContactSystem, Value, UsageType, PreferenceOrder)
VALUES
(1, 'phone', '+1987654321', 'Work', 1),
(2, 'email', 'anna.johnson@example.com', 'Home', 1),
(3, 'phone', '+1234567890', 'Mobile', 1),
(4, 'email', 'michael.williams@example.com', 'Work', 1),
(5, 'phone', '+2345678901', 'Home', 1),
(6, 'email', 'daniel.brown@example.com', 'Mobile', 1),
(7, 'phone', '+3456789012', 'Work', 1),
(8, 'email', 'chris.wilson@example.com', 'Home', 1),
(9, 'phone', '+4567890123', 'Mobile', 1),
(10, 'email', 'matthew.clark@example.com', 'Work', 1);


-- PractitionerAddress Table
INSERT INTO PractitionerAddress (PractitionerID, UsageType, Type, Text, Line, City, District, State, PostalCode, Country, PeriodStart, PeriodEnd)
VALUES
(1, 'Work', 'Physical', '123 Medical St', 'Suite 101', 'Cityville', 'District A', 'State X', '12345', 'Country Z', '2022-01-01', NULL),
(2, 'Home', 'Postal', '456 Doctor Ave', 'Apt 23', 'Townsville', 'District B', 'State Y', '67890', 'Country W', '2022-01-01', NULL),
(3, 'Work', 'Physical', '789 Hospital Blvd', 'Floor 5', 'Villagetown', 'District C', 'State Z', '45678', 'Country X', '2022-01-01', NULL),
(4, 'Home', 'Postal', '321 Clinic Lane', 'Unit 12', 'Cityopolis', 'District D', 'State Y', '98765', 'Country Z', '2022-01-01', NULL),
(5, 'Work', 'Physical', '543 Medical Street', 'Suite 304', 'Townberg', 'District E', 'State X', '23456', 'Country Y', '2022-01-01', NULL),
(6, 'Home', 'Postal', '876 Hospital Road', 'Floor 2', 'Cityburg', 'District F', 'State Z', '78901', 'Country X', '2022-01-01', NULL),
(7, 'Work', 'Physical', '234 Clinic Circle', 'Unit 67', 'Villageville', 'District G', 'State X', '34567', 'Country Z', '2022-01-01', NULL),
(8, 'Home', 'Postal', '567 Doctor Lane', 'Apt 89', 'Citytown', 'District H', 'State Y', '89012', 'Country W', '2022-01-01', NULL),
(9, 'Work', 'Physical', '890 Hospital Blvd', 'Suite 405', 'Villagetown', 'District I', 'State Z', '12345', 'Country Y', '2022-01-01', NULL),
(10, 'Home', 'Postal', '123 Clinic Ave', 'Unit 10', 'Townopolis', 'District J', 'State X', '67890', 'Country Z', '2022-01-01', NULL);

-- PractitionerQualification Table
INSERT INTO PractitionerQualification (PractitionerID, Identifier, Code, PeriodStart, PeriodEnd, Issuer)
VALUES
(1, 'Q123', 'MD', '2005-01-01', '2010-01-01', 'Medical Board A'),
(2, 'Q456', 'DO', '2008-02-01', '2012-03-01', 'Medical Board B'),
(3, 'Q789', 'NP', '2010-05-01', '2015-06-01', 'Nursing Board C'),
(4, 'Q101', 'MD', '1998-03-01', '2003-04-01', 'Medical Board D'),
(5, 'Q202', 'DO', '2002-06-01', '2007-07-01', 'Medical Board E'),
(6, 'Q303', 'PA', '2015-09-01', '2020-10-01', 'Physician Assistant Board F'),
(7, 'Q404', 'NP', '2006-12-01', '2011-01-01', 'Nursing Board G'),
(8, 'Q505', 'MD', '2011-02-01', '2016-03-01', 'Medical Board H'),
(9, 'Q606', 'DO', '2004-08-01', '2009-09-01', 'Medical Board I'),
(10, 'Q707', 'PA', '2000-11-01', '2005-12-01', 'Physician Assistant Board J');


-- PractitionerCommunication Table
INSERT INTO PractitionerCommunication (PractitionerID, Language, Preferred)
VALUES
(1, 'English', true),
(2, 'Spanish', true),
(3, 'French', false),
(4, 'German', true),
(5, 'Chinese', false),
(6, 'Japanese', true),
(7, 'Korean', false),
(8, 'Arabic', true),
(9, 'Russian', false),
(10, 'Italian', true);

-- Organization Table
INSERT INTO Organization (Active, Type, Name, Alias, Telecom, Address, PartOf)
VALUES
(true, 'Hospital', 'City General Hospital', 'City GH', '+1234567890', '123 Medical Center Dr, Cityville', NULL),
(true, 'Clinic', 'Town Family Clinic', 'Town FC', 'town.clinic@example.com', '456 Health Plaza, Townsville', NULL),
(true, 'Health Center', 'Village Health Center', 'Village HC', '+9876543210', '789 Wellness St, Villagetown', NULL),
(true, 'Medical Center', 'City Medical Center', 'City MC', 'city.medical@example.com', '321 Health Circle, Cityopolis', NULL),
(true, 'Hospital', 'Town Regional Hospital', 'Town RH', '+2345678901', '543 Healthcare Ave, Townberg', NULL),
(true, 'Clinic', 'City Wellness Clinic', 'City WC', 'city.wellness@example.com', '876 Wellness Blvd, Cityburg', NULL),
(true, 'Health Center', 'Village Medical Hub', 'Village MH', '+3456789012', '234 Health Lane, Villageville', NULL),
(true, 'Medical Center', 'Town Medical Center', 'Town MC', 'town.medical@example.com', '567 Health Road, Citytown', NULL),
(true, 'Hospital', 'Village General Hospital', 'Village GH', '+4567890123', '890 Healthcare St, Villagetown', NULL),
(true, 'Clinic', 'City Family Clinic', 'City FC', 'city.clinic@example.com', '123 Wellness Blvd, Townopolis', NULL);


-- PractitionerRole Table
INSERT INTO PractitionerRole (PractitionerID, OrganizationID, Code, Specialty, Location, HealthcareService, AvailableTime, NotAvailable, AvailableStartTime, AvailableEndTime)
VALUES
(1, 1, 'Doctor', 'Internal Medicine', 'Room 101', 'Primary Care', 'Monday-Friday 9:00 AM - 5:00 PM', 'Saturday-Sunday', '09:00:00', '17:00:00'),
(2, 2, 'Nurse', 'Family Medicine', 'Room 201', 'Wellness Checks', 'Monday-Wednesday 8:00 AM - 4:00 PM', 'Thursday-Friday', '08:00:00', '16:00:00'),
(3, 3, 'Doctor', 'Pediatrics', 'Room 301', 'Pediatric Care', 'Tuesday-Thursday 10:00 AM - 6:00 PM', 'Monday, Friday', '10:00:00', '18:00:00'),
(4, 4, 'Nurse', 'Cardiology', 'Room 401', 'Cardiac Services', 'Wednesday-Friday 8:30 AM - 4:30 PM', 'Monday-Tuesday', '08:30:00', '16:30:00'),
(5, 5, 'Doctor', 'Dermatology', 'Room 501', 'Dermatological Care', 'Monday-Wednesday 9:30 AM - 5:30 PM', 'Thursday-Friday', '09:30:00', '17:30:00'),
(6, 6, 'Nurse', 'Orthopedics', 'Room 601', 'Orthopedic Services', 'Thursday-Friday 8:30 AM - 4:30 PM', 'Monday-Wednesday', '08:30:00', '16:30:00');

-- Problem Table
INSERT INTO Problem (PatientID, AsserterID, DateRecorded, Code, Category, ClinicalStatus, VerificationStatus, Severity, OnsetDateTime, AbatementDateTime, BodySite, Note)
VALUES
(1, 1, '2022-02-01', '12345', 'Diagnosis', 'Active', 'Confirmed', 'Moderate', '2022-01-15 08:00:00', NULL, 'Head', 'Patient has a headache'),
(2, 2, '2022-02-05', '54321', 'Symptom', 'Resolved', 'Confirmed', 'Mild', '2022-01-20 10:30:00', '2022-02-01 15:45:00', 'Chest', 'Patient experienced chest pain'),
(3, 3, '2022-02-10', '67890', 'Diagnosis', 'Active', 'Provisional', 'Severe', '2022-02-01 12:15:00', NULL, 'Abdomen', 'Patient has abdominal pain'),
(4, 4, '2022-02-15', '09876', 'Diagnosis', 'Active', 'Confirmed', 'Moderate', '2022-02-05 09:45:00', NULL, 'Back', 'Patient has lower back pain'),
(5, 5, '2022-02-20', '13579', 'Symptom', 'Active', 'Differential', 'Mild', '2022-02-10 14:00:00', NULL, 'Leg', 'Patient reports leg pain'),
(6, 6, '2022-02-25', '24680', 'Diagnosis', 'Active', 'Confirmed', 'Moderate', '2022-02-15 11:30:00', NULL, 'Arm', 'Patient has arm pain'),
(7, 7, '2022-03-01', '98765', 'Symptom', 'Resolved', 'Confirmed', 'Mild', '2022-02-20 13:45:00', '2022-03-01 16:30:00', 'Head', 'Patient had a headache'),
(8, 8, '2022-03-05', '54321', 'Diagnosis', 'Active', 'Provisional', 'Severe', '2022-02-25 10:00:00', NULL, 'Abdomen', 'Patient has severe abdominal pain'),
(9, 9, '2022-03-10', '67890', 'Diagnosis', 'Active', 'Confirmed', 'Moderate', '2022-03-01 12:30:00', NULL, 'Back', 'Patient has upper back pain'),
(10, 10, '2022-03-15', '09876', 'Symptom', 'Active', 'Confirmed', 'Mild', '2022-03-05 09:15:00', NULL, 'Leg', 'Patient reports mild leg pain');


-- FamilyMemberHistory Table
INSERT INTO FamilyMemberHistory (PatientID, Date, Status, Name, Relationship, Gender, BornDate, Age, DeceasedBoolean, DeceasedDate, Note)
VALUES
(1, '2022-01-01', 'Completed', 'John Doe', 'Father', 'Male', '1950-05-12', 72, false, NULL, 'Patient\'s father'),
(2, '2022-01-02', 'Completed', 'Jane Smith', 'Mother', 'Female', '1955-08-25', 67, false, NULL, 'Patient\'s mother'),
(3, '2022-01-03', 'Completed', 'Alex Taylor Jr.', 'Sibling', 'Male', '1980-03-18', 42, false, NULL, 'Patient\'s sibling'),
(4, '2022-01-04', 'Completed', 'Mia Williams', 'Spouse', 'Female', '1982-07-02', 39, false, NULL, 'Patient\'s spouse'),
(5, '2022-01-05', 'Completed', 'Mark Anderson Sr.', 'Grandparent', 'Male', '1930-11-05', 91, false, NULL, 'Patient\'s grandfather'),
(6, '2022-01-06', 'Completed', 'Olivia Brown', 'Spouse', 'Female', '1988-12-20', 33, false, NULL, 'Patient\'s spouse'),
(7, '2022-01-07', 'Completed', 'Jake Davis', 'Sibling', 'Male', '1985-06-08', 36, false, NULL, 'Patient\'s sibling'),
(8, '2022-01-08', 'Completed', 'Emma Wilson', 'Grandparent', 'Female', '1925-03-15', 97, false, NULL, 'Patient\'s grandmother'),
(9, '2022-01-09', 'Completed', 'Grace Martin', 'Aunt', 'Female', '1970-09-30', 52, false, NULL, 'Patient\'s aunt'),
(10, '2022-01-10', 'Completed', 'Luke Clark', 'Uncle', 'Male', '1965-04-12', 57, false, NULL, 'Patient\'s uncle');


-- Family Member Condition Table
INSERT INTO FamilyMemberCondition (FamilyMemberHistoryID, ConditionCode, Outcome, OnsetAge, Note)
VALUES
(1, '12345', 'Deceased', 82, 'Heart disease'),
(2, '54321', 'Recovered', 60, 'Breast cancer'),
(3, '67890', 'Alive', NULL, 'No major health issues'),
(4, '09876', 'Deceased', 65, 'Lung cancer'),
(5, '13579', 'Deceased', 88, 'Stroke'),
(6, '24680', 'Alive', NULL, 'No major health issues'),
(7, '98765', 'Recovered', 55, 'Car accident'),
(8, '54321', 'Alive', NULL, 'No major health issues'),
(9, '67890', 'Deceased', 80, 'Alzheimer\'s disease'),
(10, '09876', 'Alive', NULL, 'No major health issues');

-- Clinical Impression Table
INSERT INTO ClinicalImpression (PatientID, AssessorID, Date, Status, Description, EffectiveDateTime)
VALUES
(3, 3, '2022-02-10 13:45:00', 'Completed', 'Initial assessment for pediatrics', '2022-02-01 12:15:00'),
(4, 4, '2022-02-15 09:00:00', 'In-progress', 'Follow-up assessment for cardiology', '2022-02-05 09:45:00'),
(5, 5, '2022-02-20 14:15:00', 'Completed', 'Initial assessment for dermatology', '2022-02-10 14:00:00'),
(6, 6, '2022-02-25 12:30:00', 'In-progress', 'Follow-up assessment for orthopedics', '2022-02-15 11:30:00'),
(7, 7, '2022-03-01 13:45:00', 'Completed', 'Initial assessment for obstetrics and gynecology', '2022-02-20 13:45:00'),
(8, 8, '2022-03-05 09:15:00', 'In-progress', 'Follow-up assessment for urology', '2022-02-25 10:00:00'),
(9, 9, '2022-03-10 11:30:00', 'Completed', 'Initial assessment for neurology', '2022-03-01 12:30:00'),
(10, 10, '2022-03-15 08:45:00', 'In-progress', 'Follow-up assessment for psychiatry', '2022-03-05 09:15:00');


-- Clinical Impression Table
INSERT INTO ClinicalImpression (PatientID, AssessorID, Date, Status, Description, EffectiveDateTime)
VALUES 
(3, 3, '2022-02-10 13:45:00', 'Completed', 'Initial assessment for pediatrics', '2022-02-01 12:15:00'),
(4, 4, '2022-02-15 09:00:00', 'In-progress', 'Follow-up assessment for cardiology', '2022-02-05 09:45:00'),
(5, 5, '2022-02-20 14:15:00', 'Completed', 'Initial assessment for dermatology', '2022-02-10 14:00:00'),
(6, 6, '2022-02-25 12:30:00', 'In-progress', 'Follow-up assessment for orthopedics', '2022-02-15 11:30:00'),
(7, 7, '2022-03-01 13:45:00', 'Completed', 'Initial assessment for obstetrics and gynecology', '2022-02-20 13:45:00'),
(8, 8, '2022-03-05 09:15:00', 'In-progress', 'Follow-up assessment for urology', '2022-02-25 10:00:00'),
(9, 9, '2022-03-10 11:30:00', 'Completed', 'Initial assessment for neurology', '2022-03-01 12:30:00'),
(10, 10, '2022-03-15 08:45:00', 'In-progress', 'Follow-up assessment for psychiatry', '2022-03-05 09:15:00');

-- Clinical Impression Finding Table
INSERT INTO clinicalimpressionfinding (ClinicalImpressionID, ItemCode, ItemReference, Basis)
VALUES
(1, '12345', 1, 'Patient has a headache'),
(2, '54321', 2, 'Patient experienced chest pain'),
(3, '67890', 3, 'Patient has abdominal pain'),
(4, '09876', 4, 'Patient has lower back pain'),
(5, '13579', 5, 'Patient reports leg pain'),
(6, '24680', 6, 'Patient has arm pain'),
(7, '98765', 7, 'Patient had a headache'),
(8, '54321', 8, 'Patient has severe abdominal pain'),
(9, '67890', 9, 'Patient has upper back pain'),
(10, '09876', 10, 'Patient reports mild leg pain');

-- Detected Issue Table
INSERT INTO DetectedIssue (PatientID, AuthorID, Code, Severity, Detail, DateDetected, Mitigation)
VALUES
(1, 1, '12345', 'High', 'Patient has a headache', '2022-01-15 08:00:00', 'Patient was prescribed pain medication'),
(2, 2, '54321', 'Low', 'Patient experienced chest pain', '2022-01-20 10:30:00', 'Patient was prescribed pain medication'),
(3, 3, '67890', 'High', 'Patient has abdominal pain', '2022-02-01 12:15:00', 'Patient was prescribed pain medication'),
(4, 4, '09876', 'High', 'Patient has lower back pain', '2022-02-05 09:45:00', 'Patient was prescribed pain medication'),
(5, 5, '13579', 'Low', 'Patient reports leg pain', '2022-02-10 14:00:00', 'Patient was prescribed pain medication'),
(6, 6, '24680', 'High', 'Patient has arm pain', '2022-02-15 11:30:00', 'Patient was prescribed pain medication'),
(7, 7, '98765', 'Low', 'Patient had a headache', '2022-02-20 13:45:00', 'Patient was prescribed pain medication'),
(8, 8, '54321', 'High', 'Patient has severe abdominal pain', '2022-02-25 10:00:00', 'Patient was prescribed pain medication'),
(9, 9, '67890', 'High', 'Patient has upper back pain', '2022-03-01 12:30:00', 'Patient was prescribed pain medication'),
(10, 10, '09876', 'Low', 'Patient reports mild leg pain', '2022-03-05 09:15:00', 'Patient was prescribed pain medication');

-- Observation Table, Consent Table and Consent Provision Tables not yet done