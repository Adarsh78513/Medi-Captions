show databases;
show tables;
-- Create the database
CREATE DATABASE FHIRDatabase;

-- Use the created database
USE FHIRDatabase;

-- patient
CREATE TABLE Patient (
    PatientID INT AUTO_INCREMENT PRIMARY KEY,
    Active BOOLEAN,
    Gender VARCHAR(50),
    BirthDate DATE,
    DeceasedBoolean BOOLEAN,
    DeceasedDateTime DATETIME,
    MaritalStatus VARCHAR(255),  -- Consider coding system
    MultipleBirthBoolean BOOLEAN,
    MultipleBirthInteger INT,
    Photo TEXT  -- URL or binary data
);

CREATE TABLE PatientName (
    NameID INT AUTO_INCREMENT PRIMARY KEY,
    PatientID INT,
    FamilyName VARCHAR(255),
    GivenName VARCHAR(255),
    MiddleName VARCHAR(255),
    Prefix VARCHAR(100),
    Suffix VARCHAR(100),
    UsageType VARCHAR(100),  -- official, temp, nickname, etc.
    FOREIGN KEY (PatientID) REFERENCES Patient(PatientID)
);

CREATE TABLE PatientTelecom (
    TelecomID INT AUTO_INCREMENT PRIMARY KEY,
    PatientID INT,
    SystemType VARCHAR(100),  -- phone, email, etc.
    Value VARCHAR(255),
    UsageType VARCHAR(100),  -- home, work, mobile, etc.
    PreferenceOrder INT,
    FOREIGN KEY (PatientID) REFERENCES Patient(PatientID)
);

CREATE TABLE PatientAddress (
    AddressID INT AUTO_INCREMENT PRIMARY KEY,
    PatientID INT,
    UsageType VARCHAR(100),  -- home, work, etc.
    Type VARCHAR(100),  -- postal, physical, both
    Text TEXT,
    Line TEXT,
    City VARCHAR(255),
    District VARCHAR(255),
    State VARCHAR(255),
    PostalCode VARCHAR(100),
    Country VARCHAR(255),
    PeriodStart DATE,
    PeriodEnd DATE,
    FOREIGN KEY (PatientID) REFERENCES Patient(PatientID)
);

CREATE TABLE PatientContact (
    ContactID INT AUTO_INCREMENT PRIMARY KEY,
    PatientID INT,
    Relationship VARCHAR(255),  -- code or text
    Name VARCHAR(255),
    Telecom TEXT,  -- Consider creating a separate structure
    Address TEXT,  -- Consider creating a separate structure
    Gender VARCHAR(50),
    Organization VARCHAR(255),
    PeriodStart DATE,
    PeriodEnd DATE,
    FOREIGN KEY (PatientID) REFERENCES Patient(PatientID)
);

CREATE TABLE PatientCommunication (
    CommunicationID INT AUTO_INCREMENT PRIMARY KEY,
    PatientID INT,
    Language VARCHAR(255),  -- Code for language
    Preferred BOOLEAN,
    FOREIGN KEY (PatientID) REFERENCES Patient(PatientID)
);

-- Practitioner

CREATE TABLE Practitioner (
    PractitionerID INT AUTO_INCREMENT PRIMARY KEY,
    Active BOOLEAN,
    Gender VARCHAR(50),
    BirthDate DATE,
    Photo TEXT  -- URL or binary data
);

CREATE TABLE PractitionerName (
    NameID INT AUTO_INCREMENT PRIMARY KEY,
    PractitionerID INT,
    FamilyName VARCHAR(255),
    GivenName VARCHAR(255),
    MiddleName VARCHAR(255),
    Prefix VARCHAR(100),
    Suffix VARCHAR(100),
    UsageType VARCHAR(100),  -- Official, temp, nickname, etc.
    FOREIGN KEY (PractitionerID) REFERENCES Practitioner(PractitionerID)
);

CREATE TABLE PractitionerTelecom (
    TelecomID INT AUTO_INCREMENT PRIMARY KEY,
    PractitionerID INT,
    ContactSystem VARCHAR(100),  -- Phone, email, etc.
    Value VARCHAR(255),
    UsageType VARCHAR(100),  -- Home, work, mobile, etc.
    PreferenceOrder INT,
    FOREIGN KEY (PractitionerID) REFERENCES Practitioner(PractitionerID)
);

CREATE TABLE PractitionerAddress (
    AddressID INT AUTO_INCREMENT PRIMARY KEY,
    PractitionerID INT,
    UsageType VARCHAR(100),  -- Home, work, etc.
    Type VARCHAR(100),  -- Postal, physical, both
    Text TEXT,
    Line TEXT,
    City VARCHAR(255),
    District VARCHAR(255),
    State VARCHAR(255),
    PostalCode VARCHAR(100),
    Country VARCHAR(255),
    PeriodStart DATE,
    PeriodEnd DATE,
    FOREIGN KEY (PractitionerID) REFERENCES Practitioner(PractitionerID)
);

