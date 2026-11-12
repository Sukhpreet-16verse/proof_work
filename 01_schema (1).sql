-- ======================================================
-- 01_schema.sql
-- Freelance Project Management System
-- Final Professional - Team Compatible
-- MySQL 8.0+
-- ======================================================
drop database if exists proofwork_db;
create database proofwork_db;
use proofwork_db;

CREATE TABLE Users (
  user_id INT AUTO_INCREMENT PRIMARY KEY,
  full_name VARCHAR(100) NOT NULL,
  email VARCHAR(100) UNIQUE NOT NULL,
  phone VARCHAR(20) UNIQUE NOT NULL,
  password_hash VARCHAR(255),
  role ENUM('Freelancer', 'Client', 'admin') NOT NULL,
  city VARCHAR(100) NOT NULL,
  linkedin_url VARCHAR(255),
  trust_score DECIMAL(5,2) DEFAULT 0.00,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE Organizations (
  org_id INT AUTO_INCREMENT PRIMARY KEY,
  org_name VARCHAR(100) NOT NULL,
  industry VARCHAR(100) NOT NULL,
  gst_no VARCHAR(15) UNIQUE,
  website VARCHAR(255),
  city VARCHAR(100) NOT NULL,
  owner_id INT NOT NULL,
  FOREIGN KEY (owner_id) REFERENCES Users(user_id) ON DELETE CASCADE
);

CREATE TABLE Projects (
  project_id INT AUTO_INCREMENT PRIMARY KEY,
  client_id INT,
  title VARCHAR(150) NOT NULL,
  description TEXT,
  category VARCHAR(50),
  budget INT,
  status VARCHAR(50) DEFAULT 'Open',
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (client_id) REFERENCES Users(user_id) ON DELETE SET NULL
);

CREATE TABLE Skills (
  skill_id INT AUTO_INCREMENT PRIMARY KEY,
  skill_name VARCHAR(50) UNIQUE NOT NULL,
  category VARCHAR(50)
);

CREATE TABLE UserSkills (
  user_id INT,
  skill_id INT,
  proficiency_level VARCHAR(20),
  experience_years INT,
  PRIMARY KEY (user_id, skill_id),
  FOREIGN KEY (user_id) REFERENCES Users(user_id) ON DELETE CASCADE,
  FOREIGN KEY (skill_id) REFERENCES Skills(skill_id) ON DELETE CASCADE
);

CREATE TABLE Applications (
  application_id INT AUTO_INCREMENT PRIMARY KEY,
  project_id INT NOT NULL,
  user_id INT NOT NULL,
  status VARCHAR(20) DEFAULT 'pending',
  applied_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  UNIQUE KEY unique_application (project_id, user_id),
  FOREIGN KEY (project_id) REFERENCES Projects(project_id) ON DELETE CASCADE,
  FOREIGN KEY (user_id) REFERENCES Users(user_id) ON DELETE CASCADE
);

CREATE TABLE Milestones (
  milestone_id INT AUTO_INCREMENT PRIMARY KEY,
  project_id INT,
  title VARCHAR(100),
  due_date DATE,
  FOREIGN KEY (project_id) REFERENCES Projects(project_id) ON DELETE CASCADE
);

CREATE TABLE Submissions (
  submission_id INT AUTO_INCREMENT PRIMARY KEY,
  project_id INT NOT NULL,
  user_id INT NOT NULL,
  file_url VARCHAR(255),
  version_no INT DEFAULT 1,
  submitted_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (project_id) REFERENCES Projects(project_id) ON DELETE CASCADE,
  FOREIGN KEY (user_id) REFERENCES Users(user_id) ON DELETE CASCADE
);

CREATE TABLE Reviews (
  review_id INT AUTO_INCREMENT PRIMARY KEY,
  project_id INT,
  reviewer_id INT,
  rating INT CHECK (rating BETWEEN 1 AND 5),
  comment TEXT,
  status ENUM('approved','rejected') DEFAULT 'approved',
  FOREIGN KEY (project_id) REFERENCES Projects(project_id) ON DELETE CASCADE,
  FOREIGN KEY (reviewer_id) REFERENCES Users(user_id) ON DELETE SET NULL
);

CREATE TABLE Transactions (
  transaction_id INT AUTO_INCREMENT PRIMARY KEY,
  project_id INT,
  user_id INT,
  amount DECIMAL(10,2) NOT NULL,
  status ENUM('pending','success','failed') DEFAULT 'success',
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (project_id) REFERENCES Projects(project_id) ON DELETE CASCADE,
  FOREIGN KEY (user_id) REFERENCES Users(user_id) ON DELETE SET NULL
);

CREATE TABLE VerifiedExperience (
  ve_id INT AUTO_INCREMENT PRIMARY KEY,
  user_id INT,
  project_id INT UNIQUE,
  certificate_url VARCHAR(255),
  issued_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (user_id) REFERENCES Users(user_id) ON DELETE CASCADE,
  FOREIGN KEY (project_id) REFERENCES Projects(project_id) ON DELETE CASCADE
);