CREATE TABLE PractitionerQualification (
    QualificationID INT AUTO_INCREMENT PRIMARY KEY,
    PractitionerID INT,
    Identifier VARCHAR(255),  -- Unique ID for the qualification
    Code TEXT,  -- Type of qualification
    PeriodStart DATE,
    PeriodEnd DATE,
    Issuer VARCHAR(255),  -- Issuing organization
    FOREIGN KEY (PractitionerID) REFERENCES Practitioner(PractitionerID)
);

CREATE TABLE PractitionerCommunication (
    CommunicationID INT AUTO_INCREMENT PRIMARY KEY,
    PractitionerID INT,
    Language VARCHAR(255),  -- Code for language
    Preferred BOOLEAN,
    FOREIGN KEY (PractitionerID) REFERENCES Practitioner(PractitionerID)
);

-- Organization 
CREATE TABLE Organization (
    OrganizationID INT AUTO_INCREMENT PRIMARY KEY,
    Active BOOLEAN,
    Type VARCHAR(255),  -- Type of organization (e.g., hospital, insurance company)
    Name VARCHAR(255),
    Alias TEXT,  -- Alternative names
    Telecom TEXT,  -- Contact details, consider a separate table for complex types
    Address TEXT,  -- Address details, consider a separate table for complex types
    PartOf INT  -- Reference to a parent Organization if exists
);

-- PractitionerRole 
CREATE TABLE PractitionerRole (
    PractitionerRoleID INT AUTO_INCREMENT PRIMARY KEY,
    PractitionerID INT,
    OrganizationID INT,  -- Assuming an Organization table exists
    Code TEXT,  -- Role code (e.g., doctor, nurse)
    Specialty TEXT,  -- Practitioner's specialty
    Location TEXT,  -- Assuming a Location table exists for detailed data
    HealthcareService TEXT,  -- Assuming a HealthcareService table exists
    AvailableTime TEXT,  -- Could be detailed in another table
    NotAvailable TEXT,  -- Could be detailed in another table
    AvailableStartTime TIME,
    AvailableEndTime TIME,
    FOREIGN KEY (PractitionerID) REFERENCES Practitioner(PractitionerID),
    FOREIGN KEY (OrganizationID) REFERENCES Organization(OrganizationID)
);

-- Condition
CREATE TABLE Problem (
    ConditionID INT AUTO_INCREMENT PRIMARY KEY,
    PatientID INT,
    AsserterID INT,  -- Practitioner or Patient who asserted the condition
    DateRecorded DATE,  -- Date condition was recorded
    Code VARCHAR(255),  -- Code for the condition from a terminology system
    Category VARCHAR(255),  -- Category of condition (e.g., symptom, diagnosis)
    ClinicalStatus VARCHAR(100),  -- Active, recurrence, remission, etc.
    VerificationStatus VARCHAR(100),  -- Confirmed, differential, provisional, etc.
    Severity VARCHAR(100),  -- Severity of the condition
    OnsetDateTime DATETIME,  -- When the condition began
    AbatementDateTime DATETIME,  -- When the condition resolved
    BodySite TEXT,  -- Specific anatomical location
    Note TEXT,  -- Any additional notes about the condition
    FOREIGN KEY (PatientID) REFERENCES Patient(PatientID),
    FOREIGN KEY (AsserterID) REFERENCES Practitioner(PractitionerID)  -- or Patient
);

-- FamilyMemberHistory

CREATE TABLE FamilyMemberHistory (
    FamilyMemberHistoryID INT AUTO_INCREMENT PRIMARY KEY,
    PatientID INT,
    Date DATE,  -- Date of record entry
    Status VARCHAR(100),  -- Partial, completed, entered-in-error, health-unknown
    Name VARCHAR(255),  -- Name of the family member
    Relationship VARCHAR(255),  -- Relationship to the patient
    Gender VARCHAR(50),  -- Gender of the family member
    BornDate DATE,  -- Date of birth
    Age INT,  -- Age or age range
    DeceasedBoolean BOOLEAN,  -- Indicates if the family member is deceased
    DeceasedDate DATE,  -- Date of death, if applicable
    Note TEXT,  -- Any additional notes
    FOREIGN KEY (PatientID) REFERENCES Patient(PatientID)
);

CREATE TABLE FamilyMemberCondition (
    FamilyMemberConditionID INT AUTO_INCREMENT PRIMARY KEY,
    FamilyMemberHistoryID INT,
    ConditionCode VARCHAR(255),  -- Code for the condition from a terminology system
    Outcome VARCHAR(100),  -- Deceased, recovered, etc.
    OnsetAge INT,  -- Age at onset
    Note TEXT,  -- Any additional notes about the condition
    FOREIGN KEY (FamilyMemberHistoryID) REFERENCES FamilyMemberHistory(FamilyMemberHistoryID)
);


-- ClinicalImpression
CREATE TABLE ClinicalImpression (
    ClinicalImpressionID INT AUTO_INCREMENT PRIMARY KEY,
    PatientID INT,
    AssessorID INT,  -- Reference to the Practitioner who made the impression
    Date DATETIME,  -- Date and time of the impression
    Status VARCHAR(100),  -- In-progress, completed, entered-in-error, etc.
    Description TEXT,  -- Description of the clinical impression
    EffectiveDateTime DATETIME,  -- The time period over which the impression was made
    FOREIGN KEY (PatientID) REFERENCES Patient(PatientID),
    FOREIGN KEY (AssessorID) REFERENCES Practitioner(PractitionerID)
);

CREATE TABLE ClinicalImpressionFinding (
    FindingID INT AUTO_INCREMENT PRIMARY KEY,
    ClinicalImpressionID INT,
    ItemCode VARCHAR(255),  -- Code for the finding from a terminology system
    ItemReference INT,  -- Reference to another resource that supports the finding
    Basis TEXT,  -- Textual explanation of the finding
    FOREIGN KEY (ClinicalImpressionID) REFERENCES ClinicalImpression(ClinicalImpressionID)
);

-- DetectedIssue

CREATE TABLE DetectedIssue (
    DetectedIssueID INT AUTO_INCREMENT PRIMARY KEY,
    PatientID INT,
    AuthorID INT,  -- Reference to the Practitioner or Device that detected the issue
    Identifier VARCHAR(255),  -- Unique identifier for the issue
    Status VARCHAR(100),  -- Registered, preliminary, final, amended, etc.
    Code VARCHAR(255),  -- Code representing the type of issue (e.g., drug interaction)
    Severity VARCHAR(100),  -- High, moderate, low
    DateDetected DATETIME,  -- Date and time the issue was identified
    Description TEXT,  -- Detailed description of the issue
    ImplicatedResource INT,  -- Reference to the resource (e.g., Medication, Device) involved in the issue
    Evidence TEXT,  -- Evidence supporting the detected issue
    Detail TEXT,  -- Textual explanation or additional details about the issue
    Reference TEXT,  -- Link or reference to additional documentation about the issue
    FOREIGN KEY (PatientID) REFERENCES Patient(PatientID),
    FOREIGN KEY (AuthorID) REFERENCES Practitioner(PractitionerID)  -- or Device
);
ALTER TABLE DetectedIssue
ADD COLUMN Mitigation TEXT;

-- Consent

CREATE TABLE Consent (
    ConsentID INT AUTO_INCREMENT PRIMARY KEY,
    PatientID INT,
    Status VARCHAR(100),  -- Active, inactive, entered-in-error, etc.
    Scope VARCHAR(255),  -- Scope of the consent (e.g., treatment, research)
    Category VARCHAR(255),  -- Consent category (e.g., patient privacy, data sharing)
    DateTime DATETIME,  -- Date and time of consent
    Performer INT,  -- Reference to the organization or person who obtained consent
    OrganizationID INT,  -- Reference to the organization that manages the consent
    SourceAttachment TEXT,  -- Attachment or document representing the consent
    PolicyRule VARCHAR(255),  -- URI of the policy rule
    FOREIGN KEY (PatientID) REFERENCES Patient(PatientID),
    FOREIGN KEY (Performer) REFERENCES Practitioner(PractitionerID),
    FOREIGN KEY (OrganizationID) REFERENCES Organization(OrganizationID)
);

CREATE TABLE ConsentProvision (
    ProvisionID INT AUTO_INCREMENT PRIMARY KEY,
    ConsentID INT,
    Type VARCHAR(100),  -- Deny or permit
    PeriodStart DATE,  -- Start of the relevant period
    PeriodEnd DATE,  -- End of the relevant period
    ActorRole VARCHAR(255),  -- Role of the actor in the consent
    ActorReference INT,  -- Reference to the actor (Practitioner, Organization, etc.)
    Action VARCHAR(255),  -- Actions allowed or denied
    DataClass VARCHAR(255),  -- Class of data covered
    Purpose VARCHAR(255),  -- Purpose of the data use (e.g., research, treatment)
    FOREIGN KEY (ConsentID) REFERENCES Consent(ConsentID)
);

